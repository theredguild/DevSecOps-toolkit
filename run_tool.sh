#!/bin/bash
set -e

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <tool> [args...]"
    exit 1
fi

TOOL="$1"
shift

if [ -z "$TOOLS" ]; then
    echo "Error: TOOLS variable is not set."
    exit 1
fi

if ! echo "$TOOLS" | grep -wq "$TOOL"; then
    echo "Tool '$TOOL' not found. Available tools: $TOOLS"
    exit 1
fi

if ! docker image inspect "$TOOL" > /dev/null 2>&1; then
    echo "Building Docker image for $TOOL"
    docker build -t "$TOOL" -f "$TOOL.Dockerfile" .
fi

docker run --rm -it "$TOOL" "$@"
