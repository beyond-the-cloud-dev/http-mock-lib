# Status Codes

Set HTTP status codes for your mocked responses.

## Built-in Status Codes

HTTP Mock Lib provides semantic methods for common HTTP status codes.

### Success Codes (2xx)

#### statusCodeOk()
```apex
HttpMock statusCodeOk()  // 200
```
Standard success response.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .statusCodeOk()
  .mock();
```

#### statusCodeCreated()
```apex
HttpMock statusCodeCreated()  // 201
```
Resource successfully created.

```apex
new HttpMock()
  .whenPostOn('/api/users')
  .body('{"id": "123"}')
  .statusCodeCreated()
  .mock();
```

#### statusCodeAccepted()
```apex
HttpMock statusCodeAccepted()  // 202
```
Request accepted for processing.

```apex
new HttpMock()
  .whenPostOn('/api/jobs')
  .body('{"jobId": "456", "status": "pending"}')
  .statusCodeAccepted()
  .mock();
```

#### statusCodeNoContent()
```apex
HttpMock statusCodeNoContent()  // 204
```
Success with no response body.

```apex
new HttpMock()
  .whenDeleteOn('/api/users/123')
  .statusCodeNoContent()
  .mock();
```

### Client Error Codes (4xx)

#### statusCodeBadRequest()
```apex
HttpMock statusCodeBadRequest()  // 400
```
Invalid request.

```apex
new HttpMock()
  .whenPostOn('/api/users')
  .body('{"error": "Invalid email format"}')
  .statusCodeBadRequest()
  .mock();
```

#### statusCodeUnauthorized()
```apex
HttpMock statusCodeUnauthorized()  // 401
```
Authentication required.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"error": "Authentication required"}')
  .statusCodeUnauthorized()
  .mock();
```

#### statusCodeForbidden()
```apex
HttpMock statusCodeForbidden()  // 403
```
Access denied.

```apex
new HttpMock()
  .whenGetOn('/api/admin')
  .body('{"error": "Access denied"}')
  .statusCodeForbidden()
  .mock();
```

#### statusCodeNotFound()
```apex
HttpMock statusCodeNotFound()  // 404
```
Resource not found.

```apex
new HttpMock()
  .whenGetOn('/api/users/999')
  .body('{"error": "User not found"}')
  .statusCodeNotFound()
  .mock();
```

#### statusCodeMethodNotAllowed()
```apex
HttpMock statusCodeMethodNotAllowed()  // 405
```
HTTP method not supported.

```apex
new HttpMock()
  .whenPatchOn('/api/immutable-resource')
  .body('{"error": "PATCH not allowed"}')
  .statusCodeMethodNotAllowed()
  .mock();
```

### Server Error Codes (5xx)

#### statusCodeInternalServerError()
```apex
HttpMock statusCodeInternalServerError()  // 500
```
Server error.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"error": "Internal server error"}')
  .statusCodeInternalServerError()
  .mock();
```

#### statusCodeNotImplemented()
```apex
HttpMock statusCodeNotImplemented()  // 501
```
Functionality not implemented.

```apex
new HttpMock()
  .whenPostOn('/api/v2/feature')
  .body('{"error": "Not implemented"}')
  .statusCodeNotImplemented()
  .mock();
```

#### statusCodeBadGateway()
```apex
HttpMock statusCodeBadGateway()  // 502
```
Invalid response from upstream server.

```apex
new HttpMock()
  .whenGetOn('/api/external')
  .body('{"error": "Bad gateway"}')
  .statusCodeBadGateway()
  .mock();
```

#### statusCodeServiceUnavailable()
```apex
HttpMock statusCodeServiceUnavailable()  // 503
```
Service temporarily unavailable.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"error": "Service unavailable"}')
  .statusCodeServiceUnavailable()
  .mock();
```

#### statusCodeGatewayTimeout()
```apex
HttpMock statusCodeGatewayTimeout()  // 504
```
Gateway timeout.

```apex
new HttpMock()
  .whenGetOn('/api/slow-endpoint')
  .body('{"error": "Gateway timeout"}')
  .statusCodeGatewayTimeout()
  .mock();
```

## Custom Status Codes

For status codes not covered by built-in methods, use `statusCode()`:

```apex
HttpMock statusCode(Integer statusCode)
```

**Example:**
```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"error": "Too many requests"}')
  .statusCode(429)  // Custom: Too Many Requests
  .mock();
```

## Default Status Code

If no status code is specified, HTTP Mock Lib uses **200 (OK)** by default:

```apex
// These are equivalent:
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .mock();

new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .statusCodeOk()  // Explicitly set
  .mock();
```

## Testing Error Handling

Use error status codes to test how your code handles failures:

```apex
@IsTest
static void testUnauthorizedError() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/secure-data')
    .body('{"error": "Unauthorized"}')
    .statusCodeUnauthorized()
    .mock();

  // Act & Assert
  Test.startTest();
  try {
    new ApiService().getSecureData();
    Assert.fail('Expected CalloutException');
  } catch (CalloutException e) {
    Assert.isTrue(e.getMessage().contains('Unauthorized'));
  }
  Test.stopTest();
}
```

## Complete Status Code Reference

| Code | Method | Description |
|------|--------|-------------|
| 200 | `statusCodeOk()` | Success |
| 201 | `statusCodeCreated()` | Resource created |
| 202 | `statusCodeAccepted()` | Request accepted |
| 204 | `statusCodeNoContent()` | Success, no content |
| 400 | `statusCodeBadRequest()` | Bad request |
| 401 | `statusCodeUnauthorized()` | Unauthorized |
| 403 | `statusCodeForbidden()` | Forbidden |
| 404 | `statusCodeNotFound()` | Not found |
| 405 | `statusCodeMethodNotAllowed()` | Method not allowed |
| 500 | `statusCodeInternalServerError()` | Server error |
| 501 | `statusCodeNotImplemented()` | Not implemented |
| 502 | `statusCodeBadGateway()` | Bad gateway |
| 503 | `statusCodeServiceUnavailable()` | Service unavailable |
| 504 | `statusCodeGatewayTimeout()` | Gateway timeout |
| Custom | `statusCode(Integer)` | Any status code |

## Best Practices

1. **Use Semantic Methods** - Prefer `statusCodeOk()` over `statusCode(200)` for readability

2. **Test Error Paths** - Don't just test success cases; mock error responses too

3. **Match Real APIs** - Use status codes that match what the real API returns

4. **Document Exceptions** - When testing error cases, document why you expect them

## See Also

- [HTTP Methods →](/api/http-methods)
- [Error Handling Examples →](/examples/error-handling)
- [Headers →](/api/headers)
