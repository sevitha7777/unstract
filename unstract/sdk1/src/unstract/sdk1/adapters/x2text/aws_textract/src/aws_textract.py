from __future__ import annotations

import json
import logging
import os
from typing import TYPE_CHECKING, Any

from unstract.sdk1.adapters.exceptions import AdapterError
from unstract.sdk1.adapters.x2text.aws_textract.src.constants import TextractConstants
from unstract.sdk1.adapters.x2text.dto import TextExtractionResult
from unstract.sdk1.adapters.x2text.x2text_adapter import X2TextAdapter
from unstract.sdk1.file_storage import FileStorage, FileStorageProvider

if TYPE_CHECKING:
    import boto3

logger = logging.getLogger(__name__)


class AWSTextract(X2TextAdapter):
    def __init__(self, settings: dict[str, Any]) -> None:
        """Initialize the AWS Textract text extraction adapter.

        Args:
            settings: Configuration dictionary containing AWS credentials and settings
        """
        super().__init__("AWSTextract")
        self.config = settings
        self._client = None

    SCHEMA_PATH = f"{os.path.dirname(__file__)}/static/json_schema.json"

    @staticmethod
    def get_id() -> str:
        return "aws-textract|b7f8c9d0-4e2f-5b91-c117-e128f9e78g04"

    @staticmethod
    def get_name() -> str:
        return "AWS Textract"

    @staticmethod
    def get_description() -> str:
        return "AWS Textract document analysis service for text extraction"

    @staticmethod
    def get_icon() -> str:
        return "/icons/adapter-icons/AWSTextract.png"

    @property
    def client(self):
        """Lazy initialization of AWS Textract client."""
        if self._client is None:
            try:
                import boto3
                self._client = boto3.client(
                    'textract',
                    aws_access_key_id=self.config.get('aws_access_key_id'),
                    aws_secret_access_key=self.config.get('aws_secret_access_key'),
                    region_name=self.config.get('aws_region', 'us-east-1')
                )
            except ImportError:
                raise ImportError("boto3 is required for AWS Textract adapter. Install with: pip install boto3")
            except Exception as e:
                raise AdapterError(f"Failed to initialize AWS Textract client: {str(e)}")
        return self._client

    def test_connection(self) -> bool:
        """Test connection to AWS Textract service."""
        try:
            # Check if credentials are provided
            if not all([self.config.get('aws_access_key_id'), self.config.get('aws_secret_access_key')]):
                raise AdapterError("AWS credentials are required")
            
            # Test credentials by calling a simple AWS STS operation
            import boto3
            sts_client = boto3.client(
                'sts',
                aws_access_key_id=self.config.get('aws_access_key_id'),
                aws_secret_access_key=self.config.get('aws_secret_access_key'),
                region_name=self.config.get('aws_region', 'us-east-1')
            )
            
            # This will fail immediately with invalid credentials
            sts_client.get_caller_identity()
            
            # If STS works, test Textract service availability
            # Use a minimal operation that doesn't require a document
            try:
                self.client.list_adapters(MaxResults=1)
            except Exception as textract_e:
                # If list_adapters fails, try a different approach
                if "AccessDenied" in str(textract_e):
                    # Credentials work but no Textract permissions
                    raise AdapterError(f"AWS credentials valid but missing Textract permissions: {str(textract_e)}")
                elif "UnauthorizedOperation" in str(textract_e) or "InvalidAction" in str(textract_e):
                    # Service exists but operation not allowed - credentials are valid
                    return True
                else:
                    # Other Textract-specific error
                    raise AdapterError(f"Textract service error: {str(textract_e)}")
            
            return True
            
        except Exception as e:
            if "InvalidUserID.NotFound" in str(e) or "SignatureDoesNotMatch" in str(e) or "InvalidAccessKeyId" in str(e):
                raise AdapterError(f"Invalid AWS credentials: {str(e)}")
            elif "AccessDenied" in str(e):
                raise AdapterError(f"AWS credentials valid but insufficient permissions: {str(e)}")
            else:
                logger.error(f"AWS Textract connection test failed: {e}")
                raise AdapterError(f"AWS connection failed: {str(e)}") from e

    def _extract_text_from_blocks(self, blocks: list[dict]) -> str:
        """Extract plain text from Textract blocks."""
        text_lines = []
        
        for block in blocks:
            if block['BlockType'] == TextractConstants.BLOCK_TYPE_LINE:
                text_lines.append(block.get('Text', ''))
        
        return '\n'.join(text_lines)

    def _extract_structured_data(self, blocks: list[dict]) -> dict:
        """Extract structured data including tables and key-value pairs."""
        result = {
            'text': self._extract_text_from_blocks(blocks),
            'tables': [],
            'key_value_pairs': {}
        }
        
        # Extract tables
        tables = [block for block in blocks if block['BlockType'] == TextractConstants.BLOCK_TYPE_TABLE]
        for table in tables:
            table_data = self._extract_table_data(blocks, table)
            result['tables'].append(table_data)
        
        # Extract key-value pairs
        key_value_sets = [block for block in blocks if block['BlockType'] == TextractConstants.BLOCK_TYPE_KEY_VALUE_SET]
        result['key_value_pairs'] = self._extract_key_value_pairs(blocks, key_value_sets)
        
        return result

    def _extract_table_data(self, blocks: list[dict], table_block: dict) -> list[list[str]]:
        """Extract table data from Textract blocks."""
        # This is a simplified implementation
        # In a full implementation, you'd parse the table structure properly
        return []

    def _extract_key_value_pairs(self, blocks: list[dict], key_value_blocks: list[dict]) -> dict:
        """Extract key-value pairs from Textract blocks."""
        # This is a simplified implementation
        # In a full implementation, you'd parse key-value relationships properly
        return {}

    def process(
        self,
        input_file_path: str,
        output_file_path: str | None = None,
        fs: FileStorage | None = None,
        **kwargs: dict[Any, Any],
    ) -> TextExtractionResult:
        """Extract text from documents using AWS Textract.

        Args:
            input_file_path: Path to file that needs to be extracted
            output_file_path: File path to write extracted text into
            fs: File storage instance

        Returns:
            TextExtractionResult: Extracted text and metadata
        """
        if fs is None:
            fs = FileStorage(provider=FileStorageProvider.LOCAL)
        
        # Read the document
        document_bytes = fs.read(path=input_file_path, mode="rb")
        
        # Get feature types from config
        feature_types = self.config.get('feature_types', [TextractConstants.TABLES, TextractConstants.FORMS])
        output_format = self.config.get('output_format', TextractConstants.TEXT_FORMAT)
        
        try:
            # Call AWS Textract
            if feature_types:
                response = self.client.analyze_document(
                    Document={'Bytes': document_bytes},
                    FeatureTypes=feature_types
                )
            else:
                response = self.client.detect_document_text(
                    Document={'Bytes': document_bytes}
                )
            
            blocks = response.get('Blocks', [])
            
            # Extract text based on output format
            if output_format == TextractConstants.STRUCTURED_FORMAT:
                extracted_data = self._extract_structured_data(blocks)
                extracted_text = json.dumps(extracted_data, indent=2)
            else:
                extracted_text = self._extract_text_from_blocks(blocks)
            
            # Write to output file if specified
            if output_file_path:
                fs.write(
                    path=output_file_path,
                    mode="w",
                    encoding="utf-8",
                    data=extracted_text,
                )
            
            return TextExtractionResult(
                extracted_text=extracted_text
            )
            
        except Exception as e:
            logger.error(f"AWS Textract processing failed: {e}")
            raise AdapterError(f"AWS Textract processing failed: {str(e)}") from e