# Multiple Endpoints

Mock multiple HTTP endpoints in a single test.

## Basic Pattern

Chain multiple endpoint definitions before calling `.mock()`:

```apex
@IsTest
static void testFullWorkflow() {
  new HttpMock()
    .whenGetOn('/api/auth')
      .body('{"token": "xyz"}')
      .statusCodeOk()
    .whenPostOn('/api/data')
      .body('{"success": true}')
      .statusCodeCreated()
    .whenDeleteOn('/api/data/1')
      .statusCodeNoContent()
    .mock();

  Test.startTest();
  // Your code that calls all three endpoints
  Test.stopTest();
}
```

## CRUD Operations

Test all CRUD operations in one go:

```apex
@IsTest
static void testCrudOperations() {
  new HttpMock()
    // Create
    .whenPostOn('/api/users')
      .body('{"id": "123"}')
      .statusCodeCreated()
    // Read
    .whenGetOn('/api/users/123')
      .body('{"id": "123", "name": "John"}')
      .statusCodeOk()
    // Update
    .whenPutOn('/api/users/123')
      .body('{"updated": true}')
      .statusCodeOk()
    // Delete
    .whenDeleteOn('/api/users/123')
      .statusCodeNoContent()
    .mock();

  Test.startTest();
  UserService service = new UserService();
  String userId = service.createUser('John');
  User user = service.getUser(userId);
  service.updateUser(userId, 'John Updated');
  service.deleteUser(userId);
  Test.stopTest();
}
```

## Multiple Responses for Same Endpoint

Return different responses for subsequent calls to the same endpoint:

```apex
@IsTest
static void testPollingEndpoint() {
  new HttpMock()
    .whenGetOn('/api/job/status')
      .body('{"status": "pending"}')
      .statusCodeOk()
    .whenGetOn('/api/job/status')
      .body('{"status": "processing"}')
      .statusCodeOk()
    .whenGetOn('/api/job/status')
      .body('{"status": "complete"}')
      .statusCodeOk()
    .mock();

  Test.startTest();
  JobService service = new JobService();

  // First call returns "pending"
  String status1 = service.checkJobStatus();
  Assert.areEqual('pending', status1);

  // Second call returns "processing"
  String status2 = service.checkJobStatus();
  Assert.areEqual('processing', status2);

  // Third call returns "complete"
  String status3 = service.checkJobStatus();
  Assert.areEqual('complete', status3);
  Test.stopTest();
}
```

::: tip
When you define multiple responses for the same endpoint, each call removes the first response. The last response stays and is reused for all subsequent calls.
:::

## Verify Request Count

Use `getRequestCount()` to verify how many times an endpoint was called:

```apex
@IsTest
static void testRequestCount() {
  new HttpMock()
    .whenGetOn('/api/users')
      .body('{"users": []}')
      .statusCodeOk()
    .mock();

  Test.startTest();
  UserService service = new UserService();
  service.getUsers();
  service.getUsers();
  service.getUsers();
  Test.stopTest();

  // Verify the endpoint was called exactly 3 times
  Integer count = HttpMock.getRequestCount('GET', '/api/users');
  Assert.areEqual(3, count);
}
```

## Authentication Flow

Mock a complete authentication and API call flow:

```apex
@IsTest
static void testAuthenticatedApiCall() {
  new HttpMock()
    // Step 1: Get token
    .whenPostOn('/oauth/token')
      .body('{"access_token": "abc123", "expires_in": 3600}')
      .statusCodeOk()
    // Step 2: Use token to fetch data
    .whenGetOn('/api/v1/protected/data')
      .body('{"data": "secret information"}')
      .statusCodeOk()
    .mock();

  Test.startTest();
  ApiService service = new ApiService();
  String token = service.authenticate();
  String data = service.getProtectedData(token);
  Test.stopTest();

  Assert.isNotNull(token);
  Assert.isNotNull(data);
}
```

## Pagination

Mock paginated API responses:

```apex
@IsTest
static void testPagination() {
  new HttpMock()
    // Page 1
    .whenGetOn('/api/users?page=1')
      .body('{"users": [{"id": "1"}, {"id": "2"}], "hasMore": true}')
      .header('X-Total-Count', '100')
      .statusCodeOk()
    // Page 2
    .whenGetOn('/api/users?page=2')
      .body('{"users": [{"id": "3"}, {"id": "4"}], "hasMore": true}')
      .header('X-Total-Count', '100')
      .statusCodeOk()
    // Page 3
    .whenGetOn('/api/users?page=3')
      .body('{"users": [{"id": "5"}], "hasMore": false}')
      .header('X-Total-Count', '100')
      .statusCodeOk()
    .mock();

  Test.startTest();
  UserService service = new UserService();
  List<User> allUsers = service.getAllUsersPaginated();
  Test.stopTest();

  Assert.areEqual(5, allUsers.size());
}
```

## Microservices Communication

Mock calls to multiple microservices:

```apex
@IsTest
static void testMicroservicesIntegration() {
  new HttpMock()
    // User Service
    .whenGetOn('/user-service/api/users/123')
      .body('{"id": "123", "name": "John"}')
      .statusCodeOk()
    // Order Service
    .whenGetOn('/order-service/api/orders?userId=123')
      .body('{"orders": [{"id": "order-1"}]}')
      .statusCodeOk()
    // Payment Service
    .whenGetOn('/payment-service/api/payments?orderId=order-1')
      .body('{"status": "paid"}')
      .statusCodeOk()
    .mock();

  Test.startTest();
  OrderSummaryService service = new OrderSummaryService();
  OrderSummary summary = service.getOrderSummary('123');
  Test.stopTest();

  Assert.areEqual('John', summary.userName);
  Assert.areEqual(1, summary.orders.size());
}
```

## Error and Success Mix

Mix successful and error responses:

```apex
@IsTest
static void testMixedResponses() {
  new HttpMock()
    .whenGetOn('/api/users')
      .body('{"users": []}')
      .statusCodeOk()
    .whenPostOn('/api/invalid')
      .body('{"error": "Bad Request"}')
      .statusCodeBadRequest()
    .whenGetOn('/api/notfound')
      .body('{"error": "Not Found"}')
      .statusCodeNotFound()
    .mock();

  Test.startTest();
  ApiService service = new ApiService();

  // This should succeed
  List<User> users = service.getUsers();
  Assert.isNotNull(users);

  // This should fail
  try {
    service.postInvalid();
    Assert.fail('Expected exception');
  } catch (Exception e) {
    Assert.isTrue(e.getMessage().contains('Bad Request'));
  }
  Test.stopTest();
}
```

## Best Practices

1. **Group Related Endpoints** - Mock all endpoints needed for one workflow together

2. **Maintain Call Order** - Ensure your mocks are defined in the order they'll be called

3. **Use Request Count** - Verify endpoints were called the expected number of times

4. **Test Edge Cases** - Include both success and error scenarios

## See Also

- [Basic Examples](/examples/basic)
- [Error Handling](/examples/error-handling)
- [API Reference](/api/)
