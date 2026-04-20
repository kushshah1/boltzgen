#!/bin/bash
# Usage:
#   bash run_inference.sh <yaml> <output_dir> <num_designs>
#
# Example:
#   bash run_inference.sh example/vanilla_protein/1g13prot.yaml workdir/my_run 100
#
# Requirements:
#   - Docker image built: docker build -t boltzgen .
#   - Directories: workdir/ and cache/ must exist at repo root
#     mkdir -p workdir cache

YAML=$1
OUTPUT=$2
NUM_DESIGNS=$3

docker run --rm --gpus all --shm-size=8g \
  -v "$(realpath workdir)":/workdir \
  -v "$(realpath cache)":/cache \
  -v "$(realpath example)":/example \
  boltzgen \
  boltzgen run /example/$(basename "$YAML") \
    --output /workdir/$(basename "$OUTPUT") \
    --protocol protein-anything \
    --num_designs "$NUM_DESIGNS" \
    --diffusion_batch_size 10
