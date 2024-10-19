/**
 * Copyright (c) 2024 BeyondTheCloud.Dev
 * Licensed under the MIT License (https://github.com/beyond-the-cloud-dev/http-mock-lib/blob/main/LICENSE)
 *
 * PMD False Positives:
**/
@IsTest
public with sharing class HttpMock implements HttpMockLib, HttpCalloutMock {
    public interface HttpMockLib {
        HttpMock get(String endpoint);
        HttpMock post(String endpoint);
        HttpMock put(String endpoint);
        HttpMock patch(String endpoint);
        HttpMock deletex(String endpoint);
        HttpMock trace(String endpoint);
        HttpMock head(String endpoint);
        // Body
        HttpMock body(Object body);
        HttpMock body(String body);
        HttpMock body(Blob body);
        // Content-Type
        HttpMock contentTypePlainText(); // text/plain
        HttpMock contentTypeCsv(); // text/csv
        HttpMock contentTypeJson(); // application/json
        HttpMock contentTypeXml(); // application/xml
        HttpMock contentTypeFormUrlencoded(); // application/x-www-form-urlencoded
        HttpMock contentType(String contentType);
        // Status Code
        HttpMock statusCodeOk(); // 200
        HttpMock statusCodeBadRequest(); // 400
        HttpMock statusCodeUnauthorized(); // 401
        HttpMock statusCodeNotFound(); // 404
        HttpMock statusCodeInternalServerError(); // 500
        HttpMock statusCode(Integer statusCode);
        // Headers
        // HttpMock setHeader(String key, String value);
    }

    // Implementation

    private Map<String, Map<String, HttpResponse>> mocks = new Map<String, Map<String, HttpResponse>>();
    private HttpResponse workingHttpResponse = null;

    public HttpMock get(String endpoint) {
        return add('GET', endpoint);
    }

    public HttpMock post(String endpoint) {
        return add('POST', endpoint);
    }

    public HttpMock put(String endpoint) {
        return add('PUT', endpoint);
    }

    public HttpMock patch(String endpoint) {
        return add('PATCH', endpoint);
    }

    public HttpMock deletex(String endpoint) {
        return add('DELETE', endpoint);
    }

    public HttpMock trace(String endpoint) {
        return add('TRACE', endpoint);
    }

    public HttpMock head(String endpoint) {
        return add('HEAD', endpoint);
    }

    private HttpMock add(String httpMethod, String endpoint) {
        if (!mocks.containsKey(httpMethod)) {
            mocks.put(httpMethod, new Map<String, HttpResponse>());
        }

        workingHttpResponse = new HttpResponse();
        body('{}');
        contentTypeJson();
        statusCodeOk();
        mocks.get(httpMethod).put(endpoint, workingHttpResponse);
        return this;
    }

    public HttpMock body(Object body) {
        return body(JSON.serialize(body));
    }

    public HttpMock body(String body) {
        workingHttpResponse.setBody(body);
        return this;
    }

    public HttpMock body(Blob body) {
        workingHttpResponse.setBodyAsBlob(body);
        return this;
    }

    public HttpMock contentTypePlainText() {
        return contentType('text/plain');
    }

    public HttpMock contentTypeCsv() {
        return contentType('text/csv');
    }

    public HttpMock contentTypeJson() {
        return contentType('application/json');
    }

    public HttpMock contentTypeXml() {
        return contentType('application/xml');
    }

    public HttpMock contentTypeFormUrlencoded() {
        return contentType('application/x-www-form-urlencoded');
    }

    public HttpMock contentType(String contentType) {
        return addHeader('Content-Type', contentType);
    }

    private HttpMock addHeader(String key, String value) {
        workingHttpResponse.setHeader(key, value);
        return this;
    }

    public HttpMock statusCodeOk() {
        return statusCode(200);
    }

    public HttpMock statusCodeBadRequest() {
        return statusCode(400);
    }

    public HttpMock statusCodeUnauthorized() {
        return statusCode(401);
    }

    public HttpMock statusCodeNotFound() {
        return statusCode(404);
    }

    public HttpMock statusCodeInternalServerError() {
        return statusCode(500);
    }

    public HttpMock statusCode(Integer statusCode) {
        workingHttpResponse.setStatusCode(statusCode);
        return this;
    }

    public void mock() {
        Test.setMock(HttpCalloutMock.class, this);
    }

    public HttpResponse respond(HttpRequest request) {
        return findMockedHttpResponseForRequest(request);
    }

    private HttpResponse findMockedHttpResponseForRequest(HttpRequest httpRequest) {
        String httpMethod = httpRequest.getMethod();

        if (!mocks.containsKey(httpMethod)) {
            throw new HttpMethodNotMockedException('HTTP Method ' + httpMethod + ' hasn\'t been mocked.');
        }

        String httpEndpoint = httpRequest.getEndpoint();

        for (String url : mocks.get(httpMethod).keySet()) {
            if (httpEndpoint.contains(url)) {
                return mocks.get(httpMethod).get(url);
            }
        }

        throw new HttpEndpointNotMockedException('HTTP Endpoint ' + httpEndpoint + ' hasn\'t been mocked.');
    }

    public class HttpMethodNotMockedException extends Exception {}
    public class HttpEndpointNotMockedException extends Exception {}
}
