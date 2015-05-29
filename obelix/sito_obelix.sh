#!/bin/bash

mysql --user=root --password= < creo_database.sql
mysql --user=obelix --password=dbdjob@ --database=obelixdb < dump_obelixdb.sql
python manage.py shell < scripts/estendo_superuser.py
python manage.py syncdb
mysql --user=root --password= < test.sql
python manage.py runserver

