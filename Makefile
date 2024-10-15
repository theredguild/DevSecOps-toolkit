IMAGE_NAME := devsecops-toolset

# Get the latest release tag from git
LATEST_RELEASE := $(shell git describe --tags --abbrev=0)

include .env
BUILD_ARGS := $(foreach VAR,$(shell sed 's/=.*//' .env),--build-arg $(VAR)=$($(VAR)))

all: build

# Build the Docker image using current branch
build:
	docker build $(BUILD_ARGS) -t $(IMAGE_NAME):latest .

# Build the Docker image using the latest release
release:
	git checkout $(LATEST_RELEASE)
	$(MAKE) build
	git checkout -

# TODO: Check this.
latest:
	docker build $(foreach VAR,$(shell sed 's/=.*//' .env),--build-arg $(VAR)=latest) -t $(IMAGE_NAME):latest .

.PHONY: all build release latest