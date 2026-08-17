---
layout: home

hero:
  name: "HTTP Mock Lib"
  text: "Fluent HTTP Mocking for Apex"
  tagline: A production-ready library for mocking HTTP callouts in Salesforce with a clean, fluent API
  actions:
    - theme: brand
      text: Get Started
      link: /getting-started
    - theme: alt
      text: API Reference
      link: /api/
    - theme: alt
      text: View on GitHub
      link: https://github.com/beyond-the-cloud-dev/http-mock-lib

features:
  - icon: 🎯
    title: Fluent API
    details: Write clean, readable test mocks with a chainable, intuitive interface.

  - icon: 🌐
    title: All HTTP Methods
    details: Mock GET, POST, PUT, PATCH, DELETE, HEAD, TRACE in one test.

  - icon: 📦
    title: Flexible Responses
    details: Return String, Object, or Blob bodies — inline or from a Static Resource — with any content type.

  - icon: 💥
    title: Failure Simulation
    details: Queue responses per endpoint, mock error status codes, and throw exceptions mid-sequence to test retries.

  - icon: 🔍
    title: Request Assertions
    details: Count the callouts made and assert on the captured requests your code actually sent.

  - icon: ⚡
    title: Zero Dependencies
    details: Lightweight, minimal footprint. Just one class to mock all your HTTP callouts.
---

## Why HTTP Mock Lib?

Traditional Salesforce HTTP mocking requires creating verbose mock classes for every test scenario. HTTP Mock Lib simplifies this with a fluent, chainable API:

::: code-group

```apex [Before ❌]
@IsTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
    }
}

Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
```

```apex [After ✅]
new HttpMock()
  .whenGetOn('/api/v1/authorize')
  .body('{"example":"test"}')
  .statusCodeOk()
  .mock();
```

:::

## Part of Apex Fluently

HTTP Mock Lib is part of [Apex Fluently](https://apexfluently.beyondthecloud.dev/), a suite of production-ready Salesforce libraries by [Beyond the Cloud](https://beyondthecloud.dev).

## Get Started

Ready to simplify your HTTP mocking? [Get started →](/getting-started)

<BTCFooter context="http-mock" />
