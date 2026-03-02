#!/usr/bin/env bash

CONTROL_DIR="./control-plane"

echo "Listening for container requests..."

while true; do
  for file in $CONTROL_DIR/*.json; do
    [ -e "$file" ] || continue

    IMAGE=$(jq -r '.image' "$file")
    CMD=$(jq -r '.cmd' "$file")

    echo "Launching test container: $IMAGE"

    podman run --rm \
      --network internal-net \
      -v "$(pwd)/project:/workspace" \
      -w /workspace \
      $IMAGE bash -c "$CMD"

    rm "$file"
  done

  sleep 2
done
