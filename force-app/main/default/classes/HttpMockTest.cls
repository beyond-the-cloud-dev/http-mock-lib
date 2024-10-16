@IsTest
private class HttpMockTest {
    @IsTest
    static void get() {
         // Setup
         Id accountId = new TestIdGenerator().generate(Account.SObjectType);

         new HttpMock()
            .get('/services/data/v61.0/sobjects/Account/' + accountId)
            .body(new Account(Id = accountId, Name = 'Test Account'))
            .mock();

        // Test
        Test.startTest();
        Account account = new AccountApi().getAccount(accountId);
        Test.stopTest();

        // Verify
        Assert.isNotNull(account);
        Assert.areEqual(accountId, account.Id);
    }

    @IsTest
    static void post() {
         // Setup
         Id accountId = new TestIdGenerator().generate(Account.SObjectType);

         new HttpMock()
            .post('/services/data/v61.0/sobjects/Account/')
            .body(new Map<String, Object>{
                'id' => accountId,
                'errors' => new List<String>(),
                'success' => true
            })
            .mock();

        // Test
        Test.startTest();
        Map<String, Object> response = new AccountApi().createAccount(new Account(Name = 'Test Account'));
        Test.stopTest();

        // Verify
        Assert.isTrue((Boolean) response.get('success'));
        Assert.areEqual((String) response.get('id'), accountId);
    }

    @IsTest
    static void patch() {
         // Setup
         Id accountId = new TestIdGenerator().generate(Account.SObjectType);

         new HttpMock()
            .patch('/services/data/v61.0/sobjects/Account/')
            .mock();

        // Test
        Test.startTest();
        Boolean isSuccess = new AccountApi().updateAccount(accountId, new Map<String, Object>{ 'Name' => 'New Account Name' });
        Test.stopTest();

        // Verify
        Assert.isTrue(isSuccess);
    }

    @IsTest
    static void deletex() {
         // Setup
         Id accountId = new TestIdGenerator().generate(Account.SObjectType);

         new HttpMock()
            .deletex('/services/data/v61.0/sobjects/Account/')
            .mock();

        // Test
        Test.startTest();
        Boolean isSuccess = new AccountApi().deleteAccount(accountId);
        Test.stopTest();

        // Verify
        Assert.isTrue(isSuccess);
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

        public Map<String, Object> createAccount(Account newAccount) {
            HttpRequest request = new HttpRequest();

            request.setMethod('POST');
            request.setEndpoint(BASE_API_URL + '/services/data/v61.0/sobjects/Account/');
            request.setHeader('Content-Type', 'application/json');
            request.setBody(JSON.serialize(newAccount));

            HttpResponse response = new Http().send(request);

            return (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        }

        public Boolean updateAccount(Id accountId, Map<String, Object> fields) {
            HttpRequest request = new HttpRequest();

            request.setMethod('PATCH');
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
