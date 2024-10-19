IMAGE_NAME := devsecops-toolkit
.DEFAULT_GOAL := help

# Get the latest release tag from git
LATEST_RELEASE := $(shell git describe --tags --abbrev=0)

include .env
BUILD_ARGS := $(foreach VAR,$(shell sed 's/=.*//' .env),--build-arg $(VAR)=$($(VAR)))

# Use buildx only in GitHub Actions
ifdef GITHUB_ACTIONS
	DOCKER_BUILD_CMD := docker buildx build --load --cache-from type=gha --cache-to type=gha,mode=max
else
	DOCKER_BUILD_CMD := docker build
endif

help:
	@echo "Usage:"
	@echo "  make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  build    Build the Docker image with the software versions described in the .env file"
	@echo "  release  Build the Docker image with the software versions described in the .env file, but from a specific release of this repo"
	@echo "  latest   Build the Docker image with the latest version for each tool"
	@echo "  exec     Run an interactive shell inside the container"
	@echo "  clean    Remove Docke image $(IMAGE_NAME) and wipe cache (CAREFUL)"
	@echo ""
	@echo "Examples:"
	@echo "  make"
	@echo "  make build"
	@echo "  make rebuild"
	@echo "  make release"
	@echo "  make latest"
	@echo "  make exec"
	@echo "  make clean"
	@echo ""

# Build the Docker image using current branch
build:
	@if ! docker images $(IMAGE_NAME) | awk '{ print $$1 }' | grep -q "^$(IMAGE_NAME)$$"; then \
		echo "Docker image $(IMAGE_NAME) not found. Building now..."; \
		$(DOCKER_BUILD_CMD) $(BUILD_ARGS) -t $(IMAGE_NAME) .; \
	else \
		echo "Image found, not building. If you want to rebuild, run make rebuild"; \
	fi

rebuild:
	@echo "Rebuilding $(IMAGE_NAME) without cache, will take a while."
	@$(DOCKER_BUILD_CMD) $(BUILD_ARGS) --no-cache -t $(IMAGE_NAME) .;

# Build the Docker image using the latest release
release:
	@git checkout $(LATEST_RELEASE)
	@$(MAKE) build
	@git checkout -

# TODO: Check this.
latest:
	@$(DOCKER_BUILD_CMD) $(foreach VAR,$(shell sed 's/=.*//' .env),--build-arg $(VAR)=latest) -t $(IMAGE_NAME):latest .

exec: build
	@echo "Running interactive shell inside the $(IMAGE_NAME) container..."
	@docker run --hostname trg --rm -it -v $(PWD):/workdir $(IMAGE_NAME):latest /bin/zsh

clean:
	@echo "Removing Docker image with the name $(IMAGE_NAME)..."
	@docker rmi -f $(IMAGE_NAME) && docker builder prune -f

.PHONY: help build rebuild release latest exec clean