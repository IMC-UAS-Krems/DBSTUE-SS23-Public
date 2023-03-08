# DBSTUE SS23

This is the repository for your playground, exercises, and homework for Database Systems 2023

# Exercise 1: Setup Your Environment

- Checkout this repo
- Check if there are already registered Git submodules
- **Initialize** the git submodule for the public repository
- Create a folder `exercise.01`
- Inside the `exercise.01` folder, create a python virtual environment called `.venv`
- Activate `.venv` and install pytest, pymock, pycoverage
- Create a `tests` folder (remember the `__init__.py` file)
- Write a simple (passing) test
- Run the tests and check that all pass

# Exercise 2: Play Around with Sqlite

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

# Exercise 3: Modeling an Application Domain

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
