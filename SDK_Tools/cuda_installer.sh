#!/bin/bash

# Define URLs for CUDA Toolkit and cuDNN (ensure these are direct download links you have access to)
CUDA_URL="https://developer.download.nvidia.com/compute/cuda/11.1.0/local_installers/cuda_11.1.0_455.23.05_linux.run"
CUDNN_URL="https://developer.download.nvidia.com/compute/redist/cudnn/v8.0.5/cudnn-11.1-linux-x64-v8.0.5.39.tgz"

# Download CUDA Toolkit 11.1
echo "Downloading CUDA Toolkit 11.1..."
wget -O cuda_11.1.0_455.23.05_linux.run "$CUDA_URL"

# Check if CUDA download was successful
if [ $? -ne 0 ]; then
  echo "CUDA download failed. Please check the URL and your internet connection."
  exit 1
fi

# Download cuDNN 8.0.5 for CUDA 11.1
echo "Downloading cuDNN 8.0.5 for CUDA 11.1..."
wget -O cudnn-11.1-linux-x64-v8.0.5.39.tgz "$CUDNN_URL"

# Check if cuDNN download was successful
if [ $? -ne 0 ]; then
  echo "cuDNN download failed. Please check the URL and your internet connection."
  exit 1
fi

echo "Downloads completed successfully."
