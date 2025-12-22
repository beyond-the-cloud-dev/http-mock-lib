# Response Body

Configure the response body for your mocked HTTP calls.

## Overview

HTTP Mock Lib supports three types of response bodies:
- **String** - Raw string data
- **Object** - Apex objects (automatically serialized to JSON)
- **Blob** - Binary data

## API

### body(String)

Set a string response body.

```apex
HttpMock body(String body)
```

**Example:**
```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"id": "123", "name": "John Doe"}')
  .statusCodeOk()
  .mock();
```

### body(Object)

Set an object response body. The object will be JSON-serialized automatically.

```apex
HttpMock body(Object body)
```

**Example:**
```apex
Map<String, Object> response = new Map<String, Object>{
  'id' => '123',
  'name' => 'John Doe',
  'email' => 'john@example.com'
};

new HttpMock()
  .whenGetOn('/api/users/123')
  .body(response)
  .statusCodeOk()
  .mock();
```

### body(Blob)

Set a binary response body.

```apex
HttpMock body(Blob body)
```

**Example:**
```apex
Blob pdfData = Blob.valueOf('PDF content here');

new HttpMock()
  .whenGetOn('/api/documents/123')
  .body(pdfData)
  .contentTypePdf()
  .statusCodeOk()
  .mock();
```

## Examples

### JSON String Response

```apex
new HttpMock()
  .whenGetOn('/api/v1/token')
  .body('{"access_token": "abc123", "expires_in": 3600}')
  .contentTypeJson()
  .statusCodeOk()
  .mock();
```

### Map Response

```apex
Map<String, String> tokenResponse = new Map<String, String>{
  'access_token' => 'abc123',
  'expires_in' => '3600'
};

new HttpMock()
  .whenGetOn('/api/v1/token')
  .body(tokenResponse)
  .statusCodeOk()
  .mock();
```

### List Response

```apex
List<Map<String, String>> users = new List<Map<String, String>>{
  new Map<String, String>{ 'id' => '1', 'name' => 'Alice' },
  new Map<String, String>{ 'id' => '2', 'name' => 'Bob' }
};

new HttpMock()
  .whenGetOn('/api/users')
  .body(users)
  .statusCodeOk()
  .mock();
```

### Custom Class Response

```apex
public class UserResponse {
  public String id;
  public String name;
  public String email;
}

UserResponse user = new UserResponse();
user.id = '123';
user.name = 'John Doe';
user.email = 'john@example.com';

new HttpMock()
  .whenGetOn('/api/users/123')
  .body(user)
  .statusCodeOk()
  .mock();
```

### XML Response

```apex
String xmlResponse = '<?xml version="1.0"?>' +
  '<user>' +
    '<id>123</id>' +
    '<name>John Doe</name>' +
  '</user>';

new HttpMock()
  .whenGetOn('/api/users/123')
  .body(xmlResponse)
  .contentTypeXml()
  .statusCodeOk()
  .mock();
```

### Empty Response

For responses with no body (like DELETE operations):

```apex
new HttpMock()
  .whenDeleteOn('/api/users/123')
  .statusCodeNoContent()
  .mock();
// No .body() call needed
```

### Binary Response (PDF)

```apex
Blob pdfContent = generatePdfContent();

new HttpMock()
  .whenGetOn('/api/reports/monthly.pdf')
  .body(pdfContent)
  .contentTypePdf()
  .header('Content-Disposition', 'attachment; filename="report.pdf"')
  .statusCodeOk()
  .mock();
```

## Object Serialization

When using `body(Object)`, HTTP Mock Lib uses `JSON.serialize()` to convert your object:

```apex
// This code:
new HttpMock()
  .body(new Map<String, String>{ 'key' => 'value' })
  .mock();

// Is equivalent to:
new HttpMock()
  .body('{"key":"value"}')
  .mock();
```

## Default Behavior

If you don't call `.body()`, the response body will be an empty string:

```apex
new HttpMock()
  .whenGetOn('/api/ping')
  .statusCodeOk()
  .mock();
// Response body: ""
```

## Best Practices

1. **Use Objects for Complex Data** - For complex responses, use Maps or custom classes instead of building JSON strings

2. **Match Real Responses** - Use response formats that match your actual API

3. **Set Appropriate Content-Type** - Always set the correct content type for your response body

4. **Validate JSON** - If using string bodies, ensure your JSON is valid

5. **Test Edge Cases** - Mock empty responses, large responses, and malformed responses

## Common Patterns

### Paginated Response

```apex
Map<String, Object> paginatedResponse = new Map<String, Object>{
  'data' => new List<Map<String, String>>{
    new Map<String, String>{ 'id' => '1' },
    new Map<String, String>{ 'id' => '2' }
  },
  'page' => 1,
  'total_pages' => 5,
  'total_count' => 50
};

new HttpMock()
  .whenGetOn('/api/users?page=1')
  .body(paginatedResponse)
  .statusCodeOk()
  .mock();
```

### Error Response

```apex
Map<String, Object> errorResponse = new Map<String, Object>{
  'error' => new Map<String, String>{
    'code' => 'INVALID_REQUEST',
    'message' => 'Email is required'
  }
};

new HttpMock()
  .whenPostOn('/api/users')
  .body(errorResponse)
  .statusCodeBadRequest()
  .mock();
```

## See Also

- [Content Types →](/api/content-types)
- [HTTP Methods →](/api/http-methods)
- [Examples →](/examples/basic)
