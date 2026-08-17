/**
 * Copyright (c) 2025 Beyond The Cloud Sp. z o.o. (BeyondTheCloud.Dev)
 * Licensed under the MIT License (https://github.com/beyond-the-cloud-dev/http-mock-lib/blob/main/LICENSE)
 *
 * v1.3.0
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
		// Status Text
		HttpStubbing status(String status);
		// Headers
		HttpStubbing header(String key, String value);
		// Exception
		HttpStubbing throwsException();
		HttpStubbing throwsException(Exception error);
		// Mock
		void mock();
	}

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

	// Implementation

	private static Map<String, Map<String, List<HttpResponse>>> mocks = new Map<String, Map<String, List<HttpResponse>>>();
	private static Map<String, Map<String, List<Exception>>> failures = new Map<String, Map<String, List<Exception>>>();
	private static Map<String, HttpMockRequests> requestsByEndpoint = new Map<String, HttpMockRequests>();

	private HttpResponse workingHttpResponse;
	private String workingHttpMethod;
	private String workingEndpoint;

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
		this.workingHttpResponse = new HttpResponse();
		this.workingHttpMethod = httpMethod;
		this.workingEndpoint = endpointToMock;

		this.body('{}');
		this.contentTypeJson();
		this.statusCodeOk();

		Map<String, List<HttpResponse>> mockedResponsesByEndpoint = mocks.get(httpMethod) ?? new Map<String, List<HttpResponse>>();
		List<HttpResponse> mockedResponses = mockedResponsesByEndpoint.get(endpointToMock) ?? new List<HttpResponse>();

		mockedResponses.add(this.workingHttpResponse);
		mockedResponsesByEndpoint.put(endpointToMock, mockedResponses);
		mocks.put(httpMethod, mockedResponsesByEndpoint);

		Map<String, List<Exception>> failuresByEndpoint = failures.get(httpMethod) ?? new Map<String, List<Exception>>();
		List<Exception> queuedFailures = failuresByEndpoint.get(endpointToMock) ?? new List<Exception>();

		queuedFailures.add(null);
		failuresByEndpoint.put(endpointToMock, queuedFailures);
		failures.put(httpMethod, failuresByEndpoint);

		return this;
	}

	public HttpStubbing throwsException() {
		return this.throwsException(new CalloutException());
	}

	public HttpStubbing throwsException(Exception error) {
		List<Exception> queued = failures.get(this.workingHttpMethod).get(this.workingEndpoint);
		queued.set(queued.size() - 1, error);
		return this;
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
		List<StaticResource> staticResources = [SELECT Body FROM StaticResource WHERE Name = :staticResourceName LIMIT 1];

		if (staticResources.isEmpty()) {
			throw new StaticResourceNotFoundException('Static Resource "' + staticResourceName + '" not found.');
		}

		return this.body(staticResources[0].Body);
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

	public HttpStubbing status(String status) {
		this.workingHttpResponse.setStatus(status);
		return this;
	}

	public void mock() {
		Test.setMock(HttpCalloutMock.class, this);
	}

	public HttpResponse respond(HttpRequest request) {
		String requestMethod = request.getMethod();
		String requestEndpoint = request.getEndpoint();

		if (!mocks.containsKey(requestMethod)) {
			throw new HttpMethodNotMockedException('HTTP Method ' + requestMethod + ' hasn\'t been mocked.');
		}

		String closestMatchingMockedEndpoint = this.findClosestMatchingMockedEndpoint(requestEndpoint, mocks.get(requestMethod).keySet());

		if (String.isBlank(closestMatchingMockedEndpoint)) {
			throw new HttpEndpointNotMockedException('HTTP Endpoint ' + requestEndpoint + ' hasn\'t been mocked.');
		}

		this.registerRequest(request, requestEndpoint);

		List<HttpResponse> mockedHttpResponses = mocks.get(requestMethod).get(closestMatchingMockedEndpoint);
		List<Exception> queuedFailures = failures.get(requestMethod).get(closestMatchingMockedEndpoint);

		if (mockedHttpResponses.size() > 1) {
			Exception thrownThisTurn = queuedFailures.remove(0);
			HttpResponse responseThisTurn = mockedHttpResponses.remove(0);

			if (thrownThisTurn != null) {
				throw thrownThisTurn;
			}

			return responseThisTurn;
		}

		if (queuedFailures.get(0) != null) {
			throw queuedFailures.get(0);
		}

		return mockedHttpResponses.get(0);
	}

	private void registerRequest(HttpRequest request, String endpoint) {
		HttpMockRequests endpointRequests = requestsByEndpoint.get(endpoint) ?? new HttpMockRequests();

		requestsByEndpoint.put(endpoint, endpointRequests);
		endpointRequests.register(request);
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
		private List<HttpRequest> capturedRequests = new List<HttpRequest>();
		private Map<String, List<HttpRequest>> capturedRequestsByMethod = new Map<String, List<HttpRequest>>();

		public void register(HttpRequest request) {
			List<HttpRequest> methodRequests = this.capturedByMethod(request.getMethod());

			methodRequests.add(request);

			this.capturedRequestsByMethod.put(request.getMethod(), methodRequests);
			this.capturedRequests.add(request);
		}

		public Integer all() {
			return this.capturedRequests.size();
		}

		public Integer get() {
			return this.capturedByMethod('GET').size();
		}

		public Integer post() {
			return this.capturedByMethod('POST').size();
		}

		public Integer put() {
			return this.capturedByMethod('PUT').size();
		}

		public Integer patch() {
			return this.capturedByMethod('PATCH').size();
		}

		public Integer deletex() {
			return this.capturedByMethod('DELETE').size();
		}

		public Integer trace() {
			return this.capturedByMethod('TRACE').size();
		}

		public Integer head() {
			return this.capturedByMethod('HEAD').size();
		}

		public List<HttpRequest> captured() {
			return this.capturedRequests.clone();
		}

		public List<HttpRequest> capturedGets() {
			return this.capturedByMethod('GET').clone();
		}

		public List<HttpRequest> capturedPosts() {
			return this.capturedByMethod('POST').clone();
		}

		public List<HttpRequest> capturedPuts() {
			return this.capturedByMethod('PUT').clone();
		}

		public List<HttpRequest> capturedPatches() {
			return this.capturedByMethod('PATCH').clone();
		}

		public List<HttpRequest> capturedDeletes() {
			return this.capturedByMethod('DELETE').clone();
		}

		public List<HttpRequest> capturedTraces() {
			return this.capturedByMethod('TRACE').clone();
		}

		public List<HttpRequest> capturedHeads() {
			return this.capturedByMethod('HEAD').clone();
		}

		public HttpRequest last() {
			return this.lastOf(this.capturedRequests);
		}

		public HttpRequest lastGet() {
			return this.lastOf(this.capturedByMethod('GET'));
		}

		public HttpRequest lastPost() {
			return this.lastOf(this.capturedByMethod('POST'));
		}

		public HttpRequest lastPut() {
			return this.lastOf(this.capturedByMethod('PUT'));
		}

		public HttpRequest lastPatch() {
			return this.lastOf(this.capturedByMethod('PATCH'));
		}

		public HttpRequest lastDelete() {
			return this.lastOf(this.capturedByMethod('DELETE'));
		}

		public HttpRequest lastTrace() {
			return this.lastOf(this.capturedByMethod('TRACE'));
		}

		public HttpRequest lastHead() {
			return this.lastOf(this.capturedByMethod('HEAD'));
		}

		private List<HttpRequest> capturedByMethod(String httpMethod) {
			return this.capturedRequestsByMethod.get(httpMethod) ?? new List<HttpRequest>();
		}

		private HttpRequest lastOf(List<HttpRequest> requests) {
			return requests.isEmpty() ? null : requests[requests.size() - 1];
		}
	}

	public class HttpMethodNotMockedException extends Exception {}
	public class HttpEndpointNotMockedException extends Exception {}
	public class StaticResourceNotFoundException extends Exception {}
}
