import sqlite3


def create_db(db_file):
    """
    Factory method that create the Database schema

    :param db_file:
    :return:
    """
    connection = sqlite3.connect(db_file)
    try:
        cursor = connection.cursor()
        cursor.execute("CREATE TABLE Professor("
                       "PersNr int PRIMARY KEY,"
                       "FirstName VARCHAR(255),"
                       "LastName VARCHAR(255))")
        connection.commit()
    finally:
        connection.close()

    return db_file