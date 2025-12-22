# Headers

Add custom HTTP headers to your mocked responses.

## API

### header()

Add a custom header to the response.

```apex
HttpMock header(String key, String value)
```

**Example:**
```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .header('X-Total-Count', '42')
  .header('X-Page-Number', '1')
  .statusCodeOk()
  .mock();
```

## Multiple Headers

You can chain multiple `.header()` calls to add multiple headers:

```apex
new HttpMock()
  .whenGetOn('/api/data')
  .body('{"data": []}')
  .header('Cache-Control', 'no-cache')
  .header('X-Request-ID', 'abc-123-def')
  .header('X-API-Version', 'v1')
  .header('X-RateLimit-Remaining', '99')
  .statusCodeOk()
  .mock();
```

## Common Headers

### Cache Control

```apex
new HttpMock()
  .whenGetOn('/api/static-data')
  .body('{"data": "cached"}')
  .header('Cache-Control', 'max-age=3600')
  .header('ETag', '"abc123"')
  .statusCodeOk()
  .mock();
```

### Content Disposition

For file downloads:

```apex
new HttpMock()
  .whenGetOn('/api/report.pdf')
  .body(pdfBlob)
  .contentTypePdf()
  .header('Content-Disposition', 'attachment; filename="monthly-report.pdf"')
  .header('Content-Length', String.valueOf(pdfBlob.size()))
  .statusCodeOk()
  .mock();
```

### CORS Headers

```apex
new HttpMock()
  .whenGetOn('/api/public/data')
  .body('{"data": []}')
  .header('Access-Control-Allow-Origin', '*')
  .header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE')
  .header('Access-Control-Allow-Headers', 'Content-Type, Authorization')
  .statusCodeOk()
  .mock();
```

### Rate Limiting

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .header('X-RateLimit-Limit', '100')
  .header('X-RateLimit-Remaining', '95')
  .header('X-RateLimit-Reset', '1640000000')
  .statusCodeOk()
  .mock();
```

### Authentication

```apex
new HttpMock()
  .whenPostOn('/api/login')
  .body('{"token": "xyz789"}')
  .header('Set-Cookie', 'session=abc123; HttpOnly; Secure')
  .header('X-Auth-Token', 'xyz789')
  .statusCodeOk()
  .mock();
```

### Custom API Headers

```apex
new HttpMock()
  .whenGetOn('/api/v2/data')
  .body('{"data": []}')
  .header('X-API-Version', 'v2.1.0')
  .header('X-Server-ID', 'server-42')
  .header('X-Request-Duration', '127ms')
  .statusCodeOk()
  .mock();
```

### Location Header

For redirects and created resources:

```apex
new HttpMock()
  .whenPostOn('/api/users')
  .body('{"id": "123"}')
  .header('Location', '/api/users/123')
  .statusCodeCreated()
  .mock();
```

## Default Headers

HTTP Mock Lib automatically sets:
- `Content-Type` (based on your content type method, default: `application/json`)

You can override the Content-Type using `.header()`:

```apex
new HttpMock()
  .whenGetOn('/api/custom')
  .body('{"data": {}}')
  .header('Content-Type', 'application/vnd.api+json')  // Override
  .statusCodeOk()
  .mock();
```

## Testing Headers

Test that your code properly handles response headers:

```apex
@IsTest
static void testRateLimitHeaders() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/data')
    .body('{"data": []}')
    .header('X-RateLimit-Remaining', '0')
    .statusCodeOk()
    .mock();

  // Act
  Test.startTest();
  ApiService service = new ApiService();
  service.getData();
  Test.stopTest();

  // Assert
  Assert.isTrue(service.rateLimitReached);
}
```

## Best Practices

1. **Use Standard Headers** - Prefer standard HTTP headers (Cache-Control, Content-Type, etc.)

2. **Match Real API** - Include the same headers that the real API returns

3. **Test Header Handling** - Verify your code properly processes important headers

4. **Document Custom Headers** - If using custom `X-` headers, document their purpose

5. **Case Sensitivity** - HTTP headers are case-insensitive, but use standard casing (e.g., `Content-Type` not `content-type`)

## Common Use Cases

### Pagination Metadata

```apex
new HttpMock()
  .whenGetOn('/api/users?page=2')
  .body('{"users": [...]}')
  .header('X-Total-Count', '1000')
  .header('X-Page-Number', '2')
  .header('X-Page-Size', '50')
  .header('X-Total-Pages', '20')
  .header('Link', '</api/users?page=3>; rel="next"')
  .statusCodeOk()
  .mock();
```

### Error Tracking

```apex
new HttpMock()
  .whenGetOn('/api/error-prone')
  .body('{"error": "Internal error"}')
  .header('X-Request-ID', 'req-123-456')
  .header('X-Error-Code', 'ERR_500')
  .statusCodeInternalServerError()
  .mock();
```

### API Versioning

```apex
new HttpMock()
  .whenGetOn('/api/resource')
  .body('{"data": {}}')
  .header('X-API-Version', '2.0')
  .header('X-Deprecated-In-Version', '3.0')
  .header('Sunset', 'Sat, 31 Dec 2024 23:59:59 GMT')
  .statusCodeOk()
  .mock();
```

### Content Negotiation

```apex
new HttpMock()
  .whenGetOn('/api/data')
  .body('{"data": []}')
  .contentTypeJson()
  .header('Content-Language', 'en-US')
  .header('Vary', 'Accept, Accept-Language')
  .statusCodeOk()
  .mock();
```

## Header Reference

| Header | Purpose | Example Value |
|--------|---------|---------------|
| `Cache-Control` | Caching directives | `no-cache`, `max-age=3600` |
| `Content-Disposition` | File download info | `attachment; filename="file.pdf"` |
| `Content-Length` | Response size | `1234` |
| `ETag` | Cache validation | `"abc123"` |
| `Location` | Redirect/resource URL | `/api/users/123` |
| `X-RateLimit-*` | Rate limiting info | `100`, `95`, `1640000000` |
| `X-Request-ID` | Request tracking | `abc-123-def-456` |
| `X-API-Version` | API version | `v2.1.0` |
| `Set-Cookie` | Set cookies | `session=abc; HttpOnly` |

## See Also

- [Content Types →](/api/content-types)
- [Response Body →](/api/response-body)
- [Examples →](/examples/custom-headers)
