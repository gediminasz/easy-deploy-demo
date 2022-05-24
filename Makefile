export DOCKER_HOST=ssh://demo

deploy:
	poetry run docker-compose up --build --detach
