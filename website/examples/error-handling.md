# Error Handling

Test how your code handles HTTP errors and edge cases.

## HTTP 400 - Bad Request

Test invalid request handling:

```apex
@IsTest
static void testBadRequest() {
  // Arrange
  new HttpMock()
    .whenPostOn('/api/users')
    .body('{"error": "Email is required"}')
    .statusCodeBadRequest()
    .mock();

  // Act & Assert
  Test.startTest();
  try {
    new UserService().createUser(''); // Empty email
    Assert.fail('Expected CalloutException');
  } catch (CalloutException e) {
    Assert.isTrue(e.getMessage().contains('Email is required'));
  }
  Test.stopTest();
}
```

## HTTP 401 - Unauthorized

Test authentication failures:

```apex
@IsTest
static void testUnauthorized() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/protected/data')
    .body('{"error": "Invalid token"}')
    .statusCodeUnauthorized()
    .mock();

  // Act & Assert
  Test.startTest();
  try {
    new ApiService().getProtectedData('invalid-token');
    Assert.fail('Expected exception');
  } catch (CalloutException e) {
    Assert.isTrue(e.getMessage().contains('Unauthorized'));
  }
  Test.stopTest();
}
```

## HTTP 404 - Not Found

Test resource not found scenarios:

```apex
@IsTest
static void testNotFound() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/users/999')
    .body('{"error": "User not found"}')
    .statusCodeNotFound()
    .mock();

  // Act
  Test.startTest();
  User user = new UserService().getUser('999');
  Test.stopTest();

  // Assert
  Assert.isNull(user, 'User should be null for 404 response');
}
```

## HTTP 500 - Internal Server Error

Test server error handling:

```apex
@IsTest
static void testServerError() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/users')
    .body('{"error": "Internal server error"}')
    .statusCodeInternalServerError()
    .mock();

  // Act & Assert
  Test.startTest();
  try {
    new UserService().getUsers();
    Assert.fail('Expected CalloutException');
  } catch (CalloutException e) {
    Assert.isTrue(e.getMessage().contains('500'));
  }
  Test.stopTest();
}
```

## HTTP 503 - Service Unavailable

Test service downtime:

```apex
@IsTest
static void testServiceUnavailable() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/users')
    .body('{"error": "Service temporarily unavailable"}')
    .statusCodeServiceUnavailable()
    .header('Retry-After', '120')
    .mock();

  // Act
  Test.startTest();
  ApiResponse response = new UserService().getUsersWithRetry();
  Test.stopTest();

  // Assert
  Assert.isTrue(response.shouldRetry);
  Assert.areEqual(120, response.retryAfter);
}
```

## Retry Logic

Test automatic retry mechanisms:

```apex
@IsTest
static void testRetryMechanism() {
  // Arrange - first two calls fail, third succeeds
  new HttpMock()
    .whenGetOn('/api/unstable')
      .body('{"error": "Timeout"}')
      .statusCodeGatewayTimeout()
    .whenGetOn('/api/unstable')
      .body('{"error": "Timeout"}')
      .statusCodeGatewayTimeout()
    .whenGetOn('/api/unstable')
      .body('{"success": true}')
      .statusCodeOk()
    .mock();

  // Act
  Test.startTest();
  ApiResponse response = new ApiService().callWithRetry();
  Test.stopTest();

  // Assert
  Assert.isTrue(response.success);
  Assert.areEqual(3, HttpMock.getRequestCount('GET', '/api/unstable'));
}
```

## Empty Response Body

Test handling of responses with no body:

```apex
@IsTest
static void testEmptyResponse() {
  // Arrange
  new HttpMock()
    .whenDeleteOn('/api/users/123')
    .statusCodeNoContent()
    .mock();

  // Act
  Test.startTest();
  Boolean deleted = new UserService().deleteUser('123');
  Test.stopTest();

  // Assert
  Assert.isTrue(deleted);
}
```

## Malformed JSON

Test handling of invalid response data:

```apex
@IsTest
static void testMalformedJson() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/broken')
    .body('{"invalid": json}')  // Invalid JSON
    .statusCodeOk()
    .mock();

  // Act & Assert
  Test.startTest();
  try {
    new ApiService().parseResponse();
    Assert.fail('Expected JSON parsing exception');
  } catch (Exception e) {
    Assert.isTrue(e instanceof JSONException);
  }
  Test.stopTest();
}
```

## Rate Limiting

Test rate limit handling:

```apex
@IsTest
static void testRateLimit() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/users')
    .body('{"error": "Rate limit exceeded"}')
    .statusCode(429)  // Too Many Requests
    .header('X-RateLimit-Remaining', '0')
    .header('X-RateLimit-Reset', '1640000000')
    .mock();

  // Act
  Test.startTest();
  ApiResponse response = new UserService().getUsers();
  Test.stopTest();

  // Assert
  Assert.isTrue(response.rateLimitExceeded);
  Assert.areEqual(1640000000, response.rateLimitReset);
}
```

## Timeout Simulation

Combine with Test.stopTest() timing to test timeouts:

```apex
@IsTest
static void testTimeout() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/slow')
    .body('{"data": "finally"}')
    .statusCodeGatewayTimeout()
    .mock();

  // Act
  Test.startTest();
  ApiService service = new ApiService();
  service.setTimeout(1000);  // 1 second timeout

  try {
    service.callSlowEndpoint();
    Assert.fail('Expected timeout exception');
  } catch (Exception e) {
    Assert.isTrue(e.getMessage().contains('timeout'));
  }
  Test.stopTest();
}
```

## Fallback Behavior

Test fallback to cached or default data:

```apex
@IsTest
static void testFallbackOnError() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/users')
    .body('{"error": "Service unavailable"}')
    .statusCodeServiceUnavailable()
    .mock();

  // Act
  Test.startTest();
  List<User> users = new UserService().getUsersWithFallback();
  Test.stopTest();

  // Assert
  Assert.isNotNull(users);
  Assert.areEqual(0, users.size(), 'Should return empty list as fallback');
}
```

## Multiple Error Scenarios

Test different error responses from the same endpoint:

```apex
@IsTest
static void testMultipleErrorTypes() {
  // Arrange
  new HttpMock()
    .whenPostOn('/api/users')
      .body('{"error": "Bad Request"}')
      .statusCodeBadRequest()
    .whenPostOn('/api/users')
      .body('{"error": "Unauthorized"}')
      .statusCodeUnauthorized()
    .whenPostOn('/api/users')
      .body('{"success": true}')
      .statusCodeCreated()
    .mock();

  // Act
  Test.startTest();
  UserService service = new UserService();

  // First call - bad request
  try {
    service.createUser('invalid-data');
    Assert.fail('Expected exception');
  } catch (CalloutException e) {
    Assert.isTrue(e.getMessage().contains('Bad Request'));
  }

  // Second call - unauthorized
  try {
    service.createUser('no-auth');
    Assert.fail('Expected exception');
  } catch (CalloutException e) {
    Assert.isTrue(e.getMessage().contains('Unauthorized'));
  }

  // Third call - success
  String userId = service.createUser('valid-data');
  Assert.isNotNull(userId);
  Test.stopTest();
}
```

## Custom Error Codes

Test custom HTTP status codes:

```apex
@IsTest
static void testCustomStatusCode() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/deprecated')
    .body('{"message": "API endpoint deprecated"}')
    .statusCode(410)  // Gone
    .header('Sunset', 'Sat, 31 Dec 2024 23:59:59 GMT')
    .mock();

  // Act & Assert
  Test.startTest();
  try {
    new ApiService().callDeprecatedEndpoint();
    Assert.fail('Expected exception for deprecated endpoint');
  } catch (Exception e) {
    Assert.isTrue(e.getMessage().contains('deprecated'));
  }
  Test.stopTest();
}
```

## Best Practices

1. **Test All Error Codes** - Don't just test the happy path; verify error handling

2. **Use Realistic Errors** - Mock error responses that match what the real API returns

3. **Verify Error Messages** - Check that your code properly parses and handles error details

4. **Test Recovery** - Verify retry logic, fallbacks, and graceful degradation

5. **Document Edge Cases** - Comment why you expect certain exceptions

## See Also

- [Status Codes API](/api/status-codes)
- [Multiple Endpoints](/examples/multiple-endpoints)
- [Basic Examples](/examples/basic)
