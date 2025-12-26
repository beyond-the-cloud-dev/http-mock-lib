# API Reference

Complete API reference for HTTP Mock Lib.

## Interface Overview

```apex
public interface HttpMockLib {
    // HTTP Methods
    HttpMock whenGetOn(String endpointToMock);
    HttpMock whenPostOn(String endpointToMock);
    HttpMock whenPutOn(String endpointToMock);
    HttpMock whenPatchOn(String endpointToMock);
    HttpMock whenDeleteOn(String endpointToMock);
    HttpMock whenTraceOn(String endpointToMock);
    HttpMock whenHeadOn(String endpointToMock);

    // Response Body
    HttpMock body(Object body);
    HttpMock body(String body);
    HttpMock body(Blob body);

    // Content-Type
    HttpMock contentTypePlainText();
    HttpMock contentTypeHtml();
    HttpMock contentTypeCsv();
    HttpMock contentTypeJson();
    HttpMock contentTypeXml();
    HttpMock contentTypePdf();
    HttpMock contentTypeFormUrlencoded();
    HttpMock contentType(String contentType);

    // Status Code
    HttpMock statusCodeOk();
    HttpMock statusCodeCreated();
    HttpMock statusCodeAccepted();
    HttpMock statusCodeNoContent();
    HttpMock statusCodeBadRequest();
    HttpMock statusCodeUnauthorized();
    HttpMock statusCodeForbidden();
    HttpMock statusCodeNotFound();
    HttpMock statusCodeMethodNotAllowed();
    HttpMock statusCodeInternalServerError();
    HttpMock statusCodeNotImplemented();
    HttpMock statusCodeBadGateway();
    HttpMock statusCodeServiceUnavailable();
    HttpMock statusCodeGatewayTimeout();
    HttpMock statusCode(Integer statusCode);

    // Headers
    HttpMock header(String key, String value);

    // Activation
    void mock();
}
```

## Method Categories

### [HTTP Methods](/api/http-methods)
Define which HTTP method and endpoint to mock.

### [Response Body](/api/response-body)
Set the response body in various formats (String, Object, Blob).

### [Content Types](/api/content-types)
Specify the Content-Type header for your response.

### [Status Codes](/api/status-codes)
Set HTTP status codes using semantic methods.

### [Headers](/api/headers)
Add custom headers to your mocked responses.

## Quick Reference

### Basic Pattern

Every mock follows this pattern:

```apex
new HttpMock()
  .when[Method]On('/endpoint')  // 1. Define endpoint
  .body('response')              // 2. Set response
  .statusCode[Code]()            // 3. Set status
  .header('key', 'value')        // 4. Optional headers
  .mock();                       // 5. Activate
```

### Example

```apex
new HttpMock()
  .whenPostOn('/api/v1/users')
  .body('{"id": "123", "name": "John"}')
  .contentTypeJson()
  .statusCodeCreated()
  .header('X-Request-ID', 'abc-123')
  .mock();
```

## Chaining

All methods (except `mock()`) return `HttpMock`, allowing you to chain multiple calls:

```apex
new HttpMock()
  .whenGetOn('/api/v1/data')
  .body('{"data": []}')
  .contentTypeJson()
  .statusCodeOk()
  .header('Cache-Control', 'no-cache')
  .header('X-API-Version', 'v1')
  .mock();
```

## Multiple Endpoints

You can mock multiple endpoints in a single test by chaining endpoint definitions:

```apex
new HttpMock()
  .whenGetOn('/api/auth')
    .body('{"token": "xyz"}')
    .statusCodeOk()
  .whenPostOn('/api/data')
    .body('{"success": true}')
    .statusCodeCreated()
  .whenDeleteOn('/api/data/1')
    .statusCodeNoContent()
  .mock();
```

## Default Values

If not specified, HTTP Mock Lib uses these defaults:

- **Status Code:** `200` (OK)
- **Content-Type:** `application/json`
- **Body:** Empty string

## Thread Safety

HTTP Mock Lib uses Salesforce's built-in `Test.setMock()` mechanism, which is thread-safe within test context.
