# Getting Started

HTTP Mock Lib mocks HTTP callouts in Apex tests with one class and a fluent API: say what each endpoint returns, run your code, assert on what it sent.

## Installation

See the [Installation Guide](/installation).

## Your First Mock

The code under test — a service that registers a shipment with a courier API and returns the tracking number:

```apex
public with sharing class ShipmentService {
  public String registerShipment(String orderNumber) {
    HttpRequest request = new HttpRequest();
    request.setEndpoint('callout:Courier_API/api/v2/shipments');
    request.setMethod('POST');
    request.setHeader('Content-Type', 'application/json');
    request.setBody(JSON.serialize(new Map<String, String>{ 'orderNumber' => orderNumber }));

    HttpResponse response = new Http().send(request);
    Map<String, Object> payload = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

    return (String) payload.get('trackingNumber');
  }
}
```

The test mocks the endpoint, runs the service, and asserts on the result:

```apex
@IsTest
private class ShipmentServiceTest {
  @IsTest
  static void registerShipmentReturnsTrackingNumber() {
    new HttpMock()
      .whenPostOn('/api/v2/shipments')
      .body('{ "trackingNumber": "1Z999AA10123456784" }')
      .statusCodeCreated()
      .mock();

    Test.startTest();
    String trackingNumber = new ShipmentService().registerShipment('ORD-1042');
    Test.stopTest();

    Assert.areEqual('1Z999AA10123456784', trackingNumber, 'Tracking number should come from the courier response');
  }
}
```

The mocked path matches any request endpoint that contains it — so `/api/v2/shipments` also matches `callout:Courier_API/api/v2/shipments` and full URLs with query parameters. See [Endpoint Matching](/api/http-methods#endpoint-matching).

## Defaults

Every mocked endpoint starts with status `200`, content type `application/json`, and body `{}`. Set only what your test cares about:

```apex
new HttpMock()
  .whenGetOn('/api/v2/shipments/1Z999AA10123456784')
  .mock(); // responds 200 with {}
```

## Common Patterns

### More Than One Endpoint

Each `when[Method]On` starts a new stub — mock the whole integration in one chain:

```apex
new HttpMock()
  .whenPostOn('/oauth/token')
    .body('{ "access_token": "a1b2c3" }')
  .whenPostOn('/api/v2/shipments')
    .body('{ "trackingNumber": "1Z999AA10123456784" }')
    .statusCodeCreated()
  .mock();
```

### Object Bodies

Anything that isn't a `String` or `Blob` is JSON-serialized:

```apex
.body(new Map<String, String>{ 'trackingNumber' => '1Z999AA10123456784' })
```

### Error Responses

Mock the failure your integration has error handling for, and assert on that handling:

```apex
new HttpMock()
  .whenPostOn('/api/v2/shipments')
  .body('{ "error": "address_not_routable" }')
  .statusCodeBadRequest()
  .mock();

Test.startTest();
ShipmentResult result = new ShipmentService().registerShipmentSafe('ORD-1042');
Test.stopTest();

Assert.isFalse(result.success, 'An unroutable address should not register a shipment');
Assert.areEqual('address_not_routable', result.errorCode, 'Error code should come from the courier');
```

### Retries

Stub the same endpoint several times and the responses are consumed in order — the last one repeats. An exception can take a turn in that queue:

```apex
new HttpMock()
  .whenGetOn('/api/v2/shipments').throwsException(new CalloutException('Read timed out'))
  .whenGetOn('/api/v2/shipments').statusCodeOk()
  .mock();
// first callout throws, the retry succeeds
```

See [Exceptions](/api/exceptions).

### Asserting On What Was Sent

The mock records every request. Read them back to verify the payload your code built:

```apex
Assert.areEqual(1, HttpMock.requestsTo('/api/v2/shipments').post(), 'One shipment should be registered');
Assert.areEqual('{"orderNumber":"ORD-1042"}', HttpMock.requestsTo('/api/v2/shipments').last().getBody(), 'Payload should carry the order number');
```

See [Requests](/api/requests).
