# AWS Textract X2Text Adapter

This adapter integrates AWS Textract document analysis service with Unstract for text extraction from documents.

## Features

- Extract text from PDFs, images, and other document formats
- Support for tables, forms, queries, signatures, and layout analysis
- Configurable output formats (plain text or structured JSON)
- AWS region selection
- Secure credential management

## Configuration

Required parameters:
- **AWS Access Key ID**: AWS credentials with Textract permissions
- **AWS Secret Access Key**: Corresponding secret key
- **AWS Region**: AWS region for Textract service

Optional parameters:
- **Feature Types**: Enable specific Textract features (TABLES, FORMS, QUERIES, SIGNATURES, LAYOUT)
- **Output Format**: Choose between plain text or structured JSON output

## AWS Permissions

The AWS credentials must have the following permissions:
- `textract:DetectDocumentText`
- `textract:AnalyzeDocument`
- `textract:GetDocumentTextDetection` (for connection testing)

## Supported File Types

AWS Textract supports:
- PDF documents
- PNG images
- JPEG images
- TIFF images

## Usage

1. Configure the adapter with your AWS credentials
2. Select desired feature types for analysis
3. Choose output format based on your needs
4. The adapter will process documents and return extracted text