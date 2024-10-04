@IsTest
private class HttpMockTest {
    @IsTest
    static void singleGetMock() {
        // Setup
        new HttpMock().get('/v2/persons').mock();

        // Test
        Test.startTest();

        Test.stopTest();

        // Verify
    }

    @IsTest
    static void singleGetMockWithBody() {
        // Test
    }

    @IsTest
    static void singleGetMockWithBodyAndContentType() {
        // Test
    }

    @IsTest
    static void singleGetMockWithBodyAndContentTypeAndStatusCode() {
        // Test
    }
}
