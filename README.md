# Initial Setup for Using Hugging Face Diffusers on RunPod

When running on **RunPod**, the default cache/config directories (e.g., `~/.cache`, `~/.config`) are stored under `/root`.

Since `/workspace` is the persistent storage in RunPod, it is best to **redirect all cache and config paths into `/workspace`** so that models, datasets, and compiled kernels are not lost when the container restarts.

This setup ensures:
- Hugging Face models & datasets are stored in `/workspace/.cache/huggingface`
- PyTorch and TorchInductor caches persist under `/workspace/.cache/torch`
- CUDA kernel cache is saved under `/workspace/.cache/nv`
- pip cache is reused across sessions
- Matplotlib and other config files also live under `/workspace`

---

```bash
chmod +x set_cache_env.sh
source set_cache_env.sh
```

To check:
```bash
env | egrep 'XDG_|HF_|TRANSFORMERS|DIFFUSERS|TORCH|PYTORCHINDUCTOR|MPLCONFIGDIR|CUDA_CACHE|PIP_CACHE'
```

You should see output like:
```
XDG_CACHE_HOME=/workspace/.cache
HF_HOME=/workspace/.cache/huggingface
TRANSFORMERS_CACHE=/workspace/.cache/huggingface/transformers
DIFFUSERS_CACHE=/workspace/.cache/huggingface/diffusers
TORCH_HOME=/workspace/.cache/torch
PYTORCHINDUCTOR_CACHE_DIR=/workspace/.cache/torch/inductor
CUDA_CACHE_PATH=/workspace/.cache/nv
PIP_CACHE_DIR=/workspace/.cache/pip
```
