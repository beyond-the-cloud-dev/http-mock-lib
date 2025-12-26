# Getting Started

HTTP Mock Lib provides a fluent API for mocking HTTP callouts in Salesforce Apex tests. This guide will help you get started in minutes.

## Prerequisites

- Salesforce API version 64.0 or higher
- Basic understanding of Apex testing
- Familiarity with HTTP callouts in Salesforce

## Installation

See the [Installation Guide](/installation) for detailed instructions on adding HTTP Mock Lib to your Salesforce org.

## Your First Mock

Let's create a simple HTTP mock for a GET request:

```apex
@IsTest
private class MyFirstMockTest {
  @IsTest
  static void testSimpleGetRequest() {
    // Arrange - Set up the mock
    new HttpMock()
      .whenGetOn('/api/v1/users')
      .body('{ "name": "John Doe", "email": "john@example.com" }')
      .statusCodeOk()
      .mock();

    // Act - Make your callout
    Test.startTest();
    UserService service = new UserService();
    User result = service.getUser();
    Test.stopTest();

    // Assert - Verify the results
    Assert.areEqual('John Doe', result.name);
    Assert.areEqual('john@example.com', result.email);
  }
}
```

## Understanding the Fluent API

The HttpMock API follows a fluent pattern with three main steps:

### 1. Define the Endpoint

Specify which HTTP method and endpoint to mock:

```apex
new HttpMock()
  .whenGetOn('/api/v1/users')      // GET request
  .whenPostOn('/api/v1/users')     // POST request
  .whenPutOn('/api/v1/users/1')    // PUT request
  .whenDeleteOn('/api/v1/users/1') // DELETE request
```

### 2. Configure the Response

Set the response body, content type, status code, and headers:

```apex
.body('{ "success": true }')  // Response body
.contentTypeJson()            // Content-Type header
.statusCodeOk()               // HTTP 200
.header('X-Custom', 'value')  // Custom header
```

### 3. Activate the Mock

Call `.mock()` to activate your configuration:

```apex
.mock();
```

## Common Patterns

### Mocking Multiple Endpoints

You can mock multiple endpoints in a single test:

```apex
new HttpMock()
  .whenGetOn('/api/v1/authorize')
    .body('{ "token": "aZ3Xb7Qk" }')
    .statusCodeOk()
  .whenPostOn('/api/v1/create')
    .body('{ "success": true }')
    .statusCodeCreated()
  .mock();
```

### Using Objects as Response Bodies

Pass Apex objects that will be JSON-serialized:

```apex
Map<String, String> response = new Map<String, String>{
  'token' => 'aZ3Xb7Qk',
  'expires' => '3600'
};

new HttpMock()
  .whenGetOn('/api/v1/token')
  .body(response)
  .statusCodeOk()
  .mock();
```

### Simulating Errors

Mock error responses to test error handling:

```apex
new HttpMock()
  .whenPostOn('/api/v1/users')
  .body('{ "error": "Unauthorized" }')
  .statusCodeUnauthorized()
  .mock();

Test.startTest();
try {
  new UserService().createUser();
  Assert.fail('Expected exception');
} catch (CalloutException e) {
  Assert.isTrue(e.getMessage().contains('Unauthorized'));
}
Test.stopTest();
```