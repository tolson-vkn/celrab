TAG=$(shell git rev-parse HEAD)
DOCKERHUB=docker.io/timmyolson
MAKEFILE_DIR=$(PWD)

.PHONY: help
help:
	@echo "+------------------+"
	@echo "| Makefile Targets |"
	@echo "+------------------+"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-12s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Build Web.
	@echo "+---------------------+"
	@echo "| Building Containers |"
	@echo "+---------------------+"

	docker-compose build

.PHONY: up
up: ## Start development environment.
	@echo "Starting docker environment"
	docker-compose up

.PHONY: down
down: ## Bring down development environment.
	@echo "Stopping docker environment"
	docker-compose down

.PHONY: login
login: ## Login to Docker Hub
	@echo "Login to DockerHub."
	docker login

.PHONY: publish
publish: ## Publish to Docker
	@echo "+-------------------+"
	@echo "| Build and Publish |"
	@echo "+-------------------+"

	make build

	docker tag celrab_celery $(DOCKERHUB)/celery:$(TAG)
	docker push $(DOCKERHUB)/celery:$(TAG)

	docker tag celrab_celery $(DOCKERHUB)/celery:latest
	docker push $(DOCKERHUB)/celery:latest

	docker tag celrab_beat $(DOCKERHUB)/beat:$(TAG)
	docker push $(DOCKERHUB)/beat:$(TAG)

	docker tag celrab_beat $(DOCKERHUB)/beat:latest
	docker push $(DOCKERHUB)/beat:latest
