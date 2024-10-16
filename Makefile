IMAGE_NAME := devsecops-toolkit
.DEFAULT_GOAL := help

# Get the latest release tag from git
LATEST_RELEASE := $(shell git describe --tags --abbrev=0)

include .env
BUILD_ARGS := $(foreach VAR,$(shell sed 's/=.*//' .env),--build-arg $(VAR)=$($(VAR)))

help:
	@echo "Usage:"
	@echo "  make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  build    Build the Docker image with the software versions described in the .env file"
	@echo "  release  Build the Docker image with the software versions described in the .env file, but from a specific release of this repo"
	@echo "  latest   Build the Docker image with the latest version for each tool"
	@echo "  exec     Run an interactive shell inside the container"
	@echo ""
	@echo "Examples:"
	@echo "  make"
	@echo "  make build"
	@echo "  make release"
	@echo "  make latest"
	@echo "  make exec"
	@echo ""

# Build the Docker image using current branch
build:
	@if ! docker images $(IMAGE_NAME) | awk '{ print $$1 }' | grep -q "^$(IMAGE_NAME)$$"; then \
		echo "Docker image $(IMAGE_NAME) not found. Building now..."; \
		docker build $(BUILD_ARGS) -t $(IMAGE_NAME) .; \
	fi

# Build the Docker image using the latest release
release:
	git checkout $(LATEST_RELEASE)
	$(MAKE) build
	git checkout -

# TODO: Check this.
latest:
	docker build $(foreach VAR,$(shell sed 's/=.*//' .env),--build-arg $(VAR)=latest) -t $(IMAGE_NAME):latest .

exec: build
	@echo "Running interactive shell inside the $(IMAGE_NAME) container..."
	@docker run --rm -it -v $(PWD):/workdir $(IMAGE_NAME):latest /bin/zsh

.PHONY: help build release latest exec