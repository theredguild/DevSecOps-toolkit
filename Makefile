.DEFAULT_GOAL := help

TOOLS := trivy trufflehog

.PHONY: help build-all build run list clean test

help:
	@echo "Usage:"
	@echo "  make <target> [tool] [args...]"
	@echo ""
	@echo "Targets:"
	@echo "  build-all                Build Docker images for all tools"
	@echo "  build <tool>             Build Docker image for a specific tool (e.g., make build trivy)"
	@echo "  run <tool> -- [args...]  Run a specific tool (e.g., make run trufflehog -- git ssh://github.com/reynico/container-sec-tools --only-verified)"
	@echo "  list                     List all available tools"
	@echo "  clean                    Remove all Docker images"
	@echo "  test <tool>              Test a specific tool to check if it runs without errors"
	@echo ""
	@echo "Available tools:"
	@echo "  $(TOOLS)"
	@echo ""

build-all:
	@for tool in $(TOOLS); do \
		echo "Building Docker image for $$tool"; \
		docker build -t $$tool -f $$tool.Dockerfile .; \
	done

build:
	@tool="$(word 2,$(MAKECMDGOALS))"; \
	if [ -z "$$tool" ]; then \
		echo "Please specify a tool. Available tools: $(TOOLS)"; \
		exit 1; \
	fi; \
	if echo "$(TOOLS)" | grep -wq "$$tool"; then \
		echo "Building Docker image for $$tool"; \
		docker build -t $$tool -f $$tool.Dockerfile .; \
	else \
		echo "Tool $$tool not found. Available tools: $(TOOLS)"; \
		exit 1; \
	fi
	@exit 0

run:
	@ARGS="$(filter-out $@,$(MAKECMDGOALS))"; \
	export TOOLS="$(TOOLS)"; \
	./run_tool.sh $$ARGS
	@exit 0

list:
	@echo "Available tools:"
	@echo "  $(TOOLS)"

clean:
	@echo "Removing Docker images..."
	@for tool in $(TOOLS); do \
		echo "Removing $$tool image..."; \
		docker rmi $$tool || true; \
	done
	@echo "All images removed."

test:
	@tool="$(word 2,$(MAKECMDGOALS))"; \
	if [ -z "$$tool" ]; then \
		echo "Please specify a tool to test. Available tools: $(TOOLS)"; \
		exit 1; \
	fi; \
	if echo "$(TOOLS)" | grep -wq "$$tool"; then \
		echo "Testing Docker image for $$tool"; \
		make build $$tool; \
		echo "Running $$tool to ensure it executes without errors..."; \
		docker run --rm $$tool; \
		if [ $$? -eq 0 ]; then \
			echo "Test for $$tool passed!"; \
		else \
			echo "Test for $$tool failed!"; \
			exit 1; \
		fi; \
	else \
		echo "Tool $$tool not found. Available tools: $(TOOLS)"; \
		exit 1; \
	fi
	@exit 0

# Prevent make from interpreting additional arguments as targets
%:
	@:
