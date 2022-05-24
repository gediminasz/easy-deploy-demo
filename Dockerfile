FROM python:3.10

WORKDIR /app

COPY pyproject.toml /app/pyproject.toml
COPY poetry.lock /app/poetry.lock
RUN pip install --upgrade pip poetry
RUN poetry install --no-dev

COPY demo /app/demo
COPY manage.py /app/manage.py
COPY run.sh /app/run.sh

RUN poetry run python manage.py collectstatic --no-input --clear

CMD ./run.sh
