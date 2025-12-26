# Response Body

Configure the response body for your mocked HTTP calls.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .body('{"id": "123", "name": "John Doe"}')
  .mock();
```

## String

Raw string data (JSON, XML, plain text, etc.).

```apex
new HttpMock()
  .whenGetOn('/api/v1/token')
  .body('{"access_token": "abc123", "expires_in": 3600}')
  .statusCodeOk()
  .mock();
```

## Object

Apex objects are automatically serialized to JSON.

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

## Blob

Binary data for files.

```apex
Blob pdfData = Blob.valueOf('PDF content here');

new HttpMock()
  .whenGetOn('/api/documents/123')
  .body(pdfData)
  .contentTypePdf()
  .statusCodeOk()
  .mock();
```

## Static Resource

Load response body from a Static Resource.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .staticResource('UsersResponseMock')
  .statusCodeOk()
  .mock();
```

## XML Response

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

## Empty Response

For responses with no body (like DELETE operations):

```apex
new HttpMock()
  .whenDeleteOn('/api/users/123')
  .statusCodeNoContent()
  .mock();
```

## Default Behavior

If you don't call `.body()`, the response body defaults to `{}`:

```apex
new HttpMock()
  .whenGetOn('/api/ping')
  .statusCodeOk()
  .mock();
// Response body: "{}"
```
