import sqlite3


def test_that_empty_db_is_empty(file_to_empty_db):
    connection = sqlite3.connect(file_to_empty_db)
    try:
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM Professor")
        assert len(cursor.fetchall()) == 0

    finally:
        connection.close()


def test_that_filled_db_is_not_empty(file_to_filled_db):
    connection = sqlite3.connect(file_to_filled_db)
    try:
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM Professor")
        assert len(cursor.fetchall()) > 0

    finally:
        connection.close()


def test_that_copied_db_is_not_empty(file_to_copy_of_existing_db):
    connection = sqlite3.connect(file_to_copy_of_existing_db)
    try:
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM Professor")
        assert len(cursor.fetchall()) == 2

    finally:
        connection.close()


def test_that_filling_database_actually_fills_it(factory_db):
    alessio = (123, "Alessio", "Gambi")

    # Invoke the DB Factory passing only one tuple
    db_file = factory_db([alessio])

    connection = sqlite3.connect(db_file)
    try:
        cursor = connection.cursor()
        cursor.execute("SELECT * FROM Professor")
        assert len(cursor.fetchall()) == 1

    finally:
        connection.close()