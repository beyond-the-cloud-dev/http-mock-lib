# v1.2.0 - 26-December-2025

**Scope**

- New Features: Static Resource Support, Enhanced Request Assertions API
- Improvements: Global Access Modifier, Parallel Test Execution, Unlocked Package Support

`HttpMock`

- Added `staticResource()` method for loading response body from Static Resources
- Added `requestsTo()` method with fluent assertion API for request counting
- Changed class access from `public` to `global` for managed package support
- Added unlocked package distribution with `btcdev` namespace

## New Features

### Static Resource Support

New `staticResource()` method allows loading response body directly from a Salesforce Static Resource. This is ideal for large or complex response payloads that are difficult to maintain inline.

**Example: Mock Using Static Resource**

```apex
new HttpMock()
    .whenGetOn('/api/v1/users')
    .staticResource('UsersResponseMock')
    .statusCodeOk()
    .mock();
```

If the Static Resource doesn't exist, a `StaticResourceNotFoundException` is thrown with a clear error message.

### Enhanced Request Assertions API

New `requestsTo()` method provides a fluent API for asserting the number of HTTP requests made during a test. This replaces the previous `getRequestCount()` method with a more intuitive interface.

**Example: Assert Request Counts**

```apex
new HttpMock()
    .whenGetOn('/api/v1/authorize')
    .statusCodeOk()
    .whenPostOn('/api/v1/create')
    .statusCodeOk()
    .mock();

Test.startTest();
// Make callouts...
Test.stopTest();

Assert.areEqual(1, HttpMock.requestsTo('/api/v1/authorize').get(), 'One GET request should be made');
Assert.areEqual(1, HttpMock.requestsTo('/api/v1/create').post(), 'One POST request should be made');
```

**Supported Assertion Methods**

```apex
HttpMock.requestsTo('/endpoint').all();     // Total requests (all methods)
HttpMock.requestsTo('/endpoint').get();     // GET requests
HttpMock.requestsTo('/endpoint').post();    // POST requests
HttpMock.requestsTo('/endpoint').put();     // PUT requests
HttpMock.requestsTo('/endpoint').patch();   // PATCH requests
HttpMock.requestsTo('/endpoint').deletex(); // DELETE requests (x suffix due to reserved keyword)
HttpMock.requestsTo('/endpoint').trace();   // TRACE requests
HttpMock.requestsTo('/endpoint').head();    // HEAD requests
```

## Improvements

### Global Access Modifier

The `HttpMock` class is now declared as `global` instead of `public`, enabling usage in managed and unlocked packages.

### Parallel Test Execution

Test class now includes `@IsTest(IsParallel=true)` for faster test execution.

### Unlocked Package Support

HTTP Mock Lib is now available as an unlocked package with the `btcdev` namespace. See the [Installation Guide](/installation) for package installation instructions.

### API Version Update

Updated Salesforce API version from 57.0 to 65.0.

## Internal Refactoring

- Renamed interface from `HttpMockLib` to `HttpStubbing`
- All fluent methods now return `HttpStubbing` interface type
- Introduced `HttpMockRequests` inner class for improved request counting
- Refactored request tracking from method-based to endpoint-based storage
- Added PMD suppressions for `FieldDeclarationsShouldBeAtStart`, `CognitiveComplexity`, `CyclomaticComplexity`

## 🚨 Breaking Changes 🚨

### Request Count API Change

The `getRequestCount()` static method has been replaced with the new `requestsTo()` API.

**Before (v1.1.x):**

```apex
Assert.areEqual(2, HttpMock.getRequestCount('GET', '/api/v1'));
```

**After (v1.2.0):**

```apex
Assert.areEqual(2, HttpMock.requestsTo('/api/v1').get());
```

### Interface Rename

The public interface has been renamed from `HttpMockLib` to `HttpStubbing`. This only affects code that explicitly references the interface type (uncommon).

