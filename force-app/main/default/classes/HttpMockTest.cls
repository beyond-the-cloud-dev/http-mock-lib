@IsTest
private class HttpMockTest {
    @IsTest
    static void get() {
         // Setup
         new HttpMock()
            .get('/v1/persons')
            .body(new List<Person>{
                new Person('John', 'john@beyondthecloud.dev'),
                new Person('Peter', 'peter@beyondthecloud.dev')
            })
            .contentTypeJson()
            .statusCodeOk()
            .mock();

        // Test
        Test.startTest();
        List<Person> persons = new PersonApi().getPersons();
        Test.stopTest();

        // Verify
        Assert.areEqual(2, persons.size());
    }

    @IsTest
    static void getWithDynamicEndpoint() {
         // Setup
         new HttpMock()
            .get('/v1/person/bart@beyondthecloud.dev')
            .body(new Person('Bart', 'bart@beyondthecloud.dev'))
            .contentTypeJson()
            .statusCodeOk()
            .mock();

        // Test
        Test.startTest();
        Person person = new PersonApi().getPerson('bart@beyondthecloud.dev');
        Test.stopTest();

        // Verify
        Assert.isNotNull(person);
    }

    @IsTest
    static void post() {
         // Setup
         new HttpMock()
            .post('/v1/person/')
            .body(new Person('Bart', 'bart@beyondthecloud.dev'))
            .contentTypeJson()
            .statusCodeOk()
            .mock();

        // Test
        Test.startTest();
        new PersonApi().updatePerson(new Person('Bart', 'bart@beyondthecloud.dev'));
        Test.stopTest();

        // Verify
        // Assert.isNotNull(person);
    }

    private class PersonApi {
        private final String BASE_API_URL = 'https://test.api.com';

        public List<Person> getPersons() {
            HttpRequest request = new HttpRequest();
            request.setMethod('GET');
            request.setEndpoint(BASE_API_URL + '/v1/persons');

            return (List<Person>) JSON.deserialize(new Http().send(request).getBody(), List<Person>.class);
        }

        public Person getPerson(String username) {
            HttpRequest request = new HttpRequest();
            request.setMethod('GET');
            request.setEndpoint(BASE_API_URL + '/v1/person/' + username);

            return (Person) JSON.deserialize(new Http().send(request).getBody(), Person.class);
        }

        public Boolean updatePerson(Person person) {
            HttpRequest request = new HttpRequest();
            request.setMethod('POST');
            request.setEndpoint(BASE_API_URL + '/v1/person/' + person.username);
            request.setHeader('Content-Type', 'application/json');
            request.setBody(JSON.serialize(person));

            return Boolean.valueOf(new Http().send(request).getBody());
        }
    }

    private class Person {
        public String name;
        public String username;
        public Integer age = 33;

        public Person(String name, String username) {
            this.name = name;
            this.username = username;
        }
    }
}
