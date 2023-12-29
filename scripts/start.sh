#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

scripts/wait-for-db.sh
python manage.py collectstatic --noinput
python manage.py migrate
gunicorn bbhbackend.wsgi --bind 0.0.0.0:8000 --reload --workers 5 --timeout 60 --error-logfile '-' --access-logfile '-' --access-logformat '%({x-forwarded-for}i)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"'