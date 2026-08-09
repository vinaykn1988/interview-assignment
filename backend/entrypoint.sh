#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

# Migrate
/app/bin/python manage.py migrate

# Launch Jupyter in background for data analysis
# Django ORM needs this to work inside Jupyter's async event loop
DJANGO_ALLOW_ASYNC_UNSAFE=true /app/bin/python manage.py shell_plus --lab &

# Launch server to provide API
/app/bin/python manage.py runserver 0.0.0.0:8000
