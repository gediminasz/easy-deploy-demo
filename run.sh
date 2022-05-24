set -ev

poetry run python manage.py migrate

poetry run uwsgi --http :80 --module demo.wsgi:application --static-map /static=static
