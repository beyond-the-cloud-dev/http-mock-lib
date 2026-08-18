# Content Types

Set the Content-Type header for your mocked responses.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .contentTypeJson()
  .mock();
```

## JSON

`application/json` - Default content type.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .contentTypeJson()
  .mock();
```

## Plain Text

`text/plain`

```apex
new HttpMock()
  .whenGetOn('/api/status')
  .body('Service is running')
  .contentTypePlainText()
  .mock();
```

## HTML

`text/html`

```apex
new HttpMock()
  .whenGetOn('/api/page')
  .body('<html><body><h1>Hello</h1></body></html>')
  .contentTypeHtml()
  .mock();
```

## CSV

`text/csv`

```apex
new HttpMock()
  .whenGetOn('/api/export/users.csv')
  .body('id,name,email\n1,John,john@example.com')
  .contentTypeCsv()
  .mock();
```

## XML

`application/xml`

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('<?xml version="1.0"?><users><user id="1">John</user></users>')
  .contentTypeXml()
  .mock();
```

## PDF

`application/pdf`

```apex
Blob pdfData = generatePdfContent();

new HttpMock()
  .whenGetOn('/api/report.pdf')
  .body(pdfData)
  .contentTypePdf()
  .mock();
```

## Form URL Encoded

`application/x-www-form-urlencoded`

```apex
new HttpMock()
  .whenPostOn('/api/login')
  .body('username=john&password=secret')
  .contentTypeFormUrlencoded()
  .mock();
```

## Custom

For content types not covered by built-in methods.

```apex
new HttpMock()
  .whenGetOn('/api/config')
  .body('key: value')
  .contentType('application/x-yaml')
  .mock();
```

## Reference

| Content Type | Method |
|-------------|--------|
| `application/json` | `contentTypeJson()` |
| `text/plain` | `contentTypePlainText()` |
| `text/html` | `contentTypeHtml()` |
| `text/csv` | `contentTypeCsv()` |
| `application/xml` | `contentTypeXml()` |
| `application/pdf` | `contentTypePdf()` |
| `application/x-www-form-urlencoded` | `contentTypeFormUrlencoded()` |
| Custom | `contentType(String)` |
