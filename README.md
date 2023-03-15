# DBSTUE SS23

This is the repository for your playground, exercises, and homework for Database Systems 2023

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

## Exercise 4: Understand ER Model

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
