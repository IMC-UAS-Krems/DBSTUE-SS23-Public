# DBSTUE SS23

This is the repository for your playground, exercises, and homework for Database Systems 2023

# Session 04: 29/03/2023

## Exercise 1: 

Consider a database with the following relational model (schema):

- Person (<ins>name</ins>, age, gender)
- Frequents (<ins>Person.name, pizzeria</ins>) (this is a N:M relation)
- Eats (<ins>Person.name, pizza</ins>) (this is a N:M relation)
- Serves (<ins>pizzeria, pizza</ins>, price, allergens)

>> NOTE: Limit genders to male/female/other


## Step 1: Write relational algebra expressions for the following queries:

Available Operators
UNION (U), INTERSECTION (i), DIFFERENCE (/)
PROJECTION (P), SELECTION (S)
CARTESIAN PRODUCT (x)
(JOIN)

c) Find the names of all females who eat both "mushroom" and "pepperoni" pizza.

> Women that eats pizza

OnlyWomen

(name, age, pizza)

Ada, 19, mushroom
Ada, 19, pepperoni
Leila, 45, mushroom
Diana, 75, pepperoni

---> Ada

WomenPizzas = S [ pizza == "mushroom" AND pizza == "pepperoni" ] - (OnlyWomen) - Yay!
This does not work because the condition is TRIVIALLY FALSE. We need another way

WomenLikeMushroomPizzas = P[ name ] -  (S [ pizza == "mushroom" ] - (OnlyWomen) -> (name, age, gender, pizza))

Ada
Leila

WomenLikePepperoniPizzas = P[ name ] - (S [ pizza == "pepperoni" ] - (OnlyWomen) -> (name, age, gender, pizza))

Ada
Diana

WomenLikeMushroomPizzas INTERSECTION WomenLikePepperoniPizzas = Ada

Self-Join
I do a join (cartesian product followed by selection and projection, and renaming)

Ada, 19, mushroom, pepperoni
Ada, 19, pepperoni, mushroom,
Leila, 45, mushroom, mushroom
Diana, 75, pepperoni, pepperoni

WomenSelfJoin = (name, age, eats_pizza_1, eats_pizza_2)

S [ eats_pizza_1 == eats_pizza_2 ] - (WomenSelfJoin)
    Leila, 45, mushroom, mushroom
    Diana, 75, pepperoni, pepperoni

S [ eats_pizza_1 != eats_pizza_2 ] - (WomenSelfJoin)
    Ada, 19, mushroom, pepperoni
    Ada, 19, pepperoni, mushroom

S [ eats_pizza_1 == "mushroom" AND eats_pizza_2 = "pepperoni" ] - (WomenSelfJoin) - Ada, 19, mushroom, pepperoni

P [ name ] - (S [ eats_pizza_1 != eats_pizza_2 ] - (WomenSelfJoin))
    Ada

P [ name ] ( S [ eats_pizza_1 == "mushroom" AND eats_pizza_2 = "pepperoni" ] - (WomenSelfJoin))
    Ada






d) Find all pizzerias that serve at least one pizza that Amy eats for less than $10.00.

e) Find all pizzerias that are frequented by only females or only males.


b) Find the names of all females who eat either "mushroom" or "pepperoni" pizza (or both).

> Selected the relevant relations
Person
Eats 

> Combine them and select only female

OnlyWomen = S [ gender == "female" ] (P [name, age, pizza] ( S [name == Person.name] (Person x Eats) ) ) -> (name, age, gender, pizza)

> Selected women that eat one OR the other pizza

WomenPizzas = S [ pizza == "mushroom" OR pizza == "pepperoni" ] - (OnlyWomen)

> Give the name of those women

>> Note:
>> P[] - (WomenPizzas)  -> () (select none, get none)
>> P[*] - (WomenPizzas)  -> ((name, age, gender, pizza)) -> (select all, get all)

Projection requires a list of list of attributes (projection list):

P [ name ] - (WomenPizzas) -> (name)

---- Is there another way to get those names?

WomenLikeMushroomPizzas = S [ pizza == "mushroom" ] - (OnlyWomen) -> (name, age, gender, pizza)
WomenLikePepperoniPizzas = S [ pizza == "pepperoni" ] - (OnlyWomen) -> (name, age, gender, pizza)

The set of attributes is the same, so I can apply UNION

WomenPizzas = WomenLikeMushroomPizzas U WomenLikePepperoniPizzas -> (name, age, gender, pizza)

P [ name ] - (WomenPizzas) -> (name)

If S has size |S| and T has size |T|, what's the size of S x T: |S x T| ??  |S| * |T|










a) Find all pizzerias frequented by at least one person under the age of 18.

> Which relation to include?

Frequents, Person

> Get the person under age of 18:

S [ age < 18 ] - ( Person ) --> All the Underage persons 

> Match by name persons across Person and Frequents

UnderageName = P[ name ] ( S [ age < 18 ] - ( Person ) ) --> All the names of underage persons

> Use the Cartesian Product
 
Frequents x Person = ((Person.name, pizzeria), (name, age, gender)) ---> Is this 100% correct?

Alessio, PizzaMama
Andrew, PizzaGo

Alessio, 41, Male
Andrew, 17, Male


Alessio, PizzaMama, Alessio, 41, Male
Alessio, PizzaMama, Andrew, 17, Male
Andrew, PizzaGo, Alessio, 41, Male
Andrew, PizzaGo, Andrew, 17, Male
 
> Select from the Cartesian Product ONLY the tuples that have same Name/Person.Name. We create a relation as subset of Cartesian Product

PersonFrequentPizzeria = S [ Person.name = name ] - ( Frequents x Person )

Alessio, PizzaMama, Alessio, 41, Male
Andrew, PizzaGo, Andrew, 17, Male

MERGE - Do we have this operation? No, but we can get rid of one

Alessio, PizzaMama, 41
Andrew, PizzaGo, 17

PersonFrequentPizzeria = P [name, pizzeria, age] ( S [ Person.name = name ] - ( Frequents x Person ))


PersonFrequentPizzeria: {[name, pizzeria, age]}
Alessio, PizzaMama, 41
Andrew, PizzaGo, 17


> Select from PersonFrequentPizzeria all the underage person

S [ age < 18 ] - ( PersonFrequentPizzeria ) --> Andrew, PizzaGo, 17

> Get the name of the pizzeria 

P [ pizzeria ] ( S [ age < 18 ] - ( PersonFrequentPizzeria ) ) --> PizzaGo

> Get the name of pizzeria and the name of person

P [ pizzeria, name ] ( S [ age < 18 ] - ( PersonFrequentPizzeria ) ) --> PizzaGo, Andrew

P [ pizzeria, name ] ( S [ age < 18 ] - ( P [name, pizzeria, age] ( S [ Person.name = name ] - ( Frequents x Person )) ) )

----- QUERY ------

Python App <== ORM (Python) <== Database

ORM = Object Relation Mapping
ORM Knows the Relational Schema
Create a python Object, Person out of it

------------------

SELECT pizzeria, name
FROM Person JOIN Frequents ON Person.name == Frequents.Person.Name
WHERE age < 18

--------------------------


b) Find the names of all females who eat either mushroom or pepperoni pizza (or both).

c) Find the names of all females who eat both mushroom and pepperoni pizza.

d) Find all pizzerias that serve at least one pizza that Amy eats for less than $10.00.

e) Find all pizzerias that are frequented by only females or only males.

f) For each person, find all pizzas the person eats that are not served by any pizzeria the person frequents. Return all such person (name) / pizza pairs.

g) Find the names of all people who frequent only pizzerias serving at least one pizza they eat.

h) Find the names of all people who frequent every pizzeria serving at least one pizza they eat.

i) Find the pizzeria serving the cheapest pepperoni pizza. In the case of ties, return all of the cheapest-pepperoni pizzerias.

## Step 2: Implement the database and the queries in Sqlite

- Implement the database in Sqlite
- Write fixtures to insert data and create test databases
- Read about queries and SQL operators online (try not to use ChatGPT, instead face the challenge of understanding something on your own)
- Write some queries using the Sqlite command line interface or GUI
- Implement those queries in python using "query templates" and "bulk/batch" insert
- Tests whether the queries give you the results you expect (from Step 1 and some test data you can guess what should be the result of -at least some- those queries)
    - Are all the tuples there?
    - Do the resulting tuples have the right attributes names?
    - Do the resulting tuples have all the expected attributes?


## Step 3: Reverse Engineer an ER Model for the Relational Schema

- Having an ER helps with documenting your database and spot possible inconsistencies

# Session 03: 22/03/2023

### Setup

- create a folder `session3`
- inside the `session3` folder create the `session3.py` module
- inside the `session3` folder create a `tests` folder
- inside the `session3\tests` folder create `test_session3.py` and a `conftest.py`

>> NOTE: `conftest.py` enables you to share fixtures across tests. It is loaded automatically by `pytest`, and any fixtures defined in it are available to test modules in the **same directory and below** automatically. 

- the "production database" must be stored under `session3` and is called `session3.db`


## Exercise 1: Create a Database for the University Example

- Given the University ER Model presented in class briefly describes what entities and relations it contains

- Design a Relational Model from the ER Model. Limit yourself to represent all the entities (Professor, Assistant, Student, Lecture) and the following relationships:
    -   workFor
    -   hold
    -   attend 
    -   require

>> NOTE: think on how you could/should deal with the different cardinalities

- Implement the Relational Model into Sqlite

- Fill it with some test data (using python code!)


## Exercise 2: Create Test Fixtures for the Database

- Refactor you code to improve testability
    - for instance, you can store queries into variables

- Implement the following test fixtures that return a connection to a sqlite database:

    - connection_to_empty_db: creates a test database with schema from Exercise 1 using a temporary file 
        
    - connection_to_fresh_test_db: creates a test database with schema from Exercise 1 filled with test data (from exercise 1) using a temporary file. The data must be inserted using queries.
    
    - connection_to_stored_test_db: creates a test database with schema from Exercise 1 filled with test data (from exercise 1) by copying an existing test database into a temporary file

- Write tests that check constraints of the implemented relations (e.g., cardinality). Test both positive and negative cases (asserting that Exceptions are raised during tests execution)

## Exercise 3: Extend the database

- Extend the ER model to include the concept of Tutor. Tutors are students that work for the faculty, thus are employees, and are assigned to a lecture. A lecture can have only one tutor, but the same tutor can be tutoring up to 3 lectures.

- Update the Relational Model to include the new changes in the ER Model

- Implement the new Relational Model by extending the code

- Fix the broken tests/fixtures

- Implement tests that check the new relations


# Session 02: 15/03/2023

## Exercise 1: Play around with sqlite (2)

- Complete the Exercise 2 from the previous lecture (install sqlite, write code to create a database, write a code to connect to a database)

- create a folder `session2`
 
- inside the `session2` folder create a module `test_session2.py`

- inside the `test_session2.py` module write a test that
    1. creates a database `test-db.db`
    2. table `Professor` with attributes `PersNr` (int), `FirstName` (string/varchar), and `LastName` (string/varchar) 
    3. insert the professor (123, Foo, Bar)
    4. insert the same professor (123, Foo, Bar) again
    5. assert that the second query fail

    Can you make the test fail?

- Fix the previous test to make the assertion fail (hint, define a PRIMARY KEY)

- write another test that
    1. connect to `test-db.db`
    2. create a second professor (234, Donald, Duck)
    3. check that the `Professor` contains two entries one for (123, Foo, Bar) and one for (234, Donald, Duck). Note the order does not matter

    What's the issue with those test cases?

## Exercise 2: Get you testing environment right

- Read about Xunit style of tests [https://docs.pytest.org/en/7.2.x/how-to/xunit_setup.html](https://docs.pytest.org/en/7.2.x/how-to/xunit_setup.html)

- Update the `test_session2.py` module and implement a setup and a teardown. The test setup ensures that the database and the table exists, the teardown module ensures that the database is removed afterwards

- execute the two tests and verify that now the second test (checking the two entries) fail

- fix the second test case to make it pass. Discuss how

- Read about Pytest Fixtures [https://docs.pytest.org/en/7.2.x/explanation/fixtures.html](https://docs.pytest.org/en/7.2.x/explanation/fixtures.html)

- Read about TempFiles/Folders [https://docs.pytest.org/en/7.2.x/how-to/tmp_path.html](https://docs.pytest.org/en/7.2.x/how-to/tmp_path.html)

- replace the setup and teardown methods with a fixture that initialize the database using a temporary file and fills

## Exercise 3: Understand ER Model

- Given the University ER Model presented in class briefly describes what entities and relations it contains

- Think of how you could implement this model into a database. (Do not implement it... just think about possible mapping between those entities and tables)


# Session 01: 08/03/2023

## Exercise 1: Setup Your Environment

- Checkout this repo
- Check if there are already registered Git submodules
- **Initialize** the git submodule for the public repository
- Create a folder `exercise.01`
- Inside the `exercise.01` folder, create a python virtual environment called `.venv`
- Activate `.venv` and install pytest, pymock, pycoverage
- Create a `tests` folder (remember the `__init__.py` file)
- Write a simple (passing) test
- Run the tests and check that all pass

## Exercise 2: Play Around with Sqlite

- Go to [https://www.sqlite.org/index.html](https://www.sqlite.org/index.html)
- Download and install sqlite3
- Read the documentation to find out how you can use sqlite3 from python (maybe check also [https://docs.python.org/3/library/sqlite3.html](https://docs.python.org/3/library/sqlite3.html)
- Activate `.venv`
- Install `sqlite3` python library
- Create a database `exercise.01.db` inside the `exercise.01` folder
- Write a test that check the database file exists
- Write a test that connect to the database and lists the tables inside it
- *Manually* create a new table called `Test` with attributes `Id` integer, `Desc` String/Text
- Run the test and check that the Test table exists

## Exercise 3: Modeling an Application Domain

Select an application domain and identify possible entities, their attributes, and relationship among them

Example: 

Domain: Education and Class Attendance

Entities: Students, Courses, Sessions

Relationships:
    
- Students attend a session (on a date) of a course
- Courses are made of sessions
    

Other possible application domains to model:

- Scientific Conference Publishing (a paper is authored by many authors and published at a conference, a paper cites other papers, other papers cite this paper)

- Music
- Library
- Health
- Insurance
