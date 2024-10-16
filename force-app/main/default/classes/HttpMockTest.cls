@IsTest
private class HttpMockTest {
    private static final Id ACCOUNT_ID = new TestIdGenerator().generate(Account.SObjectType);

    @IsTest
    static void get() {
         // Setup
         new HttpMock()
            .get('/services/data/v61.0/sobjects/Account/' + ACCOUNT_ID)
            .body(new Account(Id = ACCOUNT_ID, Name = 'Test Account'))
            .mock();

        // Test
        Test.startTest();
        Account account = new AccountApi().getAccount(ACCOUNT_ID);
        Test.stopTest();

        // Verify
        Assert.isNotNull(account);
        Assert.areEqual(ACCOUNT_ID, account.Id);
    }

    @IsTest
    static void post() {
         // Setup
         new HttpMock()
            .post('/services/data/v61.0/sobjects/Account/')
            .body(new Map<String, Object>{
                'id' => ACCOUNT_ID,
                'errors' => new List<String>(),
                'success' => true
            })
            .mock();

        // Test
        Test.startTest();
        Map<String, Object> response = new AccountApi().postAccount(new Account(Name = 'Test Account'));
        Test.stopTest();

        // Verify
        Assert.isTrue((Boolean) response.get('success'));
        Assert.areEqual((String) response.get('id'), ACCOUNT_ID);
    }

    @IsTest
    static void put() {
         // Setup
         new HttpMock()
            .put('/services/data/v61.0/sobjects/Account/' + ACCOUNT_ID)
            .mock();

        // Test
        Test.startTest();
        Boolean isSuccess = new AccountApi().putAccount(ACCOUNT_ID, new Map<String, Object>{ 'Name' => 'New Account Name' });
        Test.stopTest();

        // Verify
        Assert.isTrue(isSuccess);
    }

    @IsTest
    static void patch() {
         // Setup
         new HttpMock()
            .patch('/services/data/v61.0/sobjects/Account/' + ACCOUNT_ID)
            .mock();

        // Test
        Test.startTest();
        Boolean isSuccess = new AccountApi().patchAccount(ACCOUNT_ID, new Map<String, Object>{ 'Name' => 'New Account Name' });
        Test.stopTest();

        // Verify
        Assert.isTrue(isSuccess);
    }

    @IsTest
    static void head() {
         // Setup
         new HttpMock()
            .head('/services/data/v61.0/sobjects/Account/' + ACCOUNT_ID)
            .mock();

        // Test
        Test.startTest();
        Boolean isSuccess = new AccountApi().headAccount(ACCOUNT_ID);
        Test.stopTest();

        // Verify
        Assert.isTrue(isSuccess);
    }

    @IsTest
    static void stringBody() {
         // Setup
         new HttpMock()
            .get('/services/data/v61.0/sobjects/Account/' + ACCOUNT_ID)
            .body('{ "Id": "' + ACCOUNT_ID + '", "Name": "Test Account" }')
            .mock();

        // Test
        Test.startTest();
        Account account = new AccountApi().getAccount(ACCOUNT_ID);
        Test.stopTest();

        // Verify
        Assert.isNotNull(account);
        Assert.areEqual(ACCOUNT_ID, account.Id);
    }

    @IsTest
    static void blobBody() {
        // TBD
    }

    @IsTest
    static void contentTypePlainText() {
        // TBD
    }

    @IsTest
    static void contentTypeCsv() {
        // TBD
    }

    @IsTest
    static void contentTypeJson() {
        // TBD
    }

    @IsTest
    static void contentTypeXml() {
        // TBD
    }

    @IsTest
    static void contentTypeFormUrlencoded() {
        // TBD
    }

    @IsTest
    static void contentType() {
        // TBD
    }

    @IsTest
    static void statusCodeOk() {
         // Setup
         new HttpMock()
            .deletex('/services/data/v61.0/sobjects/Account/')
            .statusCodeOk()
            .mock();

        // Test
        Test.startTest();
        Boolean isSuccess = new AccountApi().deleteAccount(ACCOUNT_ID);
        Test.stopTest();

        // Verify
        Assert.isTrue(isSuccess);
    }

    @IsTest
    static void statusCodeBadRequest() {
         // Setup
         new HttpMock()
            .deletex('/services/data/v61.0/sobjects/Account/')
            .statusCodeBadRequest()
            .mock();

        // Test
        Test.startTest();
        Boolean isSuccess = new AccountApi().deleteAccount(ACCOUNT_ID);
        Test.stopTest();

        // Verify
        Assert.isFalse(isSuccess);
    }

    @IsTest
    static void statusCodeUnauthorized() {
         // Setup
         new HttpMock()
            .deletex('/services/data/v61.0/sobjects/Account/')
            .statusCodeUnauthorized()
            .mock();

        // Test
        Test.startTest();
        Boolean isSuccess = new AccountApi().deleteAccount(ACCOUNT_ID);
        Test.stopTest();

        // Verify
        Assert.isFalse(isSuccess);
    }

    @IsTest
    static void statusCodeNotFound() {
         // Setup
         new HttpMock()
            .deletex('/services/data/v61.0/sobjects/Account/')
            .statusCodeNotFound()
            .mock();

        // Test
        Test.startTest();
        Boolean isSuccess = new AccountApi().deleteAccount(ACCOUNT_ID);
        Test.stopTest();

        // Verify
        Assert.isFalse(isSuccess);
    }

    @IsTest
    static void statusCodeInternalServerError() {
         // Setup
         new HttpMock()
            .deletex('/services/data/v61.0/sobjects/Account/')
            .statusCodeInternalServerError()
            .mock();

        // Test
        Test.startTest();
        Boolean isSuccess = new AccountApi().deleteAccount(ACCOUNT_ID);
        Test.stopTest();

        // Verify
        Assert.isFalse(isSuccess);
    }

    private class AccountApi {
        private final String BASE_API_URL = URL.getCurrentRequestUrl().toExternalForm();

        public Account getAccount(Id accountId) {
            HttpRequest request = new HttpRequest();

            request.setMethod('GET');
            request.setEndpoint(BASE_API_URL + '/services/data/v61.0/sobjects/Account/' + accountId);

            HttpResponse response = new Http().send(request);

            return (Account) JSON.deserialize(response.getBody(), Account.class);
        }

        public Boolean headAccount(Id accountId) {
            HttpRequest request = new HttpRequest();

            request.setMethod('HEAD');
            request.setEndpoint(BASE_API_URL + '/services/data/v61.0/sobjects/Account/' + accountId);

            HttpResponse response = new Http().send(request);

            return response.getStatusCode() == 200;
        }

        public Map<String, Object> postAccount(Account newAccount) {
            HttpRequest request = new HttpRequest();

            request.setMethod('POST');
            request.setEndpoint(BASE_API_URL + '/services/data/v61.0/sobjects/Account/');
            request.setHeader('Content-Type', 'application/json');
            request.setBody(JSON.serialize(newAccount));

            HttpResponse response = new Http().send(request);

            return (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        }

        public Boolean patchAccount(Id accountId, Map<String, Object> fields) {
            HttpRequest request = new HttpRequest();

            request.setMethod('PATCH');
            request.setEndpoint(BASE_API_URL + '/services/data/v61.0/sobjects/Account/' + accountId);
            request.setHeader('Content-Type', 'application/json');
            request.setBody(JSON.serialize(fields));

            HttpResponse response = new Http().send(request);

            return response.getStatusCode() == 200;
        }

        public Boolean putAccount(Id accountId, Map<String, Object> fields) {
            HttpRequest request = new HttpRequest();

            request.setMethod('PUT');
            request.setEndpoint(BASE_API_URL + '/services/data/v61.0/sobjects/Account/' + accountId);
            request.setHeader('Content-Type', 'application/json');
            request.setBody(JSON.serialize(fields));

            HttpResponse response = new Http().send(request);

            return response.getStatusCode() == 200;
        }

        public Boolean deleteAccount(Id accountId) {
            HttpRequest request = new HttpRequest();

            request.setMethod('DELETE');
            request.setEndpoint(BASE_API_URL + '/services/data/v61.0/sobjects/Account/' + accountId);
            request.setHeader('Content-Type', 'application/json');

            HttpResponse response = new Http().send(request);

            return response.getStatusCode() == 200;
        }
    }

    public class TestIdGenerator {
        private final String RANDOM_STRING_CHARACTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';

        public Id generate(Schema.SObjectType sobjectType) {
            String keyPrefix = sobjectType.getDescribe().getKeyPrefix();
            return Id.valueOf(keyPrefix + '0000' + generateRandomString(8));
        }

        private String generateRandomString(Integer length) {
            String randomString = '';
            while (randomString.length() < length) {
                Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), RANDOM_STRING_CHARACTERS.length());
                randomString += RANDOM_STRING_CHARACTERS.substring(idx, idx + 1);
            }
            return randomString;
        }
    }
}
