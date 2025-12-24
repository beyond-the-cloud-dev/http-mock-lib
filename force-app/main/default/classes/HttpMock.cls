/**
 * Copyright (c) 2025 Beyond The Cloud Sp. z o.o. (BeyondTheCloud.Dev)
 * Licensed under the MIT License (https://github.com/beyond-the-cloud-dev/http-mock-lib/blob/main/LICENSE)
 *
 * PMD False Positives:
 * - ExcessivePublicCount: It is a library class and exposes all necessary methods to construct a http mock.
**/
@IsTest
@SuppressWarnings('PMD.ExcessivePublicCount')
public class HttpMock implements HttpStubbing, HttpCalloutMock {
    /*
        new HttpMock
            .whenGetOn('/api/v1/authorize').body('{ "token": "aZ3Xb7Qk" }').contentTypeJson().statusCodeOk()
            .whenPostOn('/api/v1/create').body('{ "success": true, "message": null }').contentTypeJson().statusCodeOk()
            .mock();

        Test.startTest();
        // ...
        Test.stopTest();

        Assert.areEqual(1, HttpMock.requestsTo('/api/v1/authorize').get(), 'One GET request should be made');
        Assert.areEqual(1, HttpMock.requestsTo('/api/v1/create').post(), 'One POST request should be made');
    */
    public interface HttpStubbing {
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
        // Request Counts (static) for assertions
        Integer getRequestsTo(String endpoint);
        Integer postRequestsTo(String endpoint);
        Integer putRequestsTo(String endpoint);
        Integer patchRequestsTo(String endpoint);
        Integer deleteRequestsTo(String endpoint);
        Integer traceRequestsTo(String endpoint);
        Integer headRequestsTo(String endpoint);
    }

    public static Integer getRequestsTo(String endpoint) {
        return getRequestCount('GET', endpoint);
    }

    public static Integer postRequestsTo(String endpoint) {
        return getRequestCount('POST', endpoint);
    }

    public static Integer putRequestsTo(String endpoint) {
        return getRequestCount('PUT', endpoint);
    }

    public static Integer patchRequestsTo(String endpoint) {
        return getRequestCount('PATCH', endpoint);
    }

    public static Integer deleteRequestsTo(String endpoint) {
        return getRequestCount('DELETE', endpoint);
    }

    public static Integer traceRequestsTo(String endpoint) {
        return getRequestCount('TRACE', endpoint);
    }

    public static Integer headRequestsTo(String endpoint) {
        return getRequestCount('HEAD', endpoint);
    }

    public static Integer getRequestCount(String httpMethod, String endpoint) {
        if (!requestCountByMethodAndEndpoint.containsKey(httpMethod)) {
            return 0;
        }

        return requestCountByMethodAndEndpoint?.get(httpMethod)?.get(endpoint) ?? 0;
    }

    // Implementation

    private static Map<String, Map<String, List<HttpResponse>>> mocks = new Map<String, Map<String, List<HttpResponse>>>();
    private static Map<String, Map<String, Integer>> requestCountByMethodAndEndpoint = new Map<String, Map<String, Integer>>();

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
        String closestMatchingMockedEndpoint = this.findClosestMatchingMockedEndpoint(request);

        String requestEndpoint = request.getEndpoint();

        if (String.isBlank(closestMatchingMockedEndpoint)) {
            throw new HttpEndpointNotMockedException('HTTP Endpoint ' + requestEndpoint + ' hasn\'t been mocked.');
        }

        String requestMethod = request.getMethod();

        List<HttpResponse> mockedHttpResponses = mocks.get(requestMethod).get(closestMatchingMockedEndpoint);

        if (mockedHttpResponses.isEmpty()) {
            throw new HttpEndpointNotMockedException('HTTP Endpoint ' + requestMethod + ' ' + requestEndpoint +  ' hasn\'t been mocked.');
        }

        this.incrementRequestCount(requestMethod, closestMatchingMockedEndpoint);

        if (mockedHttpResponses.size() > 1) {
            return mockedHttpResponses.remove(0);
        }

        return mockedHttpResponses.get(0);
    }

    private String findClosestMatchingMockedEndpoint(HttpRequest httpRequest) {
        String httpRequestMethod = httpRequest.getMethod();

        if (!mocks.containsKey(httpRequestMethod)) {
            throw new HttpMethodNotMockedException('HTTP Method ' + httpRequestMethod + ' hasn\'t been mocked.');
        }

        String httpRequestEndpoint = httpRequest.getEndpoint();
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

    private void incrementRequestCount(String httpMethod, String endpoint) {
        if (!requestCountByMethodAndEndpoint.containsKey(httpMethod)) {
            requestCountByMethodAndEndpoint.put(httpMethod, new Map<String, Integer>());
        }

        Integer currentCount = requestCountByMethodAndEndpoint.get(httpMethod).get(endpoint) ?? 0;
        requestCountByMethodAndEndpoint.get(httpMethod).put(endpoint, currentCount + 1);
    }

    public class HttpMethodNotMockedException extends Exception {}
    public class HttpEndpointNotMockedException extends Exception {}
    public class StaticResourceNotFoundException extends Exception {}
}
