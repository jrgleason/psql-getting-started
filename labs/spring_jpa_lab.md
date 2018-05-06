# Spring JPA Lab

## Setup

1. Download and install Java 10
    Navigate to [Java's download site](http://www.oracle.com/technetwork/java/javase/downloads/jdk10-downloads-4416644.html) and download the newest version of the JDK. More instructions are available [here](https://www.java.com/en/download/help/download_options.xml)

    You should be able to test that it is working with `java --version` you should see something like...

        java 10 2018-03-20
        Java(TM) SE Runtime Environment 18.3 (build 10+46)
        Java HotSpot(TM) 64-Bit Server VM 18.3 (build 10+46, mixed mode)

1. Download and install Gradle using the manual steps found [here](https://gradle.org/install/)
1. Clone the spring-orm-template [here](https://github.com/jrgleason/basic-jpa-template) with `git clone https://github.com/jrgleason/basic-jpa-template`
1. Go into the basic jpa folder `cd basic-jpa-template`
1. Make sure the following environmental variables are set
    1. **DB_URL**: This is the Database URL for example mine is `cscc-workforce.cmgirhyz5log.us-east-2.rds.amazonaws.com`
    2. **DB_PORT**: This is the Database port mine is `5432`
    3. **DB_NAME**: This is the Database name mine is `coffeeshop`
    4. **DB_USER**: This is the Database user mine is `jgleason`
    5. **DB_PASSWORD**: This is the Database user password
1. Run gradle bootRun and make sure it is working. When you go the `http://localhost:8080` you should see `Hello World`
1. Press `ctrl+c` to stop the application 
1. Now let's add the new files start off with 
    1. OSX
        1. `mkdir src/main/java/org/gleason/coffeeshop`
        2. `mkdir src/main/java/org/gleason/coffeeshop/domain`
        3. `mkdir src/main/java/org/gleason/coffeeshop/repo`
        4. `mkdir src/main/java/org/gleason/coffeeshop/service`
    2. Windows
        1. `mkdir src\main\java\org\gleason\coffeeshop`
        2. `mkdir src\main\java\org\gleason\coffeeshop\domain`
        3. `mkdir src\main\java\org\gleason\coffeeshop\repo`
        4. `mkdir src\main\java\org\gleason\coffeeshop\service`
1. Create the following as `src\main\java\org\gleason\coffeeshop\domain\Person.java` (Mind the seperator)

        package org.gleason.coffeeshop.domain;
        
        import javax.persistence.Id;
        
        import javax.persistence.Entity;
        import javax.persistence.Table;
        
        @Entity
        @Table(name = "PERSON", schema = "MAIN")
        public class Person {
            @Id
            private String name;
            public String getName(){
                return name;
            }
            @Override
            public String toString(){
                return name;
            }
        }

1. Now Let's create the repo `src\main\java\org\gleason\coffeeshop\repo\PersonRepo.java`

        package org.gleason.coffeeshop.repo;
        import org.gleason.coffeeshop.domain.Person;
        import org.springframework.data.repository.CrudRepository;
        public interface PersonRepo extends CrudRepository<Person, String> { }

1. Next  the service `src\main\java\org\gleason\coffeeshop\service\CoffeeShopService.java`

        package org.gleason.coffeeshop.service;
        
        import org.gleason.coffeeshop.domain.Person;
        import org.gleason.coffeeshop.repo.PersonRepo;
        import org.springframework.beans.factory.annotation.Autowired;
        import org.springframework.stereotype.Component;
        
        @Component
        public class CoffeeShopService {
            @Autowired
            PersonRepo repo;
            public Iterable<Person> getPeople(){
                return repo.findAll();
            }
        }

1. Finally let's add the following function to `src\main\java\org\gleason\coffeeshop\Endpoint.java`

        package org.gleason;
        import org.gleason.coffeeshop.domain.Person;
        import org.gleason.coffeeshop.service.CoffeeShopService;
        import org.springframework.web.bind.annotation.*;
        import org.springframework.beans.factory.annotation.Autowired;

        @RestController
        public class Endpoint{
            @Autowired
            CoffeeShopService service;
        
            @GetMapping("")
            String get(){
                return "hello world";
            }
        
            // Add this!
            @GetMapping("people")
            String people(){
                String result = "";
                for(Person person : service.getPeople())
                {
                    result += person.getName();
                }
                return result;
            }
        }

1. Now start the server again with `gradle bootRun` and navigate to `http://localhost:8080/people`. Notice the people...

        // TODO: Show the people result
