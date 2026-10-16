# Use official NVIDIA CUDA PyTorch base image for GPU acceleration
# ORIGINAL LINE:  FROM pytorch/pytorch:2.1.2-cuda11.8-cudnn8-runtime
FROM pytorch/pytorch:2.5.1-cuda12.1-cudnn9-runtime

# Set working directory inside the container
WORKDIR /app

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies (git, ffmpeg, build tools)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ffmpeg \
    libsndfile1 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Clone your modified GitHub repository (replace with your personal username)
RUN git clone https://github.com/keykore/facefusion.git /app/facefusion

# Navigate into the project directory
WORKDIR /app/facefusion

# Install Python requirements
RUN pip install --no-cache-dir -r requirements.txt

# Expose the default FaceFusion web UI port
EXPOSE 7860

# Default command to run FaceFusion web UI
CMD ["python", "facefusion.py", "run", "--port", "7860"]

