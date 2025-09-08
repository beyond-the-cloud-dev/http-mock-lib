/**
 * Copyright (c) 2025 Beyond The Cloud Sp. z o.o. (BeyondTheCloud.Dev)
 * Licensed under the MIT License (https://github.com/beyond-the-cloud-dev/http-mock-lib/blob/main/LICENSE)
**/
@IsTest
private class HttpMockTest {
    @IsTest
    static void get() {
        new HttpMock()
            .whenGetOn('/api/v1')
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(200, response.getStatusCode(), 'Status code should be 200');
        Assert.areEqual('{}', response.getBody(), 'Body should be empty');
    }

    @IsTest
    static void post() {
        new HttpMock()
            .whenPostOn('/api/v1')
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('POST', '/api/v1');
        Test.stopTest();

        Assert.areEqual(200, response.getStatusCode(), 'Status code should be 200');
        Assert.areEqual('{}', response.getBody(), 'Body should be empty');
    }

    @IsTest
    static void put() {
        new HttpMock()
            .whenPutOn('/api/v1')
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('PUT', '/api/v1');
        Test.stopTest();

        Assert.areEqual(200, response.getStatusCode(), 'Status code should be 200');
        Assert.areEqual('{}', response.getBody(), 'Body should be empty');
    }

    @IsTest
    static void patch() {
         new HttpMock()
            .whenPatchOn('/api/v1')
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('PATCH', '/api/v1');
        Test.stopTest();

        Assert.areEqual(200, response.getStatusCode(), 'Status code should be 200');
        Assert.areEqual('{}', response.getBody(), 'Body should be empty');
    }

    @IsTest
    static void head() {
         new HttpMock()
            .whenHeadOn('/api/v1')
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('HEAD', '/api/v1');
        Test.stopTest();

        Assert.areEqual(200, response.getStatusCode(), 'Status code should be 200');
        Assert.areEqual('{}', response.getBody(), 'Body should be empty');
    }

    @IsTest
    static void objectBody() {
        Map<String, Object> mockedObject = new Map<String, Object>{ 'name' => 'test' };

        new HttpMock()
            .whenGetOn('/api/v1').body(mockedObject)
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(mockedObject, (Map<String, Object>) JSON.deserializeUntyped(response.getBody()), 'Body should be the same as the mocked object');
    }

    @IsTest
    static void stringBody() {
        String mockedString = JSON.serialize(new Map<String, String>{ 'name' => 'test' });

        new HttpMock()
            .whenGetOn('/api/v1').body(mockedString)
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(mockedString, response.getBody(), 'Body should be the same as the mocked string');
    }

    @IsTest
    static void blobBody() {
        Blob mockedBlob = Blob.valueof('Test Blob');

        new HttpMock()
            .whenGetOn('/api/v1').body(mockedBlob)
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(mockedBlob, response.getBodyAsBlob(), 'Body should be the same as the mocked blob');
    }

    @IsTest
    static void primitiveBody() {
        Integer mockedInteger = 1;

        new HttpMock()
            .whenGetOn('/api/v1').body(mockedInteger)
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(mockedInteger, Integer.valueOf(response.getBody()), 'Body should be the same as the mocked integer');
    }

    @IsTest
    static void contentTypePlainText() {
        new HttpMock()
            .whenGetOn('/api/v1').contentTypePlainText()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual('text/plain', response.getHeader('Content-Type'), 'Content type should be text/plain');
    }

    @IsTest
    static void contentTypeHtml() {
        new HttpMock()
            .whenGetOn('/api/v1').contentTypeHtml()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual('text/html', response.getHeader('Content-Type'), 'Content type should be text/html');
    }

    @IsTest
    static void contentTypeCsv() {
        new HttpMock()
            .whenGetOn('/api/v1').contentTypeCsv()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual('text/csv', response.getHeader('Content-Type'), 'Content type should be text/csv');
    }

    @IsTest
    static void contentTypeJson() {
        new HttpMock()
            .whenGetOn('/api/v1').contentTypeJson()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual('application/json', response.getHeader('Content-Type'), 'Content type should be application/json');
    }

    @IsTest
    static void contentTypePdf() {
        new HttpMock()
            .whenGetOn('/api/v1').contentTypePdf()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual('application/pdf', response.getHeader('Content-Type'), 'Content type should be application/pdf');
    }

    @IsTest
    static void contentTypeXml() {
        new HttpMock()
            .whenGetOn('/api/v1').contentTypeXml()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual('application/xml', response.getHeader('Content-Type'), 'Content type should be application/xml');
    }

    @IsTest
    static void contentTypeFormUrlencoded() {
        new HttpMock()
            .whenGetOn('/api/v1').contentTypeFormUrlencoded()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual('application/x-www-form-urlencoded', response.getHeader('Content-Type'), 'Content type should be application/x-www-form-urlencoded');
    }

    @IsTest
    static void customContentType() {
        new HttpMock()
            .whenGetOn('/api/v1').contentType('text/html')
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual('text/html', response.getHeader('Content-Type'), 'Content type should be text/html');
    }

    @IsTest
    static void staticResourceBody() {
        String staticResourceName = 'responseBody';

        new HttpMock()
            .whenGetOn('/api/v1').staticResource(staticResourceName)
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        SampleResponseBody responseBody = (SampleResponseBody) JSON.deserialize(response.getBody(), SampleResponseBody.class);
        Assert.areEqual('responseBody', responseBody.name, 'Name should be responseBody');
        Assert.areEqual(1, responseBody.order, 'Order should be 1');
        Assert.isTrue(responseBody.active, 'Active should be true');
        Assert.areEqual(new List<String>{'This is a sample JSON request body for API testing.'}, responseBody.additionalDetails, 'Additional details list should be the same');
    }

    class SampleResponseBody {
        public String name;
        public Integer order;
        public Boolean active;
        public List<String> additionalDetails;
    }

    @IsTest
    static void staticResourceNotFound() {
        String staticResourceName = 'aResourceThatDoesNotExist12345';

        Test.startTest();
        Exception caughtEx;
        try {
            new HttpMock()
                .whenGetOn('/api/v1').staticResource(staticResourceName)
                .mock();
        } catch (Exception ex) {
            caughtEx = ex;
        }
        Test.stopTest();           
        
        Assert.isInstanceOfType(caughtEx, HttpMock.StaticResourceNotFoundException.class, 'Exception should be StaticResourceNotFoundException');
    }

    @IsTest
    static void statusCodeOk() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeOk()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(200, response.getStatusCode(), 'Status code should be 200');
    }

    @IsTest
    static void statusCodeCreated() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeCreated()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(201, response.getStatusCode(), 'Status code should be 201');
    }

    @IsTest
    static void statusCodeAccepted() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeAccepted()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(202, response.getStatusCode(), 'Status code should be 202');
    }

    @IsTest
    static void statusCodeNoContent() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeNoContent()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(204, response.getStatusCode(), 'Status code should be 204');
    }

    @IsTest
    static void statusCodeBadRequest() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeBadRequest()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(400, response.getStatusCode(), 'Status code should be 400');
    }

    @IsTest
    static void statusCodeUnauthorized() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeUnauthorized()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(401, response.getStatusCode(), 'Status code should be 401');
    }

    @IsTest
    static void statusCodeForbidden() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeForbidden()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(403, response.getStatusCode(), 'Status code should be 403');
    }

    @IsTest
    static void statusCodeNotFound() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeNotFound()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(404, response.getStatusCode(), 'Status code should be 404');
    }

    @IsTest
    static void statusCodeMethodNotAllowed() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeMethodNotAllowed()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(405, response.getStatusCode(), 'Status code should be 405');
    }

    @IsTest
    static void statusCodeInternalServerError() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeInternalServerError()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(500, response.getStatusCode(), 'Status code should be 500');
    }

    @IsTest
    static void statusCodeNotImplemented() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeNotImplemented()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(501, response.getStatusCode(), 'Status code should be 501'      );
    }

    @IsTest
    static void statusCodeBadGateway() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeBadGateway()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(502, response.getStatusCode(), 'Status code should be 502');
    }

    @IsTest
    static void statusCodeServiceUnavailable() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeServiceUnavailable()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(503, response.getStatusCode(), 'Status code should be 503');
    }

    @IsTest
    static void statusCodeGatewayTimeout() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeGatewayTimeout()
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(504, response.getStatusCode(), 'Status code should be 504');
    }

    @IsTest
    static void customStatusCode() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCode(403)
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(403, response.getStatusCode(), 'Status code should be 403');
    }

    @IsTest
    static void header() {
        new HttpMock()
            .whenGetOn('/api/v1').header('Cache-Control', 'no-cache')
            .mock();

        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual('no-cache', response.getHeader('Cache-Control'), 'Cache control header should be no-cache');
    }

    @IsTest
    static void multipleCalloutMock() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeOk()
            .whenGetOn('/api/v2').statusCodeNotFound()
            .mock();

        Test.startTest();
        HttpResponse response1 = new TestApi().makeCallout('GET', '/api/v1');
        HttpResponse response2 = new TestApi().makeCallout('GET', '/api/v2');
        Test.stopTest();

        Assert.areEqual(200, response1.getStatusCode(), 'Status code should be 200');
        Assert.areEqual(404, response2.getStatusCode(), 'Status code should be 404');
    }

    @IsTest
    static void multipleCalloutMockWithSubpath() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeOk()
            .whenGetOn('/api/v1/abc123').statusCodeNotFound()
            .mock();

        Test.startTest();
        HttpResponse response1 = new TestApi().makeCallout('GET', '/api/v1');
        HttpResponse response2 = new TestApi().makeCallout('GET', '/api/v1/abc123');
        Test.stopTest();

        Assert.areEqual(200, response1.getStatusCode(), 'Status code should be 200');
        Assert.areEqual(404, response2.getStatusCode(), 'Status code should be 404');
    }

    @IsTest
    static void multipleCalloutMockWithSubpathAndRandomMocking() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeNotFound()
            .whenGetOn('/api/v1/abc123').statusCodeOk()
            .mock();

        Test.startTest();
        HttpResponse response1 = new TestApi().makeCallout('GET', '/api/v1/abc123');
        HttpResponse response2 = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(200, response1.getStatusCode(), 'Status code should be 200');
        Assert.areEqual(404, response2.getStatusCode(), 'Status code should be 404');
    }

    @IsTest
    static void multipleCalloutToTheSameEndpoint() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeOk()
            .mock();

        Test.startTest();
        HttpResponse response1 = new TestApi().makeCallout('GET', '/api/v1');
        HttpResponse response2 = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(200, response1.getStatusCode(), 'Status code should be 200');
        Assert.areEqual(200, response2.getStatusCode(), 'Status code should be 200');
    }

    @IsTest
    static void multipleCalloutToTheSameEndpointWithDifferentResponses() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeOk()
            .whenGetOn('/api/v1').statusCodeNotFound()
            .mock();

        Test.startTest();
        HttpResponse response1 = new TestApi().makeCallout('GET', '/api/v1');
        HttpResponse response2 = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(200, response1.getStatusCode(), 'Status code should be 200');
        Assert.areEqual(404, response2.getStatusCode(), 'Status code should be 404');
    }

    @IsTest
    static void getRequestCount() {
        new HttpMock().whenGetOn('/api/v1').statusCodeOk().mock();

        Test.startTest();
        new TestApi().makeCallout('GET', '/api/v1');
        new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        Assert.areEqual(2, HttpMock.getRequestCount('GET', '/api/v1'), 'Request count should be 2');
    }

    @IsTest
    static void httpMethodNotMocked() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeOk()
            .mock();

        HttpMock.HttpMethodNotMockedException mockException = null;

        Test.startTest();
        try {
            new TestApi().makeCallout('POST', '/api/v1');
        } catch (HttpMock.HttpMethodNotMockedException e) {
            mockException = e;
        }
        Test.stopTest();

        Assert.isNotNull(mockException, 'Mock exception should be thrown');
        Assert.areEqual('HTTP Method POST hasn\'t been mocked.', mockException.getMessage(), 'Message should be HTTP Method POST hasn\'t been mocked.');
    }

    @IsTest
    static void httpEndpointNotMocked() {
        new HttpMock()
            .whenGetOn('/api/v1').statusCodeOk()
            .mock();

        HttpMock.HttpEndpointNotMockedException mockException = null;

        Test.startTest();
        try {
            new TestApi().makeCallout('GET', '/api/v2');
        } catch (HttpMock.HttpEndpointNotMockedException e) {
            mockException = e;
        }
        Test.stopTest();

        Assert.isNotNull(mockException, 'Mock exception should be thrown');
        Assert.areEqual('HTTP Endpoint /api/v2 hasn\'t been mocked.', mockException.getMessage(), 'Message should be HTTP Endpoint /api/v2 hasn\'t been mocked.');
    }

    private class TestApi {
        public HttpResponse makeCallout(String method, String endpoint) {
            HttpRequest request = new HttpRequest();

            request.setMethod(method);
            request.setEndpoint(endpoint);
            request.setHeader('Content-Type', 'application/json');
            request.setBody(JSON.serialize(new Map<String, String>{ 'name' => 'callout' }));

            return new Http().send(request);
        }
    }
}
