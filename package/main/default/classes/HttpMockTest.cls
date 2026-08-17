/**
 * Copyright (c) 2025 Beyond The Cloud Sp. z o.o. (BeyondTheCloud.Dev)
 * Licensed under the MIT License (https://github.com/beyond-the-cloud-dev/http-mock-lib/blob/main/LICENSE)
 *
 * v1.3.0
 * 
 * PMD False Positives:
 * - CognitiveComplexity: It is a test class and the code is complex but it is necessary to keep it this way.
 * - CyclomaticComplexity: It is a test class and the code is complex but it is necessary to keep it this way.
**/
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveRunAs,PMD.CognitiveComplexity,PMD.CyclomaticComplexity')
@IsTest(IsParallel=true)
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
		
		Assert.isNotNull(caughtEx, 'Exception should be thrown');
		Assert.areEqual('Static Resource "' + staticResourceName + '" not found.', caughtEx.getMessage(), 'Message should be Static Resource "' + staticResourceName + '" not found.');
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
	static void getRequestsToWithMultipleEndpoints() {
		new HttpMock()
			.whenGetOn('/api/v1').statusCodeOk()
			.whenGetOn('/api/v2').statusCodeOk()
			.mock();

		Test.startTest();
		new TestApi().makeCallout('GET', '/api/v1');
		new TestApi().makeCallout('GET', '/api/v2');
		Test.stopTest();

		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').get(), 'Request count should be 1');
		Assert.areEqual(1, HttpMock.requestsTo('/api/v2').get(), 'Request count should be 1');
	}

	@IsTest
	static void allRequestsTo() {
		new HttpMock()
			.whenGetOn('/api/v1').statusCodeOk()
			.whenPostOn('/api/v1').statusCodeOk()
			.whenPutOn('/api/v1').statusCodeOk()
			.whenPatchOn('/api/v1').statusCodeOk()
			.whenDeleteOn('/api/v1').statusCodeOk()
			.whenTraceOn('/api/v1').statusCodeOk()
			.whenHeadOn('/api/v1').statusCodeOk()
			.mock();

		Test.startTest();
		new TestApi().makeCallout('GET', '/api/v1');
		new TestApi().makeCallout('POST', '/api/v1');
		new TestApi().makeCallout('PUT', '/api/v1');
		new TestApi().makeCallout('PATCH', '/api/v1');
		new TestApi().makeCallout('DELETE', '/api/v1');
		new TestApi().makeCallout('TRACE', '/api/v1');
		new TestApi().makeCallout('HEAD', '/api/v1');
		Test.stopTest();

		Assert.areEqual(7, HttpMock.requestsTo('/api/v1').all(), 'Request count should be 7');
		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').get(), 'Request count should be 1');
		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').post(), 'Request count should be 1');
		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').put(), 'Request count should be 1');
		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').patch(), 'Request count should be 1');
		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').deletex(), 'Request count should be 1');
		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').trace(), 'Request count should be 1');
		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').head(), 'Request count should be 1');
	}

	@IsTest
	static void getRequestsTo() {
		new HttpMock().whenGetOn('/api/v1').statusCodeOk().mock();

		Test.startTest();
		new TestApi().makeCallout('GET', '/api/v1');
		new TestApi().makeCallout('GET', '/api/v1');
		Test.stopTest();

		Assert.areEqual(2, HttpMock.requestsTo('/api/v1').get(), 'Request count should be 2');
	}

	@IsTest
	static void postRequestsTo() {
		new HttpMock().whenPostOn('/api/v1').statusCodeOk().mock();

		Test.startTest();
		new TestApi().makeCallout('POST', '/api/v1');
		Test.stopTest();

		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').post(), 'Request count should be 1');
	}

	@IsTest
	static void putRequestsTo() {
		new HttpMock().whenPutOn('/api/v1').statusCodeOk().mock();

		Test.startTest();
		new TestApi().makeCallout('PUT', '/api/v1');
		Test.stopTest();

		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').put(), 'Request count should be 1');
	}

	@IsTest
	static void patchRequestsTo() {
		new HttpMock().whenPatchOn('/api/v1').statusCodeOk().mock();

		Test.startTest();
		new TestApi().makeCallout('PATCH', '/api/v1');
		Test.stopTest();

		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').patch(), 'Request count should be 1');
	}

	@IsTest
	static void deleteRequestsTo() {
		new HttpMock().whenDeleteOn('/api/v1').statusCodeOk().mock();

		Test.startTest();
		new TestApi().makeCallout('DELETE', '/api/v1');
		Test.stopTest();

		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').deletex(), 'Request count should be 1');
	}   

	@IsTest
	static void traceRequestsTo() {
		new HttpMock().whenTraceOn('/api/v1').statusCodeOk().mock();

		Test.startTest();
		new TestApi().makeCallout('TRACE', '/api/v1');
		Test.stopTest();

		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').trace(), 'Request count should be 1');
	}

	@IsTest
	static void headRequestsTo() {
		new HttpMock().whenHeadOn('/api/v1').statusCodeOk().mock();

		Test.startTest();
		new TestApi().makeCallout('HEAD', '/api/v1');
		Test.stopTest();

		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').head(), 'Request count should be 1');
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

	@IsTest
	static void statusText() {
		new HttpMock()
			.whenGetOn('/api/v1').statusCodeServiceUnavailable().status('Service Unavailable')
			.mock();

		Test.startTest();
		HttpResponse response = new TestApi().makeCallout('GET', '/api/v1');
		Test.stopTest();

		Assert.areEqual(503, response.getStatusCode(), 'Status code should be 503');
		Assert.areEqual('Service Unavailable', response.getStatus(), 'Status should be Service Unavailable');
	}

	@IsTest
	static void throwsException() {
		new HttpMock()
			.whenPostOn('/api/v1').throwsException(new CalloutException('Read timed out'))
			.mock();

		CalloutException thrown = null;

		Test.startTest();
		try {
			new TestApi().makeCallout('POST', '/api/v1');
		} catch (CalloutException e) {
			thrown = e;
		}
		Test.stopTest();

		Assert.isNotNull(thrown, 'Callout exception should be thrown');
		Assert.areEqual('Read timed out', thrown.getMessage(), 'Message should be Read timed out');
	}

	@IsTest
	static void throwsDefaultCalloutException() {
		new HttpMock()
			.whenGetOn('/api/v1').throwsException()
			.mock();

		CalloutException thrown = null;

		Test.startTest();
		try {
			new TestApi().makeCallout('GET', '/api/v1');
		} catch (CalloutException e) {
			thrown = e;
		}
		Test.stopTest();

		Assert.isNotNull(thrown, 'Callout exception should be thrown by default');
	}

	@IsTest
	static void throwsExceptionOfAnyType() {
		new HttpMock()
			.whenGetOn('/api/v1').throwsException(new IllegalArgumentException('Bad request'))
			.mock();

		IllegalArgumentException thrown = null;

		Test.startTest();
		try {
			new TestApi().makeCallout('GET', '/api/v1');
		} catch (IllegalArgumentException e) {
			thrown = e;
		}
		Test.stopTest();

		Assert.isNotNull(thrown, 'Illegal argument exception should be thrown');
		Assert.areEqual('Bad request', thrown.getMessage(), 'Message should be Bad request');
	}

	@IsTest
	static void throwsExceptionAfterSuccessfulResponses() {
		new HttpMock()
			.whenGetOn('/api/v1').statusCodeOk()
			.whenGetOn('/api/v1').statusCodeOk()
			.whenGetOn('/api/v1').throwsException(new CalloutException('Connection reset'))
			.mock();

		CalloutException thrown = null;

		Test.startTest();
		HttpResponse first = new TestApi().makeCallout('GET', '/api/v1');
		HttpResponse second = new TestApi().makeCallout('GET', '/api/v1');
		try {
			new TestApi().makeCallout('GET', '/api/v1');
		} catch (CalloutException e) {
			thrown = e;
		}
		Test.stopTest();

		Assert.areEqual(200, first.getStatusCode(), 'First status code should be 200');
		Assert.areEqual(200, second.getStatusCode(), 'Second status code should be 200');
		Assert.isNotNull(thrown, 'Third callout should throw');
		Assert.areEqual('Connection reset', thrown.getMessage(), 'Message should be Connection reset');
	}

	@IsTest
	static void recoversAfterThrownException() {
		new HttpMock()
			.whenGetOn('/api/v1').throwsException(new CalloutException('Connection reset'))
			.whenGetOn('/api/v1').statusCodeOk()
			.mock();

		CalloutException thrown = null;

		Test.startTest();
		try {
			new TestApi().makeCallout('GET', '/api/v1');
		} catch (CalloutException e) {
			thrown = e;
		}
		HttpResponse retry = new TestApi().makeCallout('GET', '/api/v1');
		Test.stopTest();

		Assert.isNotNull(thrown, 'First callout should throw');
		Assert.areEqual(200, retry.getStatusCode(), 'Retry status code should be 200');
	}

	@IsTest
	static void throwsExceptionIsCountedAsARequest() {
		new HttpMock()
			.whenPostOn('/api/v1').throwsException(new CalloutException('Read timed out'))
			.mock();

		Test.startTest();
		try {
			new TestApi().makeCallout('POST', '/api/v1');
		} catch (CalloutException e) {
			Assert.areEqual('Read timed out', e.getMessage(), 'Message should be Read timed out');
		}
		Test.stopTest();

		Assert.areEqual(1, HttpMock.requestsTo('/api/v1').post(), 'Request count should be 1');
	}

	@IsTest
	static void capturedRequests() {
		new HttpMock()
			.whenPostOn('/api/v1').statusCodeOk()
			.whenPostOn('/api/v1').statusCodeOk()
			.mock();

		Test.startTest();
		new TestApi().makeCallout('POST', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('POST', '/api/v1', '{"id":2}');
		Test.stopTest();

		List<HttpRequest> captured = HttpMock.requestsTo('/api/v1').captured();

		Assert.areEqual(2, captured.size(), 'Two requests should be captured');
		Assert.areEqual('{"id":1}', captured[0].getBody(), 'First body should be {"id":1}');
		Assert.areEqual('{"id":2}', captured[1].getBody(), 'Second body should be {"id":2}');
	}

	@IsTest
	static void lastRequest() {
		new HttpMock()
			.whenPostOn('/api/v1').statusCodeOk()
			.whenPostOn('/api/v1').statusCodeOk()
			.mock();

		Test.startTest();
		new TestApi().makeCallout('POST', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('POST', '/api/v1', '{"id":2}');
		Test.stopTest();

		HttpRequest lastRequest = HttpMock.requestsTo('/api/v1').last();

		Assert.areEqual('{"id":2}', lastRequest.getBody(), 'Last body should be {"id":2}');
		Assert.areEqual('POST', lastRequest.getMethod(), 'Last method should be POST');
		Assert.areEqual('application/json', lastRequest.getHeader('Content-Type'), 'Content-Type should be application/json');
	}

	@IsTest
	static void lastRequestWhenNoneWereMade() {
		new HttpMock()
			.whenGetOn('/api/v1').statusCodeOk()
			.mock();

		Test.startTest();
		HttpRequest lastRequest = HttpMock.requestsTo('/api/v1').last();
		Test.stopTest();

		Assert.isNull(lastRequest, 'Last request should be null');
		Assert.areEqual(0, HttpMock.requestsTo('/api/v1').captured().size(), 'No request should be captured');
	}

	@IsTest
	static void capturedGets() {
		new HttpMock()
			.whenGetOn('/api/v1')
			.whenPostOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('GET', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('POST', '/api/v1', '{"id":2}');
		Test.stopTest();

		List<HttpRequest> captured = HttpMock.requestsTo('/api/v1').capturedGets();

		Assert.areEqual(1, captured.size(), 'One GET request should be captured');
		Assert.areEqual('{"id":1}', captured[0].getBody(), 'GET body should be {"id":1}');
	}

	@IsTest
	static void capturedPosts() {
		new HttpMock()
			.whenPostOn('/api/v1')
			.whenGetOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('POST', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":2}');
		Test.stopTest();

		List<HttpRequest> captured = HttpMock.requestsTo('/api/v1').capturedPosts();

		Assert.areEqual(1, captured.size(), 'One POST request should be captured');
		Assert.areEqual('{"id":1}', captured[0].getBody(), 'POST body should be {"id":1}');
	}

	@IsTest
	static void capturedPuts() {
		new HttpMock()
			.whenPutOn('/api/v1')
			.whenGetOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('PUT', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":2}');
		Test.stopTest();

		List<HttpRequest> captured = HttpMock.requestsTo('/api/v1').capturedPuts();

		Assert.areEqual(1, captured.size(), 'One PUT request should be captured');
		Assert.areEqual('{"id":1}', captured[0].getBody(), 'PUT body should be {"id":1}');
	}

	@IsTest
	static void capturedPatches() {
		new HttpMock()
			.whenPatchOn('/api/v1')
			.whenGetOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('PATCH', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":2}');
		Test.stopTest();

		List<HttpRequest> captured = HttpMock.requestsTo('/api/v1').capturedPatches();

		Assert.areEqual(1, captured.size(), 'One PATCH request should be captured');
		Assert.areEqual('{"id":1}', captured[0].getBody(), 'PATCH body should be {"id":1}');
	}

	@IsTest
	static void capturedDeletes() {
		new HttpMock()
			.whenDeleteOn('/api/v1')
			.whenGetOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('DELETE', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":2}');
		Test.stopTest();

		List<HttpRequest> captured = HttpMock.requestsTo('/api/v1').capturedDeletes();

		Assert.areEqual(1, captured.size(), 'One DELETE request should be captured');
		Assert.areEqual('{"id":1}', captured[0].getBody(), 'DELETE body should be {"id":1}');
	}

	@IsTest
	static void capturedTraces() {
		new HttpMock()
			.whenTraceOn('/api/v1')
			.whenGetOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('TRACE', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":2}');
		Test.stopTest();

		List<HttpRequest> captured = HttpMock.requestsTo('/api/v1').capturedTraces();

		Assert.areEqual(1, captured.size(), 'One TRACE request should be captured');
		Assert.areEqual('{"id":1}', captured[0].getBody(), 'TRACE body should be {"id":1}');
	}

	@IsTest
	static void capturedHeads() {
		new HttpMock()
			.whenHeadOn('/api/v1')
			.whenGetOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('HEAD', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":2}');
		Test.stopTest();

		List<HttpRequest> captured = HttpMock.requestsTo('/api/v1').capturedHeads();

		Assert.areEqual(1, captured.size(), 'One HEAD request should be captured');
		Assert.areEqual('{"id":1}', captured[0].getBody(), 'HEAD body should be {"id":1}');
	}

	@IsTest
	static void lastGet() {
		new HttpMock()
			.whenGetOn('/api/v1')
			.whenPostOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('GET', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":2}');
		new TestApi().makeCallout('POST', '/api/v1', '{"id":3}');
		Test.stopTest();

		Assert.areEqual('{"id":2}', HttpMock.requestsTo('/api/v1').lastGet().getBody(), 'Last GET body should be {"id":2}');
	}

	@IsTest
	static void lastPost() {
		new HttpMock()
			.whenPostOn('/api/v1')
			.whenGetOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('POST', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('POST', '/api/v1', '{"id":2}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":3}');
		Test.stopTest();

		Assert.areEqual('{"id":2}', HttpMock.requestsTo('/api/v1').lastPost().getBody(), 'Last POST body should be {"id":2}');
	}

	@IsTest
	static void lastPut() {
		new HttpMock()
			.whenPutOn('/api/v1')
			.whenGetOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('PUT', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('PUT', '/api/v1', '{"id":2}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":3}');
		Test.stopTest();

		Assert.areEqual('{"id":2}', HttpMock.requestsTo('/api/v1').lastPut().getBody(), 'Last PUT body should be {"id":2}');
	}

	@IsTest
	static void lastPatch() {
		new HttpMock()
			.whenPatchOn('/api/v1')
			.whenGetOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('PATCH', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('PATCH', '/api/v1', '{"id":2}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":3}');
		Test.stopTest();

		Assert.areEqual('{"id":2}', HttpMock.requestsTo('/api/v1').lastPatch().getBody(), 'Last PATCH body should be {"id":2}');
	}

	@IsTest
	static void lastDelete() {
		new HttpMock()
			.whenDeleteOn('/api/v1')
			.whenGetOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('DELETE', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('DELETE', '/api/v1', '{"id":2}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":3}');
		Test.stopTest();

		Assert.areEqual('{"id":2}', HttpMock.requestsTo('/api/v1').lastDelete().getBody(), 'Last DELETE body should be {"id":2}');
	}

	@IsTest
	static void lastTrace() {
		new HttpMock()
			.whenTraceOn('/api/v1')
			.whenGetOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('TRACE', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('TRACE', '/api/v1', '{"id":2}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":3}');
		Test.stopTest();

		Assert.areEqual('{"id":2}', HttpMock.requestsTo('/api/v1').lastTrace().getBody(), 'Last TRACE body should be {"id":2}');
	}

	@IsTest
	static void lastHead() {
		new HttpMock()
			.whenHeadOn('/api/v1')
			.whenGetOn('/api/v1')
			.mock();

		Test.startTest();
		new TestApi().makeCallout('HEAD', '/api/v1', '{"id":1}');
		new TestApi().makeCallout('HEAD', '/api/v1', '{"id":2}');
		new TestApi().makeCallout('GET', '/api/v1', '{"id":3}');
		Test.stopTest();

		Assert.areEqual('{"id":2}', HttpMock.requestsTo('/api/v1').lastHead().getBody(), 'Last HEAD body should be {"id":2}');
	}

	private class TestApi {
		public HttpResponse makeCallout(String method, String endpoint) {
			return this.makeCallout(method, endpoint, JSON.serialize(new Map<String, String>{ 'name' => 'callout' }));
		}

		public HttpResponse makeCallout(String method, String endpoint, String body) {
			HttpRequest request = new HttpRequest();

			request.setMethod(method);
			request.setEndpoint(endpoint);
			request.setHeader('Content-Type', 'application/json');
			request.setBody(body);

			return new Http().send(request);
		}
	}
}
