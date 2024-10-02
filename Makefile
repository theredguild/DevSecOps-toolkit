.PHONY: build clean exec help

IMAGE_NAME := security-tools
.DEFAULT_GOAL := help

ifneq (,$(filter run,$(firstword $(MAKECMDGOALS))))
  ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(ARGS):;@:)
endif

help:
	@echo "Usage:"
	@echo "  make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  build    Build the Docker image"
	@echo "  exec     Run an interactive shell inside the container"
	@echo "  clean    Remove the Docker image"
	@echo ""
	@echo "Examples:"
	@echo "  make"
	@echo "  make build"
	@echo "  make exec"
	@echo "  make clean"
	@echo ""

build:
	@if ! docker images $(IMAGE_NAME) | awk '{ print $$1 }' | grep -q "^$(IMAGE_NAME)$$"; then \
		echo "Docker image $(IMAGE_NAME) not found. Building now..."; \
		docker build -t $(IMAGE_NAME) .; \
	fi

exec: build
	@echo "Running interactive shell inside the $(IMAGE_NAME) container..."
	@docker run --rm -it -v $(PWD):/workdir $(IMAGE_NAME) /bin/bash

clean:
	@echo "Removing Docker image: $(IMAGE_NAME)"
	-@docker rmi $(IMAGE_NAME)
