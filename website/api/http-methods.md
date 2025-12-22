# HTTP Methods

Mock different HTTP methods for your endpoints.

## Supported Methods

HTTP Mock Lib supports all standard HTTP methods:

- `GET` - Retrieve data
- `POST` - Create resources
- `PUT` - Update/replace resources
- `PATCH` - Partially update resources
- `DELETE` - Remove resources
- `HEAD` - Get headers only
- `TRACE` - Debug/diagnostic method

## API

### whenGetOn()

Mock a GET request.

```apex
HttpMock whenGetOn(String endpointToMock)
```

**Example:**
```apex
new HttpMock()
  .whenGetOn('/api/v1/users/123')
  .body('{"id": "123", "name": "John"}')
  .statusCodeOk()
  .mock();
```

### whenPostOn()

Mock a POST request.

```apex
HttpMock whenPostOn(String endpointToMock)
```

**Example:**
```apex
new HttpMock()
  .whenPostOn('/api/v1/users')
  .body('{"id": "456", "created": true}')
  .statusCodeCreated()
  .mock();
```

### whenPutOn()

Mock a PUT request.

```apex
HttpMock whenPutOn(String endpointToMock)
```

**Example:**
```apex
new HttpMock()
  .whenPutOn('/api/v1/users/123')
  .body('{"id": "123", "updated": true}')
  .statusCodeOk()
  .mock();
```

### whenPatchOn()

Mock a PATCH request.

```apex
HttpMock whenPatchOn(String endpointToMock)
```

**Example:**
```apex
new HttpMock()
  .whenPatchOn('/api/v1/users/123')
  .body('{"updated_field": "new_value"}')
  .statusCodeOk()
  .mock();
```

### whenDeleteOn()

Mock a DELETE request.

```apex
HttpMock whenDeleteOn(String endpointToMock)
```

**Example:**
```apex
new HttpMock()
  .whenDeleteOn('/api/v1/users/123')
  .statusCodeNoContent()
  .mock();
```

### whenHeadOn()

Mock a HEAD request.

```apex
HttpMock whenHeadOn(String endpointToMock)
```

**Example:**
```apex
new HttpMock()
  .whenHeadOn('/api/v1/users/123')
  .header('Content-Length', '1234')
  .statusCodeOk()
  .mock();
```

### whenTraceOn()

Mock a TRACE request.

```apex
HttpMock whenTraceOn(String endpointToMock)
```

**Example:**
```apex
new HttpMock()
  .whenTraceOn('/api/v1/debug')
  .body('TRACE /api/v1/debug HTTP/1.1')
  .statusCodeOk()
  .mock();
```

## Multiple Methods

You can mock multiple HTTP methods in a single test:

```apex
@IsTest
static void testCrudOperations() {
  new HttpMock()
    // Create
    .whenPostOn('/api/v1/users')
      .body('{"id": "123"}')
      .statusCodeCreated()
    // Read
    .whenGetOn('/api/v1/users/123')
      .body('{"id": "123", "name": "John"}')
      .statusCodeOk()
    // Update
    .whenPutOn('/api/v1/users/123')
      .body('{"updated": true}')
      .statusCodeOk()
    // Delete
    .whenDeleteOn('/api/v1/users/123')
      .statusCodeNoContent()
    .mock();

  Test.startTest();
  // Your CRUD operations here
  Test.stopTest();
}
```

## Endpoint Matching

The endpoint parameter should match the path used in your callout:

```apex
// If your code does:
Http http = new Http();
HttpRequest req = new HttpRequest();
req.setEndpoint('https://api.example.com/v1/users');

// Then mock like this:
new HttpMock()
  .whenGetOn('/v1/users')  // ✅ Correct - matches path
  .mock();

// Not like this:
new HttpMock()
  .whenGetOn('https://api.example.com/v1/users')  // ❌ Wrong - includes domain
  .mock();
```

## Best Practices

1. **Use Full Paths** - Include API version in the path: `/api/v1/users` instead of `/users`

2. **Match HTTP Semantics** - Use the correct method for the operation:
   - `GET` for retrieval
   - `POST` for creation
   - `PUT` for full updates
   - `PATCH` for partial updates
   - `DELETE` for removal

3. **Test All Methods** - If your service uses multiple HTTP methods, test them all

4. **RESTful Patterns** - Follow REST conventions in your mocks to match real APIs

## See Also

- [Status Codes →](/api/status-codes)
- [Response Body →](/api/response-body)
- [Examples →](/examples/basic)
