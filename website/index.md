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
    details: Write clean, readable test mocks with a chainable, intuitive interface that makes your tests easy to understand.

  - icon: 🚀
    title: Production Ready
    details: Battle-tested in production environments. Part of Apex Fluently suite of enterprise-grade Salesforce libraries.

  - icon: 📝
    title: Type Safe
    details: Strongly typed methods prevent runtime errors and provide excellent IDE autocomplete support.

  - icon: 🔧
    title: Flexible
    details: Mock multiple endpoints, HTTP methods, status codes, headers, and content types all in one test.

  - icon: ⚡
    title: Lightweight
    details: Zero dependencies, minimal footprint. Just one class to mock all your HTTP callouts.

  - icon: 🎓
    title: Easy to Learn
    details: Straightforward API inspired by modern testing frameworks. Get started in minutes.
---

## Why HTTP Mock Lib?

Traditional Salesforce HTTP mocking requires creating verbose mock classes for every test scenario. HTTP Mock Lib simplifies this with a fluent, chainable API:

::: code-group

```apex [Before ❌]
@isTest
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

## Quick Example

```apex
@IsTest
private class CalloutServiceTest {
  @IsTest
  static void testMultipleEndpoints() {
    // Arrange
    new HttpMock()
      .whenGetOn('/api/v1/authorize')
        .body('{ "token": "aZ3Xb7Qk" }')
        .statusCodeOk()
      .whenPostOn('/api/v1/create')
        .body('{ "success": true, "message": null }')
        .statusCodeCreated()
      .mock();

    // Act
    Test.startTest();
    CalloutResult result = new CalloutService().makeCallout();
    Test.stopTest();

    // Assert
    Assert.isTrue(result.success);
  }
}
```

## Features at a Glance

- ✅ **Mock Multiple Endpoints** - Handle GET, POST, PUT, PATCH, DELETE, HEAD, TRACE in one test
- ✅ **Flexible Response Bodies** - Return String, Object, or Blob responses
- ✅ **Built-in Status Codes** - Use semantic methods like `statusCodeOk()`, `statusCodeNotFound()`
- ✅ **Content Type Support** - JSON, XML, CSV, PDF, and custom content types
- ✅ **Custom Headers** - Add any headers your callout needs
- ✅ **Zero Configuration** - Works out of the box, no setup required

## Part of Apex Fluently

HTTP Mock Lib is part of [Apex Fluently](https://apexfluently.beyondthecloud.dev/), a suite of production-ready Salesforce libraries by [Beyond the Cloud](https://beyondthecloud.dev).

## Get Started

Ready to simplify your HTTP mocking? [Get started →](/getting-started)
