#!bin/bash

# Exit immediately if a command exits with a non zero status
set -e
# Treat unset variables as an error when substituting
set -u

function create_databases() {
    database=$1
    password=$2
    echo "Creating user and database '$database' with password '$password'"
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
      CREATE USER $database with encrypted password '$password';
      CREATE DATABASE $database;
      GRANT ALL PRIVILEGES ON DATABASE $database TO $database;
EOSQL
}



# POSTGRES_MULTIPLE_DATABASES=db1,db2
# POSTGRES_MULTIPLE_DATABASES=db1:password,db2
if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
  echo "Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES"
  for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
    user=$(echo $db | awk -F":" '{print $1}')
    pswd=$(echo $db | awk -F":" '{print $2}')
    if [[ -z "$pswd" ]]
    then
      pswd=$user
    fi

    echo "user is $user and pass is $pswd"
    create_databases $user $pswd

	# If subfloder with user/DB name exists, execute all scripts inside for that user/DB
	# It is safe, base initialization will ignore subfloders
	# We could use docker_process_init_files, but we have no control of the DB parameters
	if [ -d "/docker-entrypoint-initdb.d/$user" ]; then
	  echo "Multiple scripts found for user $user"
      for f in /docker-entrypoint-initdb.d/$user/*; do
		  case "$f" in
			  *.sh)     echo "$0: running $f"; . "$f" ;;
			  *.sql)    echo "$0: running $f"; psql -v ON_ERROR_STOP=1 --username "$user" --dbname "$user" --no-password --no-psqlrc -f "$f" ;;
		  esac
	  done
	fi

  done

  echo "Multiple databases created!"
fi
