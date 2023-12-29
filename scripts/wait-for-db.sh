#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

db_ready() {
python << END
import sys

import psycopg2

try:
    psycopg2.connect(
        dbname="${DATABASE_NAME}",
        user="${DATABASE_USER}",
        password="${DATABASE_PASSWORD}",
        host="${DATABASE_HOST}",
        port="${DATABASE_PORT}",
    )
except psycopg2.OperationalError as e:
    print(e)
    sys.exit(-1)
sys.exit(0)

END
}
until db_ready; do
  >&2 echo 'Waiting for Database to become available...'
  sleep 1
done
>&2 echo 'Database is available'

exec "$@"
