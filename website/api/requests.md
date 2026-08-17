# Requests

Inspect what your code actually sent.

`HttpMock.requestsTo()` counts the callouts made to an endpoint, and hands you the `HttpRequest` objects themselves — so you can assert on the body, the headers, or the method your code built.

## Counting

```apex
Assert.areEqual(3, HttpMock.requestsTo('/api/users').all(), 'Three requests should be made');
Assert.areEqual(1, HttpMock.requestsTo('/api/users').get(), 'One GET request should be made');
Assert.areEqual(2, HttpMock.requestsTo('/api/users').post(), 'Two POST requests should be made');
```

## The Last Request

The common case: one callout, and you want to know what went out.

```apex
new HttpMock()
  .whenPostOn('/api/users')
  .statusCodeCreated()
  .mock();

Test.startTest();
new UserApi().createUser('Jane');
Test.stopTest();

HttpRequest sent = HttpMock.requestsTo('/api/users').last();

Assert.areEqual('{"name":"Jane"}', sent.getBody(), 'Body should carry the name');
Assert.areEqual('POST', sent.getMethod(), 'Method should be POST');
Assert.areEqual('application/json', sent.getHeader('Content-Type'), 'Content-Type should be application/json');
```

`last()` returns `null` when no request was made to the endpoint.

## Every Request

`captured()` returns the requests in the order they were made — useful when your code batches, paginates, or retries.

```apex
new HttpMock()
  .whenPostOn('/api/contacts').statusCodeOk()
  .whenPostOn('/api/contacts').statusCodeOk()
  .mock();

Test.startTest();
new ContactApi().upload(contacts);
Test.stopTest();

List<HttpRequest> sent = HttpMock.requestsTo('/api/contacts').captured();

Assert.areEqual(2, sent.size(), 'The upload should be split into two batches');
Assert.areEqual(300, batchSizeOf(sent[0]), 'First batch should be full');
Assert.areEqual(50, batchSizeOf(sent[1]), 'Second batch should carry the remainder');
```

This is what catches a payload that is built wrong: the callout still returns 200, the code under test still reports success, and only the sent body says the shape was off.

## Filtering by Method

When several verbs hit the same endpoint, every lookup has a per-method variant: `capturedGets()` … `capturedHeads()` for the full list, `lastGet()` … `lastHead()` for the most recent one.

```apex
new HttpMock()
  .whenGetOn('/api/users').statusCodeOk()
  .whenPostOn('/api/users').statusCodeCreated()
  .mock();

Test.startTest();
new UserApi().syncUsers(); // fetches with GET, then pushes two batches with POST
Test.stopTest();

List<HttpRequest> pushes = HttpMock.requestsTo('/api/users').capturedPosts();

Assert.areEqual(2, pushes.size(), 'The push should be split into two batches');
Assert.areEqual('{"name":"Jane"}', HttpMock.requestsTo('/api/users').lastPost().getBody(), 'Last POST should carry the final payload');
```

Like their unfiltered counterparts, the `captured*()` variants return an empty list and the `last*()` variants return `null` when no request with that method was made.

## Failed Callouts

A callout that throws is still recorded — it was sent. See [Exceptions](./exceptions).

## Reference

| Method | Returns |
|--------|---------|
| `all()` | Number of requests, all methods |
| `get()` `post()` `put()` `patch()` `deletex()` `trace()` `head()` | Number of requests for that method |
| `captured()` | `List<HttpRequest>`, in the order sent |
| `capturedGets()` `capturedPosts()` `capturedPuts()` `capturedPatches()` `capturedDeletes()` `capturedTraces()` `capturedHeads()` | `List<HttpRequest>` for that method, in the order sent |
| `last()` | The most recent `HttpRequest`, or `null` |
| `lastGet()` `lastPost()` `lastPut()` `lastPatch()` `lastDelete()` `lastTrace()` `lastHead()` | The most recent `HttpRequest` for that method, or `null` |
