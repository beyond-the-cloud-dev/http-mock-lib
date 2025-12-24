/**
 * Copyright (c) 2025 Beyond The Cloud Sp. z o.o. (BeyondTheCloud.Dev)
 * Licensed under the MIT License (https://github.com/beyond-the-cloud-dev/http-mock-lib/blob/main/LICENSE)
 *
 * PMD False Positives:
 * - ExcessivePublicCount: It is a library class and exposes all necessary methods to construct a http mock.
**/
@IsTest
@SuppressWarnings('PMD.ExcessivePublicCount')
public class HttpMock implements HttpMockLib, HttpCalloutMock {
    /*
        new HttpMock
            .getGetRequestsCount('/api/v1/authorize');
            .whenGetOn('/api/v1/authorize').body('{ "token": "aZ3Xb7Qk" }').contentTypeJson().statusCodeOk()
            .whenPostOn('/api/v1/create').body('{ "success": true, "message": null }').contentTypeJson().statusCodeOk()
            .mock();

        Test.startTest();
        // ...
        Test.stopTest();

        Assert.areEqual(1, HttpMock.getGetRequestsCount('/api/v1/authorize'), 'One GET request should be made');
        Assert.areEqual(1, HttpMock.getPostRequestsCount('/api/v1/create'), 'One POST request should be made');
    */
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
        // Static Resource
        HttpMock staticResource(String staticResourceName);
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
        // Request Counts (static) for assertions
        Integer getGetRequestsCount(String endpoint);
        Integer getPostRequestsCount(String endpoint);
        Integer getPutRequestsCount(String endpoint);
        Integer getPatchRequestsCount(String endpoint);
        Integer getDeleteRequestsCount(String endpoint);
        Integer getTraceRequestsCount(String endpoint);
        Integer getHeadRequestsCount(String endpoint);
    }

    public static Integer getGetRequestsCount(String endpoint) {
        return getRequestCount('GET', endpoint);
    }

    public static Integer getPostRequestsCount(String endpoint) {
        return getRequestCount('POST', endpoint);
    }

    public static Integer getPutRequestsCount(String endpoint) {
        return getRequestCount('PUT', endpoint);
    }

    public static Integer getPatchRequestsCount(String endpoint) {
        return getRequestCount('PATCH', endpoint);
    }

    public static Integer getDeleteRequestsCount(String endpoint) {
        return getRequestCount('DELETE', endpoint);
    }

    public static Integer getTraceRequestsCount(String endpoint) {
        return getRequestCount('TRACE', endpoint);
    }

    public static Integer getHeadRequestsCount(String endpoint) {
        return getRequestCount('HEAD', endpoint);
    }

    public static Integer getRequestCount(String httpMethod, String endpoint) {
        if (!requestCountByMethodAndEndpoint.containsKey(httpMethod)) {
            return 0;
        }

        return requestCountByMethodAndEndpoint.get(httpMethod).get(endpoint) ?? 0;
    }

    // Implementation

    private static Map<String, Map<String, List<HttpResponse>>> mocks = new Map<String, Map<String, List<HttpResponse>>>();
    private static Map<String, Map<String, Integer>> requestCountByMethodAndEndpoint = new Map<String, Map<String, Integer>>();

    private HttpResponse workingHttpResponse = null;

    public HttpMock whenGetOn(String endpointToMock) {
        return this.add('GET', endpointToMock);
    }

    public HttpMock whenPostOn(String endpointToMock) {
        return this.add('POST', endpointToMock);
    }

    public HttpMock whenPutOn(String endpointToMock) {
        return this.add('PUT', endpointToMock);
    }

    public HttpMock whenPatchOn(String endpointToMock) {
        return this.add('PATCH', endpointToMock);
    }

    public HttpMock whenDeleteOn(String endpointToMock) {
        return this.add('DELETE', endpointToMock);
    }

    public HttpMock whenTraceOn(String endpointToMock) {
        return this.add('TRACE', endpointToMock);
    }

    public HttpMock whenHeadOn(String endpointToMock) {
        return this.add('HEAD', endpointToMock);
    }

    private HttpMock add(String httpMethod, String endpointToMock) {
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

    public HttpMock body(Object body) {
        return this.body(JSON.serialize(body));
    }

    public HttpMock body(String body) {
        this.workingHttpResponse.setBody(body);
        return this;
    }

    public HttpMock body(Blob body) {
        this.workingHttpResponse.setBodyAsBlob(body);
        return this;
    }

    public HttpMock contentTypePlainText() {
        return this.contentType('text/plain');
    }

    public HttpMock contentTypeHtml() {
        return this.contentType('text/html');
    }

    public HttpMock contentTypeCsv() {
        return this.contentType('text/csv');
    }

    public HttpMock contentTypeJson() {
        return this.contentType('application/json');
    }

    public HttpMock contentTypePdf() {
        return this.contentType('application/pdf');
    }

    public HttpMock contentTypeXml() {
        return this.contentType('application/xml');
    }

    public HttpMock contentTypeFormUrlencoded() {
        return this.contentType('application/x-www-form-urlencoded');
    }

    public HttpMock contentType(String contentType) {
        return this.header('Content-Type', contentType);
    }

    public HttpMock header(String key, String value) {
        this.workingHttpResponse.setHeader(key, value);
        return this;
    }

    public HttpMock staticResource(String staticResourceName) {
        StaticResource staticResource = null;

        try {
            staticResource = [SELECT Body FROM StaticResource WHERE Name = :staticResourceName LIMIT 1];
        } catch (QueryException queryEx) {
            throw new StaticResourceNotFoundException('Static Resource "' + staticResourceName + '" not found.');
        }
        
        return this.body(staticResource.Body);
    }

    public HttpMock statusCodeOk() {
        return this.statusCode(200);
    }

    public HttpMock statusCodeCreated() {
        return this.statusCode(201);
    }

    public HttpMock statusCodeAccepted() {
        return this.statusCode(202);
    }

    public HttpMock statusCodeNoContent() {
        return this.statusCode(204);
    }

    public HttpMock statusCodeBadRequest() {
        return this.statusCode(400);
    }

    public HttpMock statusCodeUnauthorized() {
        return this.statusCode(401);
    }

    public HttpMock statusCodeForbidden() {
        return this.statusCode(403);
    }

    public HttpMock statusCodeNotFound() {
        return this.statusCode(404);
    }

    public HttpMock statusCodeMethodNotAllowed() {
        return this.statusCode(405);
    }

    public HttpMock statusCodeInternalServerError() {
        return this.statusCode(500);
    }

    public HttpMock statusCodeNotImplemented() {
        return this.statusCode(501);
    }

    public HttpMock statusCodeBadGateway() {
        return this.statusCode(502);
    }

    public HttpMock statusCodeServiceUnavailable() {
        return this.statusCode(503);
    }

    public HttpMock statusCodeGatewayTimeout() {
        return this.statusCode(504);
    }

    public HttpMock statusCode(Integer statusCode) {
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
