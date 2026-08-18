# HTTP Methods

Mock different HTTP methods for your endpoints.

```apex
new HttpMock()
  .whenGetOn('/api/v1/users/123')
  .whenPostOn('/api/v1/comments/')
  .mock();
```

## GET

Retrieve data.

```apex
new HttpMock()
  .whenGetOn('/api/v1/users/123')
  .body('{"id": "123", "name": "John"}')
  .statusCodeOk()
  .mock();
```

## POST

Create resources.

```apex
new HttpMock()
  .whenPostOn('/api/v1/users')
  .body('{"id": "456", "created": true}')
  .statusCodeCreated()
  .mock();
```

## PUT

Update/replace resources.

```apex
new HttpMock()
  .whenPutOn('/api/v1/users/123')
  .body('{"id": "123", "updated": true}')
  .statusCodeOk()
  .mock();
```

## PATCH

Partially update resources.

```apex
new HttpMock()
  .whenPatchOn('/api/v1/users/123')
  .body('{"updated_field": "new_value"}')
  .statusCodeOk()
  .mock();
```

## DELETE

Remove resources.

```apex
new HttpMock()
  .whenDeleteOn('/api/v1/users/123')
  .statusCodeNoContent()
  .mock();
```

## HEAD

Get headers only.

```apex
new HttpMock()
  .whenHeadOn('/api/v1/users/123')
  .header('Content-Length', '1234')
  .statusCodeOk()
  .mock();
```

## TRACE

Debug/diagnostic method.

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
    .whenPostOn('/api/v1/users')
      .body('{"id": "123"}')
      .statusCodeCreated()
    .whenGetOn('/api/v1/users/123')
      .body('{"id": "123", "name": "John"}')
      .statusCodeOk()
    .whenPutOn('/api/v1/users/123')
      .body('{"updated": true}')
      .statusCodeOk()
    .whenDeleteOn('/api/v1/users/123')
      .statusCodeNoContent()
    .mock();

  Test.startTest();
  // Your callout here
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
