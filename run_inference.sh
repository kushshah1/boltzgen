#!/bin/bash
# Usage: bash run_inference.sh
docker run --rm --gpus all --shm-size=8g \
    -v "$(realpath workdir)":/workdir \
    -v "$(realpath cache)":/cache \
    -v "$(realpath example)":/example \
    boltzgen \
    boltzgen run /example/vanilla_protein/1g13prot.yaml \
      --output /workdir/test20b \
      --protocol protein-anything \
      --num_designs 20 \
      --diffusion_batch_size 10
