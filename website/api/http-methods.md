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

A mock matches when the request endpoint **contains** the mocked path. That is why `/v1/users` matches all of these:

```apex
request.setEndpoint('https://api.example.com/v1/users');
request.setEndpoint('callout:Example_API/v1/users');
request.setEndpoint('https://api.example.com/v1/users?active=true');
```

Keep the mocked path specific enough to be unambiguous — `/users` also matches `/v2/users`.

### Longest Match Wins

When several mocks match one request, the most specific (longest) one answers:

```apex
new HttpMock()
  .whenGetOn('/v1/users').body('[{"id": "123"}, {"id": "456"}]')
  .whenGetOn('/v1/users/123').body('{"id": "123", "name": "John"}')
  .mock();

// GET /v1/users     -> the list
// GET /v1/users/123 -> the single record
```

### Nothing Matches

- The request's verb has no mocks at all: `HttpMock.HttpMethodNotMockedException`
- The verb is mocked, but no endpoint matches: `HttpMock.HttpEndpointNotMockedException`

Both name the offending method or endpoint in their message.
