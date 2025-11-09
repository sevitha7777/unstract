class TextractConstants:
    """Constants for AWS Textract adapter."""
    
    # Feature types
    TABLES = "TABLES"
    FORMS = "FORMS"
    QUERIES = "QUERIES"
    SIGNATURES = "SIGNATURES"
    LAYOUT = "LAYOUT"
    
    # Output formats
    TEXT_FORMAT = "text"
    STRUCTURED_FORMAT = "structured"
    
    # Block types
    BLOCK_TYPE_LINE = "LINE"
    BLOCK_TYPE_WORD = "WORD"
    BLOCK_TYPE_TABLE = "TABLE"
    BLOCK_TYPE_CELL = "CELL"
    BLOCK_TYPE_KEY_VALUE_SET = "KEY_VALUE_SET"
    
    # Relationship types
    CHILD = "CHILD"
    VALUE = "VALUE"