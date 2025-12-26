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
    details: Return String, Object, or Blob bodies with JSON, XML, CSV, PDF, or custom content types.

  - icon: 🔢
    title: Built-in Status Codes
    details: Use semantic methods like statusCodeOk(), statusCodeNotFound(), statusCodeCreated().

  - icon: ⚡
    title: Zero Dependencies
    details: Lightweight, minimal footprint. Just one class to mock all your HTTP callouts.

  - icon: 🎓
    title: Easy to Learn
    details: Get started in minutes with a straightforward, modern API.
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
