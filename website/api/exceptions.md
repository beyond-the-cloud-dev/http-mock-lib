# Exceptions

Make a callout fail instead of returning a response.

A mocked endpoint normally answers. `.throwsException()` makes it die on the wire — the way a real callout does when the connection drops, the read times out, or the remote site is unreachable. Use it to cover the error paths your client code has for those cases.

```apex
new HttpMock()
  .whenPostOn('/api/users')
  .throwsException(new CalloutException('Read timed out'))
  .mock();
```

The callout throws that exact exception:

```apex
try {
  new UserApi().createUser();
  Assert.fail('Callout should have failed');
} catch (CalloutException e) {
  Assert.areEqual('Read timed out', e.getMessage(), 'Message should be Read timed out');
}
```

## The Default

No argument means a plain `CalloutException` — for tests that only care that the callout failed, not how the failure was worded.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .throwsException()
  .mock();
```

## Any Exception Type

You supply the exception, so any type works — `CalloutException`, a custom one, or a standard Apex exception.

```apex
new HttpMock()
  .whenGetOn('/api/users')
  .throwsException(new MyIntegrationException('Circuit breaker open'))
  .mock();
```

## Failing After a Successful Response

Queued responses are consumed in order, and an exception takes its place in that queue. This is how you test a retry that gives up on the second attempt — or one that succeeds on the third.

```apex
new HttpMock()
  .whenGetOn('/api/users').statusCodeOk()
  .whenGetOn('/api/users').throwsException(new CalloutException('Connection reset'))
  .whenGetOn('/api/users').statusCodeOk()
  .mock();
```

## Request Counting

A callout that throws still counts as a request. It was sent — that it failed does not make it unsent.

```apex
new HttpMock()
  .whenPostOn('/api/users')
  .throwsException(new CalloutException('Read timed out'))
  .mock();

// ... the callout runs and throws ...

Assert.areEqual(1, HttpMock.requestsTo('/api/users').post(), 'Request count should be 1');
```

## Reference

| Method | Purpose |
|--------|---------|
| `throwsException()` | Throw a default `CalloutException` instead of returning a response |
| `throwsException(Exception error)` | Throw `error` instead of returning a response |
