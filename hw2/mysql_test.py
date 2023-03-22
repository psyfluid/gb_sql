# pip install mysql-connector-python

from mysql.connector import Error, connect, errorcode

import config

TEST_DB = 'gb_sql_python_test_db'

TEST_TABLE_NAME = 'sales'

TEST_TABLE_DESCR = '''
CREATE TABLE IF NOT EXISTS sales
(
    id            INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    order_date    DATE            NOT NULL,
    count_product INT3            NOT NULL
);
'''

TEST_QUERY_INSERT = '''
INSERT IGNORE INTO sales
VALUES (1, '2022-01-01', 156),
       (2, '2022-01-02', 180),
       (3, '2022-01-03', 21),
       (4, '2022-01-04', 124),
       (5, '2022-01-05', 341);
'''

TEST_QUERY_SELECT = '''
SELECT * FROM sales
'''

TEST_QUERY_UPDATE = '''
UPDATE sales
SET count_product = count_product + 10
WHERE order_date = '2022-01-01'
'''

TEST_QUERY_DELETE = '''
DELETE FROM sales
WHERE count_product < 100
'''


def create_db(mysql_cursor, db_name):
    query = f"CREATE DATABASE IF NOT EXISTS {db_name};"
    try:
        print(f"Creating database {db_name}: ", end='')
        mysql_cursor.execute(query)
    except Error as err:
        print(f"failed ({err})")
    else:
        print("OK")


def use_db(mysql_connection, mysql_cursor, db_name):
    try:
        mysql_cursor.execute(f"USE {db_name}")
    except Error as err:
        print(f"Database {db_name} does not exists.")
        if err.errno == errorcode.ER_BAD_DB_ERROR:
            create_db(mysql_cursor, db_name)
            mysql_connection.database = db_name
        else:
            print(err)
    else:
        print(f"Database changed: {db_name}")


def create_table(mysql_cursor, table_name, table_descr):
    try:
        print(f"Creating table {table_name}: ", end='')
        mysql_cursor.execute(table_descr)
    except Error as err:
        if err.errno == errorcode.ER_TABLE_EXISTS_ERROR:
            print("already exists.")
        else:
            print(err.msg)
    else:
        print("OK")


def select_from_db(mysql_cursor, query, table_name):
    col_sep = '\t|\t'
    show_table_query = f"DESCRIBE {table_name}"
    mysql_cursor.execute(show_table_query)
    for row in mysql_cursor:
        print(row[0], end=col_sep)
    print()

    mysql_cursor.execute(query)
    for row in mysql_cursor:
        print(*row, sep=col_sep, end='')
        print()
    print('----------------------------------------------------------------')


def main():
    try:
        with connect(
                host='localhost',
                user=config.user,
                password=config.password
        ) as connection:
            with connection.cursor() as cursor:
                use_db(connection, cursor, TEST_DB)
                create_table(cursor, TEST_TABLE_NAME, TEST_TABLE_DESCR)
                cursor.execute(TEST_QUERY_INSERT)
                select_from_db(cursor, TEST_QUERY_SELECT, TEST_TABLE_NAME)
                print('Updating first date')
                cursor.execute(TEST_QUERY_UPDATE)
                select_from_db(cursor, TEST_QUERY_SELECT, TEST_TABLE_NAME)
                print('Deleting rows with count < 100')
                cursor.execute(TEST_QUERY_DELETE)
                select_from_db(cursor, TEST_QUERY_SELECT, TEST_TABLE_NAME)
                connection.commit()
    except Error as err:
        print(err)


if __name__ == '__main__':
    main()
