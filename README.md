# Http Mock Lib

HTTP Mock inspired by Robert Sösemann’s [Apex Http Mock](https://github.com/rsoesemann/apex-httpmock).

❌❌❌

```java
@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
    }
}

Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
```

✅✅✅

```java
new HttpMock()
  .whenGetOn('/api/v1/authorize').body('{"example":"test"}').statusCodeOk()
  .mock();
```

## Example

```java
@IsTest
private class MyTest {
  @IsTest
  static void calloutTest() {
    new HttpMock()
      .whenGetOn('/api/v1/authorize').body('{ "token": "aZ3Xb7Qk" }').statusCodeOk()
      .whenPostOn('/api/v1/create').body('{ "success": true, "message": null }').statusCodeOk()
      .mock();

    Test.startTest();
    new CalloutService().makeCallout();
    Test.stopTest();

    // Asserts
    Assert.areEqual(..., ...);
  }
}
```

## API

```java
public interface HttpMockLib {
    HttpMock whenGetOn(String endpointToMock);
    HttpMock whenPostOn(String endpointToMock);
    HttpMock whenPutOn(String endpointToMock);
    HttpMock whenPatchOn(String endpointToMock);
    HttpMock whenDeleteOn(String endpointToMock);
    HttpMock whenTraceOn(String endpointToMock);
    HttpMock whenHeadOn(String endpointToMock);
    // Body
    HttpMock body(Object body);
    HttpMock body(String body);
    HttpMock body(Blob body);
    // Content-Type
    HttpMock contentTypePlainText(); // text/plain
    HttpMock contentTypeHtml(); // text/html
    HttpMock contentTypeCsv(); // text/csv
    HttpMock contentTypeJson(); // application/json
    HttpMock contentTypeXml(); // application/xml
    HttpMock contentTypePdf(); // application/pdf
    HttpMock contentTypeFormUrlencoded(); // application/x-www-form-urlencoded
    HttpMock contentType(String contentType);
    // Status Code
    HttpMock statusCodeOk(); // 200
    HttpMock statusCodeCreated(); // 201
    HttpMock statusCodeAccepted(); // 202
    HttpMock statusCodeNoContent(); // 204
    HttpMock statusCodeBadRequest(); // 400
    HttpMock statusCodeUnauthorized(); // 401
    HttpMock statusCodeForbidden(); // 403
    HttpMock statusCodeNotFound(); // 404
    HttpMock statusCodeMethodNotAllowed(); // 405
    HttpMock statusCodeInternalServerError(); // 500
    HttpMock statusCodeNotImplemented(); // 501
    HttpMock statusCodeBadGateway(); // 502
    HttpMock statusCodeServiceUnavailable(); // 503
    HttpMock statusCodeGatewayTimeout(); // 504
    HttpMock statusCode(Integer statusCode);
    // Headers
    HttpMock header(String key, String value);
    // Mock
    void mock();
}
```

## Features

### Mock different HTTP methods

Mock different HTTP methods in the same test method.  

```java
new HttpMock()
    .whenGetOn('/api/v1/authorize').body('{ "token": "aZ3Xb7Qk" }').statusCodeOk()
    .whenPostOn('/api/v1/create').body('{ "success": true, "message": null }').statusCodeOk()
    .mock();
```

Supported methods:
- GET
- POST
- PUT
- PATCH
- DELETE
- TRACE
- HEAD

### Return different body

```java
new HttpMock()
    .whenGetOn('/api/v1').body(new Map<String, String>{ 'token' => 'aZ3Xb7Qk' }).statusCodeOk()
    .mock();
```

Mock HTTP response body by using the following methods:

```java
HttpMock body(Object body);
HttpMock body(String body);
HttpMock body(Blob body);
```

### Use built-in Content Types

Use different content types. By default, the content type is set to `application/json`.

```java
HttpMock contentTypePlainText(); // text/plain
HttpMock contentTypeHtml(); // text/html
HttpMock contentTypeCsv(); // text/csv
HttpMock contentTypeJson(); // application/json
HttpMock contentTypeXml(); // application/xml
HttpMock contentTypePdf(); // application/pdf
HttpMock contentTypeFormUrlencoded(); // application/x-www-form-urlencoded

HttpMock contentType(String contentType);
```

Use `contentType(String contentType)` to set your own content type. 

### Use built-in Status Codes

Use different status codes. By default, the status code is set to 200 (OK).

Available status codes:

```java
HttpMock statusCodeOk(); // 200
HttpMock statusCodeCreated(); // 201
HttpMock statusCodeAccepted(); // 202
HttpMock statusCodeNoContent(); // 204
HttpMock statusCodeBadRequest(); // 400
HttpMock statusCodeUnauthorized(); // 401
HttpMock statusCodeForbidden(); // 403
HttpMock statusCodeNotFound(); // 404
HttpMock statusCodeMethodNotAllowed(); // 405
HttpMock statusCodeInternalServerError(); // 500
HttpMock statusCodeNotImplemented(); // 501
HttpMock statusCodeBadGateway(); // 502
HttpMock statusCodeServiceUnavailable(); // 503
HttpMock statusCodeGatewayTimeout(); // 504

HttpMock statusCode(Integer statusCode);
```

Use `statusCode(Integer statusCode)` to set your own status code. 

### Set custom headers

Set response headers using the `header(String key, String value)` method.

```java
new HttpMock()
    .whenGetOn('/api/v1').body('{ "token": "aZ3Xb7Qk" }').header('Cache-Control', 'no-cache')
    .mock();
```
