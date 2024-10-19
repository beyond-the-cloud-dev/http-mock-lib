@IsTest
private class HttpMockTest {
    @IsTest
    static void get() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(200, response.getStatusCode());
        Assert.areEqual('{}', response.getBody());
    }

    @IsTest
    static void post() {
        // Setup
        new HttpMock()
            .post('/api/v1')
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('POST', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(200, response.getStatusCode());
        Assert.areEqual('{}', response.getBody());
    }

    @IsTest
    static void put() {
        // Setup
        new HttpMock()
            .put('/api/v1')
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('PUT', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(200, response.getStatusCode());
        Assert.areEqual('{}', response.getBody());
    }

    @IsTest
    static void patch() {
         // Setup
         new HttpMock()
            .patch('/api/v1')
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('PATCH', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(200, response.getStatusCode());
        Assert.areEqual('{}', response.getBody());
    }

    @IsTest
    static void head() {
         // Setup
         new HttpMock()
            .head('/api/v1')
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('HEAD', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(200, response.getStatusCode());
        Assert.areEqual('{}', response.getBody());
    }

    @IsTest
    static void objectBody() {
        // Setup
        Map<String, Object> mockedObject = new Map<String, Object>{ 'name' => 'test' };

        new HttpMock()
            .get('/api/v1')
            .body(mockedObject)
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(mockedObject, (Map<String, Object>) JSON.deserializeUntyped(response.getBody()));
    }

    @IsTest
    static void stringBody() {
        // Setup
        String mockedString = JSON.serialize(new Map<String, String>{ 'name' => 'test' });

        new HttpMock()
            .get('/api/v1')
            .body(mockedString)
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(mockedString, response.getBody());
    }

    @IsTest
    static void blobBody() {
        // Setup
        Blob mockedBlob = Blob.valueof('Test Blob');

        new HttpMock()
            .get('/api/v1')
            .body(mockedBlob)
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(mockedBlob, response.getBodyAsBlob());
    }

    @IsTest
    static void contentTypePlainText() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .contentTypePlainText()
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual('text/plain', response.getHeader('Content-Type'));
    }

    @IsTest
    static void contentTypeCsv() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .contentTypeCsv()
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual('text/csv', response.getHeader('Content-Type'));
    }

    @IsTest
    static void contentTypeJson() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .contentTypeJson()
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual('application/json', response.getHeader('Content-Type'));
    }

    @IsTest
    static void contentTypeXml() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .contentTypeXml()
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual('application/xml', response.getHeader('Content-Type'));
    }

    @IsTest
    static void contentTypeFormUrlencoded() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .contentTypeFormUrlencoded()
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual('application/x-www-form-urlencoded', response.getHeader('Content-Type'));
    }

    @IsTest
    static void customContentType() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .contentType('text/html')
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual('text/html', response.getHeader('Content-Type'));
    }

    @IsTest
    static void statusCodeOk() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .statusCodeOk()
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(200, response.getStatusCode());
    }

    @IsTest
    static void statusCodeBadRequest() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .statusCodeBadRequest()
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(400, response.getStatusCode());
    }

    @IsTest
    static void statusCodeUnauthorized() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .statusCodeUnauthorized()
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(401, response.getStatusCode());
    }

    @IsTest
    static void statusCodeNotFound() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .statusCodeNotFound()
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(404, response.getStatusCode());
    }

    @IsTest
    static void statusCodeInternalServerError() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .statusCodeInternalServerError()
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(500, response.getStatusCode());
    }

    @IsTest
    static void customStatusCode() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .statusCode(403)
            .mock();

        // Test
        Test.startTest();
        HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
        Test.stopTest();

        // Verify
        Assert.areEqual(403, response.getStatusCode());
    }

    @IsTest
    static void multipleCalloutMock() {
        // Setup
        new HttpMock()
            .get('/api/v1')
            .statusCodeOk()
            .get('/api/v2')
            .statusCodeNotFound()
            .mock();

        Test.startTest();
        HttpResponse response1 = new TestApi().makeCallout('GET', '/api/v1');
        HttpResponse response2 = new TestApi().makeCallout('GET', '/api/v2');
        Test.stopTest();

        Assert.areEqual(200, response1.getStatusCode());
        Assert.areEqual(404, response2.getStatusCode());
    }

    private class TestApi {
        private final String BASE_API_URL = URL.getCurrentRequestUrl().toExternalForm();

        public HttpResponse makeCallout(String method, String endpoint) {
            HttpRequest request = new HttpRequest();

            request.setMethod(method);
            request.setEndpoint(BASE_API_URL + endpoint);
            request.setHeader('Content-Type', 'application/json');
            request.setBody(JSON.serialize(new Map<String, String>{ 'name' => 'callout' }));

            return new Http().send(request);
        }
    }
}
