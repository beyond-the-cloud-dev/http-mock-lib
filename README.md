<div align="center">
  <a href="https://apexfluently.beyondthecloud.dev/libraries/http-mock-lib.html">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="./website/public/logo.png">
      <img alt="HTTP Mock Lib logo" src="./website/public/logo.png" height="98">
    </picture>
  </a>
  <h1>HTTP Mock Lib</h1>

<a href="https://beyondthecloud.dev"><img alt="Beyond The Cloud logo" src="https://img.shields.io/badge/MADE_BY_BEYOND_THE_CLOUD-555?style=for-the-badge"></a>
<a ><img alt="API version" src="https://img.shields.io/badge/api-v64.0-blue?style=for-the-badge"></a>
<a href="https://github.com/beyond-the-cloud-dev/http-mock-lib/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/badge/license-mit-green?style=for-the-badge"></a>

[![CI](https://github.com/beyond-the-cloud-dev/http-mock-lib/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/beyond-the-cloud-dev/http-mock-lib/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/beyond-the-cloud-dev/http-mock-lib/branch/main/graph/badge.svg)](https://codecov.io/gh/beyond-the-cloud-dev/http-mock-lib)
</div>

HTTP Mock inspired by Robert Sösemann’s [Apex Http Mock](https://github.com/rsoesemann/apex-httpmock).

HTTP Mock Lib is part of [Apex Fluently](https://apexfluently.beyondthecloud.dev/), a suite of production-ready Salesforce libraries by Beyond the Cloud.

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
