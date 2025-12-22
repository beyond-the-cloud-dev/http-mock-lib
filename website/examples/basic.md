# Basic Examples

Learn HTTP Mock Lib fundamentals through practical examples.

## Simple GET Request

The most basic use case - mocking a single GET endpoint:

```apex
@IsTest
static void testSimpleGet() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/users')
    .body('{"id": "123", "name": "John Doe"}')
    .statusCodeOk()
    .mock();

  // Act
  Test.startTest();
  UserService service = new UserService();
  User result = service.getUser();
  Test.stopTest();

  // Assert
  Assert.areEqual('John Doe', result.name);
}
```

## POST Request

Mock a POST request that creates a resource:

```apex
@IsTest
static void testCreateUser() {
  // Arrange
  new HttpMock()
    .whenPostOn('/api/users')
    .body('{"id": "456", "created": true}')
    .statusCodeCreated()
    .mock();

  // Act
  Test.startTest();
  UserService service = new UserService();
  String userId = service.createUser('John Doe');
  Test.stopTest();

  // Assert
  Assert.areEqual('456', userId);
}
```

## Using Objects as Bodies

Instead of JSON strings, you can pass Apex objects:

```apex
@IsTest
static void testWithObjectBody() {
  // Arrange
  Map<String, Object> responseData = new Map<String, Object>{
    'users' => new List<Map<String, String>>{
      new Map<String, String>{ 'id' => '1', 'name' => 'Alice' },
      new Map<String, String>{ 'id' => '2', 'name' => 'Bob' }
    },
    'total' => 2
  };

  new HttpMock()
    .whenGetOn('/api/users')
    .body(responseData)
    .statusCodeOk()
    .mock();

  // Act
  Test.startTest();
  List<User> users = new UserService().getUsers();
  Test.stopTest();

  // Assert
  Assert.areEqual(2, users.size());
}
```

## Multiple Endpoints

Mock several endpoints in one test:

```apex
@IsTest
static void testMultipleEndpoints() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/auth/token')
      .body('{"token": "xyz123"}')
      .statusCodeOk()
    .whenPostOn('/api/users')
      .body('{"id": "789"}')
      .statusCodeCreated()
    .whenDeleteOn('/api/users/789')
      .statusCodeNoContent()
    .mock();

  // Act
  Test.startTest();
  UserService service = new UserService();
  service.authenticate();
  String userId = service.createUser('Test User');
  service.deleteUser(userId);
  Test.stopTest();

  // Assert
  Assert.isNotNull(userId);
}
```

## Custom Headers

Add custom headers to your response:

```apex
@IsTest
static void testWithCustomHeaders() {
  // Arrange
  new HttpMock()
    .whenGetOn('/api/users')
    .body('{"users": []}')
    .header('X-Total-Count', '100')
    .header('X-Page-Number', '1')
    .header('Cache-Control', 'no-cache')
    .statusCodeOk()
    .mock();

  // Act
  Test.startTest();
  ApiResponse response = new UserService().getUsersWithMetadata();
  Test.stopTest();

  // Assert
  Assert.areEqual(100, response.totalCount);
}
```

## Different Content Types

### XML Response

```apex
@IsTest
static void testXmlResponse() {
  // Arrange
  String xmlData = '<?xml version="1.0"?>' +
    '<user>' +
      '<id>123</id>' +
      '<name>John Doe</name>' +
    '</user>';

  new HttpMock()
    .whenGetOn('/api/user.xml')
    .body(xmlData)
    .contentTypeXml()
    .statusCodeOk()
    .mock();

  // Act
  Test.startTest();
  User user = new UserService().getUserAsXml();
  Test.stopTest();

  // Assert
  Assert.areEqual('123', user.id);
}
```

### CSV Response

```apex
@IsTest
static void testCsvExport() {
  // Arrange
  String csvData = 'id,name,email\n' +
                   '1,John,john@example.com\n' +
                   '2,Jane,jane@example.com';

  new HttpMock()
    .whenGetOn('/api/users/export')
    .body(csvData)
    .contentTypeCsv()
    .header('Content-Disposition', 'attachment; filename="users.csv"')
    .statusCodeOk()
    .mock();

  // Act
  Test.startTest();
  String csvContent = new UserService().exportUsers();
  Test.stopTest();

  // Assert
  Assert.isTrue(csvContent.contains('John'));
}
```

## Default Values

If you don't specify certain properties, HTTP Mock uses sensible defaults:

```apex
@IsTest
static void testDefaults() {
  // This mock uses all defaults:
  // - Status Code: 200 (OK)
  // - Content-Type: application/json
  // - Body: {}
  new HttpMock()
    .whenGetOn('/api/ping')
    .mock();

  // Act
  Test.startTest();
  Boolean pong = new ApiService().ping();
  Test.stopTest();

  // Assert
  Assert.isTrue(pong);
}
```

## Minimal Example

The absolute minimum needed for a mock:

```apex
@IsTest
static void testMinimalMock() {
  new HttpMock()
    .whenGetOn('/api/status')
    .mock();

  Test.startTest();
  new ApiService().checkStatus();
  Test.stopTest();
}
```

## Tips

1. **Call `.mock()` last** - Always end with `.mock()` to activate your configuration

2. **One mock per test** - Create a fresh HttpMock for each test method

3. **Match real endpoints** - Use the same paths your code actually calls

4. **Use meaningful data** - Test with realistic response data

## Next Steps

- [Multiple Endpoints Examples](/examples/multiple-endpoints)
- [Custom Headers Examples](/examples/custom-headers)
- [Error Handling Examples](/examples/error-handling)
- [API Reference](/api/)
