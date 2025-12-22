# Content Types

Set the Content-Type header for your mocked responses.

## Built-in Content Types

HTTP Mock Lib provides semantic methods for common content types.

### contentTypeJson()

```apex
HttpMock contentTypeJson()  // application/json
```

Default content type. Used for JSON responses.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .contentTypeJson()
  .mock();
```

### contentTypePlainText()

```apex
HttpMock contentTypePlainText()  // text/plain
```

Plain text responses.

```apex
new HttpMock()
  .whenGetOn('/api/status')
  .body('Service is running')
  .contentTypePlainText()
  .mock();
```

### contentTypeHtml()

```apex
HttpMock contentTypeHtml()  // text/html
```

HTML responses.

```apex
new HttpMock()
  .whenGetOn('/api/page')
  .body('<html><body><h1>Hello</h1></body></html>')
  .contentTypeHtml()
  .mock();
```

### contentTypeCsv()

```apex
HttpMock contentTypeCsv()  // text/csv
```

CSV data responses.

```apex
new HttpMock()
  .whenGetOn('/api/export/users.csv')
  .body('id,name,email\n1,John,john@example.com\n2,Jane,jane@example.com')
  .contentTypeCsv()
  .header('Content-Disposition', 'attachment; filename="users.csv"')
  .mock();
```

### contentTypeXml()

```apex
HttpMock contentTypeXml()  // application/xml
```

XML responses.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('<?xml version="1.0"?><users><user id="1">John</user></users>')
  .contentTypeXml()
  .mock();
```

### contentTypePdf()

```apex
HttpMock contentTypePdf()  // application/pdf
```

PDF document responses.

```apex
Blob pdfData = generatePdfContent();

new HttpMock()
  .whenGetOn('/api/report.pdf')
  .body(pdfData)
  .contentTypePdf()
  .mock();
```

### contentTypeFormUrlencoded()

```apex
HttpMock contentTypeFormUrlencoded()  // application/x-www-form-urlencoded
```

Form-encoded data.

```apex
new HttpMock()
  .whenPostOn('/api/login')
  .body('username=john&password=secret')
  .contentTypeFormUrlencoded()
  .mock();
```

## Custom Content Type

For content types not covered by built-in methods:

```apex
HttpMock contentType(String contentType)
```

**Examples:**

```apex
// YAML
new HttpMock()
  .whenGetOn('/api/config')
  .body('key: value\nlist:\n  - item1\n  - item2')
  .contentType('application/x-yaml')
  .mock();

// Protocol Buffers
new HttpMock()
  .whenGetOn('/api/data')
  .body(protobufBlob)
  .contentType('application/protobuf')
  .mock();

// Custom vendor type
new HttpMock()
  .whenGetOn('/api/custom')
  .body('{"data": {}}')
  .contentType('application/vnd.mycompany.v1+json')
  .mock();
```

## Default Content Type

If not specified, HTTP Mock Lib uses `application/json`:

```apex
// These are equivalent:
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .mock();

new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .contentTypeJson()  // Explicitly set
  .mock();
```

## Content Type Reference

| Content Type | Method | Usage |
|-------------|--------|-------|
| `application/json` | `contentTypeJson()` | JSON data (default) |
| `text/plain` | `contentTypePlainText()` | Plain text |
| `text/html` | `contentTypeHtml()` | HTML documents |
| `text/csv` | `contentTypeCsv()` | CSV data |
| `application/xml` | `contentTypeXml()` | XML data |
| `application/pdf` | `contentTypePdf()` | PDF documents |
| `application/x-www-form-urlencoded` | `contentTypeFormUrlencoded()` | Form data |
| Custom | `contentType(String)` | Any MIME type |

## Examples

### JSON API Response

```apex
new HttpMock()
  .whenGetOn('/api/v1/users')
  .body('{"users": [], "total": 0}')
  .contentTypeJson()
  .statusCodeOk()
  .mock();
```

### CSV Export

```apex
String csvData = 'Name,Email,Status\n' +
                 'John Doe,john@example.com,Active\n' +
                 'Jane Smith,jane@example.com,Active';

new HttpMock()
  .whenGetOn('/api/export')
  .body(csvData)
  .contentTypeCsv()
  .header('Content-Disposition', 'attachment; filename="export.csv"')
  .statusCodeOk()
  .mock();
```

### XML SOAP Response

```apex
String soapResponse =
  '<?xml version="1.0"?>' +
  '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
    '<soap:Body>' +
      '<Response>Success</Response>' +
    '</soap:Body>' +
  '</soap:Envelope>';

new HttpMock()
  .whenPostOn('/soap/endpoint')
  .body(soapResponse)
  .contentType('application/soap+xml')
  .statusCodeOk()
  .mock();
```

### Binary File Download

```apex
Blob fileContent = Blob.valueOf('File content');

new HttpMock()
  .whenGetOn('/api/download/document.pdf')
  .body(fileContent)
  .contentTypePdf()
  .header('Content-Length', String.valueOf(fileContent.size()))
  .header('Content-Disposition', 'attachment; filename="document.pdf"')
  .statusCodeOk()
  .mock();
```

## Best Practices

1. **Match Real APIs** - Use the same content type as the actual API

2. **Set Explicitly** - Even though JSON is default, explicitly set content type for clarity

3. **Use with Headers** - Combine with other headers like `Content-Disposition` for downloads

4. **Validate Format** - Ensure your body format matches the content type

## Common Patterns

### API with Multiple Formats

```apex
// JSON endpoint
new HttpMock()
  .whenGetOn('/api/data?format=json')
  .body('{"data": []}')
  .contentTypeJson()
  .mock();

// XML endpoint
new HttpMock()
  .whenGetOn('/api/data?format=xml')
  .body('<?xml version="1.0"?><data></data>')
  .contentTypeXml()
  .mock();
```

### File Upload Response

```apex
new HttpMock()
  .whenPostOn('/api/upload')
  .body('{"fileId": "abc123", "url": "https://cdn.example.com/abc123"}')
  .contentTypeJson()
  .statusCodeCreated()
  .header('Location', '/api/files/abc123')
  .mock();
```

## See Also

- [Response Body →](/api/response-body)
- [Headers →](/api/headers)
- [Examples →](/examples/basic)
