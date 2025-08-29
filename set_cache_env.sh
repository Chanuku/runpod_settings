# 0) Prepare base directories
mkdir -p /workspace/.cache \
         /workspace/.config \
         /workspace/.local/share \
         /workspace/.cache/{pip,torch,nv} \
         /workspace/.cache/huggingface/{hub,transformers,diffusers,datasets} \
         /workspace/.config/matplotlib

# 1) Create symbolic links for home directories (already done for .cache, but double-check for safety)
[ -L /root/.cache ] || { mv /root/.cache /root/.cache.bak 2>/dev/null || true; ln -s /workspace/.cache /root/.cache; }
[ -L /root/.config ] || { mv /root/.config /root/.config.bak 2>/dev/null || true; ln -s /workspace/.config /root/.config; }
[ -L /root/.local ]  || { mv /root/.local  /root/.local.bak  2>/dev/null || true; ln -s /workspace/.local  /root/.local; }

# 2) Environment variables (apply for current session + persist for future logins)
cat <<'EOF' >> ~/.bashrc
# === Store caches/configs under /workspace ===
export XDG_CACHE_HOME=/workspace/.cache
export XDG_CONFIG_HOME=/workspace/.config
export XDG_DATA_HOME=/workspace/.local/share

# Hugging Face / Transformers / Diffusers / datasets
export HF_HOME=/workspace/.cache/huggingface
export HF_HUB_CACHE=/workspace/.cache/huggingface/hub
export TRANSFORMERS_CACHE=/workspace/.cache/huggingface/transformers
export DIFFUSERS_CACHE=/workspace/.cache/huggingface/diffusers
export HF_DATASETS_CACHE=/workspace/.cache/huggingface/datasets

# PyTorch / TorchInductor / Matplotlib / CUDA kernel cache
export TORCH_HOME=/workspace/.cache/torch
export PYTORCHINDUCTOR_CACHE_DIR=/workspace/.cache/torch/inductor
export MPLCONFIGDIR=/workspace/.config/matplotlib
export CUDA_CACHE_PATH=/workspace/.cache/nv

# pip cache
export PIP_CACHE_DIR=/workspace/.cache/pip
EOF

# Apply environment variables to current shell immediately
export XDG_CACHE_HOME=/workspace/.cache
export XDG_CONFIG_HOME=/workspace/.config
export XDG_DATA_HOME=/workspace/.local/share
export HF_HOME=/workspace/.cache/huggingface
export HF_HUB_CACHE=/workspace/.cache/huggingface/hub
export TRANSFORMERS_CACHE=/workspace/.cache/huggingface/transformers
export DIFFUSERS_CACHE=/workspace/.cache/huggingface/diffusers
export HF_DATASETS_CACHE=/workspace/.cache/huggingface/datasets
export TORCH_HOME=/workspace/.cache/torch
export PYTORCHINDUCTOR_CACHE_DIR=/workspace/.cache/torch/inductor
export MPLCONFIGDIR=/workspace/.config/matplotlib
export CUDA_CACHE_PATH=/workspace/.cache/nv
export PIP_CACHE_DIR=/workspace/.cache/pip

# 3) Configure pip to always use /workspace for caching
pip config set global.cache-dir /workspace/.cache/pip || true
