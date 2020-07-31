CREATE USER mart WITH password 'F5nJ4ZjJBNp0r';

CREATE database mart
  WITH owner = mart
       encoding = 'UTF8'
       tablespace = pg_default
       lc_collate = 'en_US.UTF-8'
       lc_ctype = 'en_US.UTF-8'
       template template0
       connection limit = -1;
GRANT connect, temporary on database mart to public;

GRANT ALL ON DATABASE mart TO mart;

\connect mart;

CREATE EXTENSION "uuid-ossp";

