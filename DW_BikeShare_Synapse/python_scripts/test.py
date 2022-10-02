import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

########################################
# Update connection string information #
########################################
host = ""
user = ""
password = ""

# Create a new DB
sslmode = "require"
dbname = "postgres"
conn_string = "host={0} user={1} dbname={2} password={3} sslmode={4}".format(host, user, dbname, password, sslmode)
conn = psycopg2.connect(conn_string)
conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT);
print("Connection established")
