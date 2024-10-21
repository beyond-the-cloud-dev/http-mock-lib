# Http Mock Lib

## Example

```java
@IsTest
private class MyTest {
  @IsTest
  static void calloutTest() {
    new HttpMock()
      .get('/api/v1/authorize').body('{ "token": "aZ3Xb7Qk" }').statusCodeOk()
      .post('/api/v1/create').body('{ "success": true, "message": null }').statusCodeOk()
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
    HttpMock get(String endpointToMock);
    HttpMock post(String endpointToMock);
    HttpMock put(String endpointToMock);
    HttpMock patch(String endpointToMock);
    HttpMock deletex(String endpointToMock);
    HttpMock trace(String endpointToMock);
    HttpMock head(String endpointToMock);
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
