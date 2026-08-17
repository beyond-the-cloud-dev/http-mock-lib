# API Reference

Complete API reference for HTTP Mock Lib.

## Interface Overview

```apex
public interface HttpStubbing {
    // HTTP Methods
    HttpStubbing whenGetOn(String endpointToMock);
    HttpStubbing whenPostOn(String endpointToMock);
    HttpStubbing whenPutOn(String endpointToMock);
    HttpStubbing whenPatchOn(String endpointToMock);
    HttpStubbing whenDeleteOn(String endpointToMock);
    HttpStubbing whenTraceOn(String endpointToMock);
    HttpStubbing whenHeadOn(String endpointToMock);

    // Response Body
    HttpStubbing body(Object body);
    HttpStubbing body(String body);
    HttpStubbing body(Blob body);

    // Static Resource
    HttpStubbing staticResource(String staticResourceName);

    // Content-Type
    HttpStubbing contentTypePlainText();
    HttpStubbing contentTypeHtml();
    HttpStubbing contentTypeCsv();
    HttpStubbing contentTypeJson();
    HttpStubbing contentTypeXml();
    HttpStubbing contentTypePdf();
    HttpStubbing contentTypeFormUrlencoded();
    HttpStubbing contentType(String contentType);

    // Status Code
    HttpStubbing statusCodeOk();
    HttpStubbing statusCodeCreated();
    HttpStubbing statusCodeAccepted();
    HttpStubbing statusCodeNoContent();
    HttpStubbing statusCodeBadRequest();
    HttpStubbing statusCodeUnauthorized();
    HttpStubbing statusCodeForbidden();
    HttpStubbing statusCodeNotFound();
    HttpStubbing statusCodeMethodNotAllowed();
    HttpStubbing statusCodeInternalServerError();
    HttpStubbing statusCodeNotImplemented();
    HttpStubbing statusCodeBadGateway();
    HttpStubbing statusCodeServiceUnavailable();
    HttpStubbing statusCodeGatewayTimeout();
    HttpStubbing statusCode(Integer statusCode);

    // Status Text
    HttpStubbing status(String status);

    // Headers
    HttpStubbing header(String key, String value);

    // Exception
    HttpStubbing throwsException();
    HttpStubbing throwsException(Exception error);

    // Activation
    void mock();
}
```

Requests made against the mock are recorded, and readable through a separate entry point:

```apex
public interface Requests {
    Integer all();

    Integer get();
    Integer post();
    Integer put();
    Integer patch();
    Integer deletex();
    Integer trace();
    Integer head();

    List<HttpRequest> captured();
    List<HttpRequest> capturedGets();
    List<HttpRequest> capturedPosts();
    List<HttpRequest> capturedPuts();
    List<HttpRequest> capturedPatches();
    List<HttpRequest> capturedDeletes();
    List<HttpRequest> capturedTraces();
    List<HttpRequest> capturedHeads();

    HttpRequest last();
    HttpRequest lastGet();
    HttpRequest lastPost();
    HttpRequest lastPut();
    HttpRequest lastPatch();
    HttpRequest lastDelete();
    HttpRequest lastTrace();
    HttpRequest lastHead();
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

### [Exceptions](/api/exceptions)
Make a callout fail on the wire instead of returning a response.

### [Requests](/api/requests)
Count the callouts made, and assert on what your code actually sent.

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

All configuration methods return the `HttpStubbing` interface, allowing you to chain multiple calls (`mock()` ends the chain):

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
- **Body:** `{}` (empty JSON object)

## Thread Safety

HTTP Mock Lib uses Salesforce's built-in `Test.setMock()` mechanism, which is thread-safe within test context.
