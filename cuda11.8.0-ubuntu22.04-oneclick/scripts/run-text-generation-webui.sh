#!/bin/bash
cd /workspace/text-generation-webui

# Edit these arguments if you want to customise text-generation-webui launch.
# Don't remove "$@" from the start unless you want to prevent automatic model loading from template arguments
ARGS=("$@" --listen --extensions openai --gradio-auth-path /workspace/credentials --model phind-codellama-34b-v2.Q5_K_M.gguf --n-gpu-layers 100 --threads 1 --multi-user)

echo "Launching text-generation-webui with args: ${ARGS[@]}"

python3 server.py "${ARGS[@]}"
