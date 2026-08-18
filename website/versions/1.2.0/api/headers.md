# Headers

Add custom HTTP headers to your mocked responses.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .header('X-Total-Count', '42')
  .header('X-Page-Number', '1')
  .mock();
```

## Multiple Headers

Chain multiple `.header()` calls.

```apex
new HttpMock()
  .whenGetOn('/api/data')
  .body('{"data": []}')
  .header('Cache-Control', 'no-cache')
  .header('X-Request-ID', 'abc-123-def')
  .header('X-API-Version', 'v1')
  .mock();
```

## Cache Control

```apex
new HttpMock()
  .whenGetOn('/api/static-data')
  .body('{"data": "cached"}')
  .header('Cache-Control', 'max-age=3600')
  .header('ETag', '"abc123"')
  .mock();
```

## Content Disposition

For file downloads.

```apex
new HttpMock()
  .whenGetOn('/api/report.pdf')
  .body(pdfBlob)
  .contentTypePdf()
  .header('Content-Disposition', 'attachment; filename="report.pdf"')
  .mock();
```

## Rate Limiting

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .header('X-RateLimit-Limit', '100')
  .header('X-RateLimit-Remaining', '95')
  .header('X-RateLimit-Reset', '1640000000')
  .mock();
```

## Authentication

```apex
new HttpMock()
  .whenPostOn('/api/login')
  .body('{"token": "xyz789"}')
  .header('Set-Cookie', 'session=abc123; HttpOnly; Secure')
  .header('X-Auth-Token', 'xyz789')
  .mock();
```

## Location

For redirects and created resources.

```apex
new HttpMock()
  .whenPostOn('/api/users')
  .body('{"id": "123"}')
  .header('Location', '/api/users/123')
  .statusCodeCreated()
  .mock();
```

## Reference

| Header | Purpose |
|--------|---------|
| `Cache-Control` | Caching directives |
| `Content-Disposition` | File download info |
| `Content-Length` | Response size |
| `ETag` | Cache validation |
| `Location` | Redirect/resource URL |
| `X-RateLimit-*` | Rate limiting info |
| `X-Request-ID` | Request tracking |
| `Set-Cookie` | Set cookies |
