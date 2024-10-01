.PHONY: build clean exec run test help list

IMAGE_NAME := security-tools
.DEFAULT_GOAL := list

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
	@echo "  test     Run tests to verify the Docker image and tools"
	@echo "  list     List the installed tools"
	@echo "  clean    Remove the Docker image"
	@echo ""
	@echo "Optional target with parameters:"
	@echo "  run      Run a command inside the Docker container"
	@echo ""
	@echo "Examples:"
	@echo "  make"
	@echo "  make build"
	@echo "  make exec"
	@echo "  make test"
	@echo "  make clean"
	@echo "  make run trivy image python:3.4-alpine"
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

run: build
	@echo "Running command inside the $(IMAGE_NAME) container..."
	@docker run --rm -it -v $(PWD):/workdir $(IMAGE_NAME) $(ARGS)

test: build
	@echo "Running tests to verify the $(IMAGE_NAME) image and tools..."
	@docker run --rm -v $(PWD):/workdir $(IMAGE_NAME) /bin/bash -c "\
		echo 'Testing installed tools...'; \
		if [ -f /tools.txt ]; then \
			for tool in \$$(cat /tools.txt); do \
				echo 'Testing' \$$tool '...'; \
				\$$tool --version || echo '\$tool failed'; \
				echo ''; \
			done; \
			echo 'All tests completed successfully.'; \
		else \
			echo 'No tools found to test.'; \
			exit 1; \
		fi \
	"

list: build help
	@if ! docker images $(IMAGE_NAME) | awk '{ print $$1 }' | grep -q "^$(IMAGE_NAME)$$"; then \
		echo "Docker image '$(IMAGE_NAME)' not found. Please run 'make build' first."; \
		exit 1; \
	fi
	@docker run --rm $(IMAGE_NAME) /bin/bash -c "\
		if [ -f /tools.txt ]; then \
			echo ''; \
			echo 'Installed Tools:'; \
			cat /tools.txt; \
		else \
			echo 'No tools found.'; \
		fi \
	"
