# Custom Headers

Add and test custom HTTP headers in your mocked responses.

## Basic Header Usage

Add a single custom header:

```apex
@IsTest
static void testSingleHeader() {
  new HttpMock()
    .whenGetOn('/api/users')
    .body('{"users": []}')
    .header('X-Total-Count', '100')
    .statusCodeOk()
    .mock();

  Test.startTest();
  ApiResponse response = new UserService().getUsers();
  Test.stopTest();

  Assert.areEqual(100, response.totalCount);
}
```

## Multiple Headers

Chain multiple `.header()` calls:

```apex
@IsTest
static void testMultipleHeaders() {
  new HttpMock()
    .whenGetOn('/api/data')
    .body('{"data": []}')
    .header('X-Request-ID', 'abc-123')
    .header('X-API-Version', 'v2')
    .header('Cache-Control', 'no-cache')
    .header('X-RateLimit-Remaining', '99')
    .statusCodeOk()
    .mock();

  Test.startTest();
  ApiResponse response = new ApiService().getData();
  Test.stopTest();

  Assert.areEqual('abc-123', response.requestId);
  Assert.areEqual('v2', response.apiVersion);
}
```

## Pagination Headers

Use headers to communicate pagination metadata:

```apex
@IsTest
static void testPaginationHeaders() {
  new HttpMock()
    .whenGetOn('/api/users?page=2')
    .body('{"users": [...]}')
    .header('X-Total-Count', '1000')
    .header('X-Page-Number', '2')
    .header('X-Page-Size', '50')
    .header('X-Total-Pages', '20')
    .header('Link', '</api/users?page=3>; rel="next", </api/users?page=1>; rel="prev"')
    .statusCodeOk()
    .mock();

  Test.startTest();
  PaginatedResponse response = new UserService().getUsers(2);
  Test.stopTest();

  Assert.areEqual(1000, response.totalCount);
  Assert.areEqual(2, response.currentPage);
  Assert.areEqual(20, response.totalPages);
}
```

## Cache Headers

Test cache-related headers:

```apex
@IsTest
static void testCacheHeaders() {
  new HttpMock()
    .whenGetOn('/api/static-data')
    .body('{"data": "cached content"}')
    .header('Cache-Control', 'public, max-age=3600')
    .header('ETag', '"abc123"')
    .header('Last-Modified', 'Wed, 21 Oct 2023 07:28:00 GMT')
    .header('Expires', 'Wed, 21 Oct 2023 08:28:00 GMT')
    .statusCodeOk()
    .mock();

  Test.startTest();
  CachedResponse response = new ApiService().getCachedData();
  Test.stopTest();

  Assert.isTrue(response.isCacheable);
  Assert.areEqual(3600, response.maxAge);
}
```

## Rate Limiting Headers

Mock rate limit information:

```apex
@IsTest
static void testRateLimitHeaders() {
  new HttpMock()
    .whenGetOn('/api/limited')
    .body('{"data": {}}')
    .header('X-RateLimit-Limit', '100')
    .header('X-RateLimit-Remaining', '95')
    .header('X-RateLimit-Reset', '1640000000')
    .statusCodeOk()
    .mock();

  Test.startTest();
  ApiResponse response = new ApiService().callLimitedEndpoint();
  Test.stopTest();

  Assert.areEqual(100, response.rateLimit);
  Assert.areEqual(95, response.rateLimitRemaining);
  Assert.isFalse(response.rateLimitExceeded);
}
```

## File Download Headers

Test file download with Content-Disposition:

```apex
@IsTest
static void testFileDownload() {
  Blob pdfContent = Blob.valueOf('PDF content here');

  new HttpMock()
    .whenGetOn('/api/reports/monthly.pdf')
    .body(pdfContent)
    .contentTypePdf()
    .header('Content-Disposition', 'attachment; filename="monthly-report.pdf"')
    .header('Content-Length', String.valueOf(pdfContent.size()))
    .statusCodeOk()
    .mock();

  Test.startTest();
  FileDownload download = new ReportService().downloadMonthlyReport();
  Test.stopTest();

  Assert.areEqual('monthly-report.pdf', download.filename);
  Assert.isNotNull(download.content);
}
```

## CORS Headers

Mock CORS headers for cross-origin requests:

```apex
@IsTest
static void testCorsHeaders() {
  new HttpMock()
    .whenGetOn('/api/public/data')
    .body('{"data": []}')
    .header('Access-Control-Allow-Origin', '*')
    .header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE')
    .header('Access-Control-Allow-Headers', 'Content-Type, Authorization')
    .header('Access-Control-Max-Age', '3600')
    .statusCodeOk()
    .mock();

  Test.startTest();
  ApiResponse response = new ApiService().getPublicData();
  Test.stopTest();

  Assert.isNotNull(response);
}
```

## Authentication Headers

Test authentication token headers:

```apex
@IsTest
static void testAuthHeaders() {
  new HttpMock()
    .whenPostOn('/api/login')
    .body('{"userId": "123"}')
    .header('X-Auth-Token', 'xyz789')
    .header('Set-Cookie', 'session=abc123; HttpOnly; Secure; SameSite=Strict')
    .statusCodeOk()
    .mock();

  Test.startTest();
  AuthResponse response = new AuthService().login('user', 'pass');
  Test.stopTest();

  Assert.areEqual('xyz789', response.authToken);
  Assert.isNotNull(response.sessionCookie);
}
```

## Custom Business Headers

Use headers for custom business logic:

```apex
@IsTest
static void testBusinessHeaders() {
  new HttpMock()
    .whenGetOn('/api/orders')
    .body('{"orders": []}')
    .header('X-Tenant-ID', 'tenant-123')
    .header('X-Feature-Flags', 'feature1,feature2')
    .header('X-Correlation-ID', 'corr-456')
    .header('X-Server-Time', '2023-10-21T12:00:00Z')
    .statusCodeOk()
    .mock();

  Test.startTest();
  ApiResponse response = new OrderService().getOrders();
  Test.stopTest();

  Assert.areEqual('tenant-123', response.tenantId);
  Assert.isTrue(response.hasFeature('feature1'));
}
```

## Override Content-Type

You can override the default Content-Type using `.header()`:

```apex
@IsTest
static void testCustomContentType() {
  new HttpMock()
    .whenGetOn('/api/custom')
    .body('{"data": {}}')
    .header('Content-Type', 'application/vnd.api+json; charset=utf-8')
    .statusCodeOk()
    .mock();

  Test.startTest();
  ApiResponse response = new ApiService().getCustomFormat();
  Test.stopTest();

  Assert.isNotNull(response);
}
```

## Debugging Headers

Add debugging information via headers:

```apex
@IsTest
static void testDebugHeaders() {
  new HttpMock()
    .whenGetOn('/api/debug')
    .body('{"data": {}}')
    .header('X-Request-ID', 'req-123-456')
    .header('X-Server-ID', 'server-42')
    .header('X-Request-Duration', '127ms')
    .header('X-Cache-Status', 'MISS')
    .statusCodeOk()
    .mock();

  Test.startTest();
  ApiResponse response = new ApiService().callWithDebug();
  Test.stopTest();

  Assert.areEqual('req-123-456', response.requestId);
  Assert.areEqual(127, response.durationMs);
}
```

## Location Header

Test redirect and created resource headers:

```apex
@IsTest
static void testLocationHeader() {
  new HttpMock()
    .whenPostOn('/api/users')
    .body('{"id": "123"}')
    .header('Location', '/api/users/123')
    .statusCodeCreated()
    .mock();

  Test.startTest();
  CreateResponse response = new UserService().createUser('John Doe');
  Test.stopTest();

  Assert.areEqual('123', response.id);
  Assert.areEqual('/api/users/123', response.location);
}
```

## Deprecation Headers

Communicate API deprecation:

```apex
@IsTest
static void testDeprecationHeaders() {
  new HttpMock()
    .whenGetOn('/api/v1/old-endpoint')
    .body('{"data": {}}')
    .header('Deprecation', 'true')
    .header('Sunset', 'Sat, 31 Dec 2024 23:59:59 GMT')
    .header('Link', '</api/v2/new-endpoint>; rel="alternate"')
    .statusCodeOk()
    .mock();

  Test.startTest();
  ApiResponse response = new ApiService().callOldEndpoint();
  Test.stopTest();

  Assert.isTrue(response.isDeprecated);
  Assert.isNotNull(response.sunsetDate);
}
```

## Best Practices

1. **Use Standard Headers** - Prefer standard HTTP headers when possible

2. **Namespace Custom Headers** - Use `X-` prefix for custom headers (though this is deprecated in RFC 6648, it's still common)

3. **Test Header Parsing** - Verify your code correctly reads and uses headers

4. **Match Real APIs** - Include the same headers the actual API returns

5. **Document Header Purpose** - Comment what each custom header represents

## See Also

- [Headers API](/api/headers)
- [Basic Examples](/examples/basic)
- [Content Types](/api/content-types)
