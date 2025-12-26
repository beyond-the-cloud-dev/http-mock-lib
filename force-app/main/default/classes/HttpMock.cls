/**
 * Copyright (c) 2025 Beyond The Cloud Sp. z o.o. (BeyondTheCloud.Dev)
 * Licensed under the MIT License (https://github.com/beyond-the-cloud-dev/http-mock-lib/blob/main/LICENSE)
 *
 * PMD False Positives:
 * - ExcessivePublicCount: It is a library class and exposes all necessary methods to construct a http mock.
 * - FieldDeclarationsShouldBeAtStart: It is a library class and important methods are on the top.
 * - CognitiveComplexity: It is a library class and the code is complex but it is necessary to keep it this way.
 * - CyclomaticComplexity: It is a library class and the code is complex but it is necessary to keep it this way.
**/
@SuppressWarnings('PMD.ExcessivePublicCount,PMD.FieldDeclarationsShouldBeAtStart,PMD.CognitiveComplexity,PMD.CyclomaticComplexity')
@IsTest
global class HttpMock implements HttpStubbing, HttpCalloutMock {
    /*
        new HttpMock
            .whenGetOn('/api/v1/authorize')
            .body('{ "token": "aZ3Xb7Qk" }')
            .contentTypeJson()
            .statusCodeOk()
            .whenPostOn('/api/v1/create')
            .body('{ "success": true, "message": null }')
            .contentTypeJson()
            .statusCodeOk()
            .mock();

        Test.startTest();
        // ...
        Test.stopTest();

        Assert.areEqual(1, HttpMock.requestsTo('/api/v1/authorize').get(), 'One GET request should be made');
        Assert.areEqual(1, HttpMock.requestsTo('/api/v1/create').post(), 'One POST request should be made');
    */
    global interface HttpStubbing {
        HttpStubbing whenGetOn(String endpointToMock);
        HttpStubbing whenPostOn(String endpointToMock);
        HttpStubbing whenPutOn(String endpointToMock);
        HttpStubbing whenPatchOn(String endpointToMock);
        HttpStubbing whenDeleteOn(String endpointToMock);
        HttpStubbing whenTraceOn(String endpointToMock);
        HttpStubbing whenHeadOn(String endpointToMock);
        // Body
        HttpStubbing body(Object body);
        HttpStubbing body(String body);
        HttpStubbing body(Blob body);
        // Static Resource
        HttpStubbing staticResource(String staticResourceName);
        // Content-Type
        HttpStubbing contentTypePlainText(); // text/plain
        HttpStubbing contentTypeHtml(); // text/html
        HttpStubbing contentTypeCsv(); // text/csv
        HttpStubbing contentTypeJson(); // application/json
        HttpStubbing contentTypeXml(); // application/xml
        HttpStubbing contentTypePdf(); // application/pdf
        HttpStubbing contentTypeFormUrlencoded(); // application/x-www-form-urlencoded
        HttpStubbing contentType(String contentType);
        // Status Code
        HttpStubbing statusCodeOk(); // 200
        HttpStubbing statusCodeCreated(); // 201
        HttpStubbing statusCodeAccepted(); // 202
        HttpStubbing statusCodeNoContent(); // 204
        HttpStubbing statusCodeBadRequest(); // 400
        HttpStubbing statusCodeUnauthorized(); // 401
        HttpStubbing statusCodeForbidden(); // 403
        HttpStubbing statusCodeNotFound(); // 404
        HttpStubbing statusCodeMethodNotAllowed(); // 405
        HttpStubbing statusCodeInternalServerError(); // 500
        HttpStubbing statusCodeNotImplemented(); // 501
        HttpStubbing statusCodeBadGateway(); // 502
        HttpStubbing statusCodeServiceUnavailable(); // 503
        HttpStubbing statusCodeGatewayTimeout(); // 504
        HttpStubbing statusCode(Integer statusCode);
        // Headers
        HttpStubbing header(String key, String value);
        // Mock
        void mock();
    }

    // Request Counts for assertions
    global static Requests requestsTo(String endpoint) {
        return HttpMock.requestsByEndpoint.get(endpoint) ?? new HttpMockRequests();
    }

    global interface Requests {
        Integer all();

        Integer get();
        Integer post();
        Integer put();
        Integer patch();
        Integer deletex(); // delete is a reserved keyword
        Integer trace();
        Integer head();
    }

    // Implementation

    private static Map<String, Map<String, List<HttpResponse>>> mocks = new Map<String, Map<String, List<HttpResponse>>>();
    private static Map<String, HttpMockRequests> requestsByEndpoint = new Map<String, HttpMockRequests>();

    private HttpResponse workingHttpResponse = null;
    
    public HttpStubbing whenGetOn(String endpointToMock) {
        return this.add('GET', endpointToMock);
    }

    public HttpStubbing whenPostOn(String endpointToMock) {
        return this.add('POST', endpointToMock);
    }

    public HttpStubbing whenPutOn(String endpointToMock) {
        return this.add('PUT', endpointToMock);
    }

    public HttpStubbing whenPatchOn(String endpointToMock) {
        return this.add('PATCH', endpointToMock);
    }

    public HttpStubbing whenDeleteOn(String endpointToMock) {
        return this.add('DELETE', endpointToMock);
    }

    public HttpStubbing whenTraceOn(String endpointToMock) {
        return this.add('TRACE', endpointToMock);
    }

    public HttpStubbing whenHeadOn(String endpointToMock) {
        return this.add('HEAD', endpointToMock);
    }

    private HttpStubbing add(String httpMethod, String endpointToMock) {
        this.initWhenEmpty(httpMethod, endpointToMock);

        this.workingHttpResponse = new HttpResponse();

        this.body('{}');
        this.contentTypeJson();
        this.statusCodeOk();

        mocks.get(httpMethod).get(endpointToMock).add(this.workingHttpResponse);

        return this;
    }

    private void initWhenEmpty(String httpMethod, String endpointToMock) {
        if (!mocks.containsKey(httpMethod)) {
            mocks.put(httpMethod, new Map<String, List<HttpResponse>>());
        }

        if (!mocks.get(httpMethod).containsKey(endpointToMock)) {
            mocks.get(httpMethod).put(endpointToMock, new List<HttpResponse>());
        }
    }

    public HttpStubbing body(Object body) {
        return this.body(JSON.serialize(body));
    }

    public HttpStubbing body(String body) {
        this.workingHttpResponse.setBody(body);
        return this;
    }

    public HttpStubbing body(Blob body) {
        this.workingHttpResponse.setBodyAsBlob(body);
        return this;
    }

    public HttpStubbing contentTypePlainText() {
        return this.contentType('text/plain');
    }

    public HttpStubbing contentTypeHtml() {
        return this.contentType('text/html');
    }

    public HttpStubbing contentTypeCsv() {
        return this.contentType('text/csv');
    }

    public HttpStubbing contentTypeJson() {
        return this.contentType('application/json');
    }

    public HttpStubbing contentTypePdf() {
        return this.contentType('application/pdf');
    }

    public HttpStubbing contentTypeXml() {
        return this.contentType('application/xml');
    }

    public HttpStubbing contentTypeFormUrlencoded() {
        return this.contentType('application/x-www-form-urlencoded');
    }

    public HttpStubbing contentType(String contentType) {
        return this.header('Content-Type', contentType);
    }

    public HttpStubbing header(String key, String value) {
        this.workingHttpResponse.setHeader(key, value);
        return this;
    }

    public HttpStubbing staticResource(String staticResourceName) {
        StaticResource staticResource = null;

        try {
            staticResource = [SELECT Body FROM StaticResource WHERE Name = :staticResourceName LIMIT 1];
        } catch (QueryException queryEx) {
            throw new StaticResourceNotFoundException('Static Resource "' + staticResourceName + '" not found.');
        }
        
        return this.body(staticResource.Body);
    }

    public HttpStubbing statusCodeOk() {
        return this.statusCode(200);
    }

    public HttpStubbing statusCodeCreated() {
        return this.statusCode(201);
    }

    public HttpStubbing statusCodeAccepted() {
        return this.statusCode(202);
    }

    public HttpStubbing statusCodeNoContent() {
        return this.statusCode(204);
    }

    public HttpStubbing statusCodeBadRequest() {
        return this.statusCode(400);
    }

    public HttpStubbing statusCodeUnauthorized() {
        return this.statusCode(401);
    }

    public HttpStubbing statusCodeForbidden() {
        return this.statusCode(403);
    }

    public HttpStubbing statusCodeNotFound() {
        return this.statusCode(404);
    }

    public HttpStubbing statusCodeMethodNotAllowed() {
        return this.statusCode(405);
    }

    public HttpStubbing statusCodeInternalServerError() {
        return this.statusCode(500);
    }

    public HttpStubbing statusCodeNotImplemented() {
        return this.statusCode(501);
    }

    public HttpStubbing statusCodeBadGateway() {
        return this.statusCode(502);
    }

    public HttpStubbing statusCodeServiceUnavailable() {
        return this.statusCode(503);
    }

    public HttpStubbing statusCodeGatewayTimeout() {
        return this.statusCode(504);
    }

    public HttpStubbing statusCode(Integer statusCode) {
        this.workingHttpResponse.setStatusCode(statusCode);
        return this;
    }

    public void mock() {
        Test.setMock(HttpCalloutMock.class, this);
    }

    public HttpResponse respond(HttpRequest request) {
        String closestMatchingMockedEndpoint = this.findClosestMatchingMockedEndpointBasedOnRequest(request);

        String requestEndpoint = request.getEndpoint();

        if (String.isBlank(closestMatchingMockedEndpoint)) {
            throw new HttpEndpointNotMockedException('HTTP Endpoint ' + requestEndpoint + ' hasn\'t been mocked.');
        }

        String requestMethod = request.getMethod();

        List<HttpResponse> mockedHttpResponses = mocks.get(requestMethod).get(closestMatchingMockedEndpoint);

        if (mockedHttpResponses.isEmpty()) {
            throw new HttpEndpointNotMockedException('HTTP Endpoint ' + requestMethod + ' ' + requestEndpoint +  ' hasn\'t been mocked.');
        }

        this.registerRequest(requestMethod, requestEndpoint);

        if (mockedHttpResponses.size() > 1) {
            return mockedHttpResponses.remove(0);
        }

        return mockedHttpResponses.get(0);
    }

    private void registerRequest(String httpMethod, String endpoint) {
        if (!requestsByEndpoint.containsKey(endpoint)) {
            requestsByEndpoint.put(endpoint, new HttpMockRequests());
        }

        requestsByEndpoint.get(endpoint).incrementRequestCount(httpMethod);
    }

    private String findClosestMatchingMockedEndpointBasedOnRequest(HttpRequest httpRequest) {
        String httpRequestMethod = httpRequest.getMethod();
        String httpRequestEndpoint = httpRequest.getEndpoint();

        if (!mocks.containsKey(httpRequestMethod)) {
            throw new HttpMethodNotMockedException('HTTP Method ' + httpRequestMethod + ' hasn\'t been mocked.');
        }

        return this.findClosestMatchingMockedEndpoint(httpRequestEndpoint, mocks.get(httpRequestMethod).keySet());
    }

    private String findClosestMatchingMockedEndpoint(String requestEndpoint, Set<String> mockedEndpoints) {
        String closestMatchingMockedEndpoint = null;
        Integer maxMatchLength = 0;

        for (String mockedEndpoint : mockedEndpoints) {
            if (requestEndpoint.contains(mockedEndpoint) && mockedEndpoint.length() > maxMatchLength) {
                closestMatchingMockedEndpoint = mockedEndpoint;
                maxMatchLength = mockedEndpoint.length();
            }
        }

        return closestMatchingMockedEndpoint;
    }

    private class HttpMockRequests implements Requests {
        private Map<String, Integer> requestCountByMethod = new Map<String, Integer>();

        public void incrementRequestCount(String httpMethod) {
            if (!this.requestCountByMethod.containsKey(httpMethod)) {
                this.requestCountByMethod.put(httpMethod, 0);
            }
    
            this.requestCountByMethod.put(httpMethod, this.requestCountByMethod.get(httpMethod) + 1);
        }

        public Integer all() {
            Integer total = 0;

            for (Integer count : this.requestCountByMethod.values()) {
                total += count;
            }

            return total;
        }

        public Integer get() {
            return this.requestCountByMethod.get('GET') ?? 0;
        }

        public Integer post() {
            return this.requestCountByMethod.get('POST') ?? 0;
        }
        
        public Integer put() {
            return this.requestCountByMethod.get('PUT') ?? 0;
        }

        public Integer patch() {
            return this.requestCountByMethod.get('PATCH') ?? 0;
        }
        
        public Integer deletex() {
            return this.requestCountByMethod.get('DELETE') ?? 0;
        }

        public Integer trace() {
            return this.requestCountByMethod.get('TRACE') ?? 0;
        }
        
        public Integer head() {
            return this.requestCountByMethod.get('HEAD') ?? 0;
        }
    }

    public class HttpMethodNotMockedException extends Exception {}
    public class HttpEndpointNotMockedException extends Exception {}
    public class StaticResourceNotFoundException extends Exception {}
}
