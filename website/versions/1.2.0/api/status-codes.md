# Status Codes

Set HTTP status codes for your mocked responses.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .statusCodeOk()
  .mock();
```

## 200 OK

Standard success response.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"users": []}')
  .statusCodeOk()
  .mock();
```

## 201 Created

Resource successfully created.

```apex
new HttpMock()
  .whenPostOn('/api/users')
  .body('{"id": "123"}')
  .statusCodeCreated()
  .mock();
```

## 202 Accepted

Request accepted for processing.

```apex
new HttpMock()
  .whenPostOn('/api/jobs')
  .body('{"jobId": "456", "status": "pending"}')
  .statusCodeAccepted()
  .mock();
```

## 204 No Content

Success with no response body.

```apex
new HttpMock()
  .whenDeleteOn('/api/users/123')
  .statusCodeNoContent()
  .mock();
```

## 400 Bad Request

Invalid request.

```apex
new HttpMock()
  .whenPostOn('/api/users')
  .body('{"error": "Invalid email format"}')
  .statusCodeBadRequest()
  .mock();
```

## 401 Unauthorized

Authentication required.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"error": "Authentication required"}')
  .statusCodeUnauthorized()
  .mock();
```

## 403 Forbidden

Access denied.

```apex
new HttpMock()
  .whenGetOn('/api/admin')
  .body('{"error": "Access denied"}')
  .statusCodeForbidden()
  .mock();
```

## 404 Not Found

Resource not found.

```apex
new HttpMock()
  .whenGetOn('/api/users/999')
  .body('{"error": "User not found"}')
  .statusCodeNotFound()
  .mock();
```

## 405 Method Not Allowed

HTTP method not supported.

```apex
new HttpMock()
  .whenPatchOn('/api/immutable-resource')
  .body('{"error": "PATCH not allowed"}')
  .statusCodeMethodNotAllowed()
  .mock();
```

## 500 Internal Server Error

Server error.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"error": "Internal server error"}')
  .statusCodeInternalServerError()
  .mock();
```

## 501 Not Implemented

Functionality not implemented.

```apex
new HttpMock()
  .whenPostOn('/api/v2/feature')
  .body('{"error": "Not implemented"}')
  .statusCodeNotImplemented()
  .mock();
```

## 502 Bad Gateway

Invalid response from upstream server.

```apex
new HttpMock()
  .whenGetOn('/api/external')
  .body('{"error": "Bad gateway"}')
  .statusCodeBadGateway()
  .mock();
```

## 503 Service Unavailable

Service temporarily unavailable.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"error": "Service unavailable"}')
  .statusCodeServiceUnavailable()
  .mock();
```

## 504 Gateway Timeout

Gateway timeout.

```apex
new HttpMock()
  .whenGetOn('/api/slow-endpoint')
  .body('{"error": "Gateway timeout"}')
  .statusCodeGatewayTimeout()
  .mock();
```

## Custom

For status codes not covered by built-in methods.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"error": "Too many requests"}')
  .statusCode(429)
  .mock();
```

## Reference

| Code | Method |
|------|--------|
| 200 | `statusCodeOk()` |
| 201 | `statusCodeCreated()` |
| 202 | `statusCodeAccepted()` |
| 204 | `statusCodeNoContent()` |
| 400 | `statusCodeBadRequest()` |
| 401 | `statusCodeUnauthorized()` |
| 403 | `statusCodeForbidden()` |
| 404 | `statusCodeNotFound()` |
| 405 | `statusCodeMethodNotAllowed()` |
| 500 | `statusCodeInternalServerError()` |
| 501 | `statusCodeNotImplemented()` |
| 502 | `statusCodeBadGateway()` |
| 503 | `statusCodeServiceUnavailable()` |
| 504 | `statusCodeGatewayTimeout()` |
| Custom | `statusCode(Integer)` |
