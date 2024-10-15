#!/bin/bash

# Define the version of CMake to download
CMAKE_VERSION="3.26.4"

# Define the download URL
CMAKE_TAR="cmake-$CMAKE_VERSION.tar.gz"
CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/$CMAKE_TAR"

# Download the CMake tarball
echo "Downloading CMake version $CMAKE_VERSION..."
wget -O "$CMAKE_TAR" "$CMAKE_URL"

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download CMake $CMAKE_VERSION."
    exit 1
fi

echo "Successfully downloaded $CMAKE_TAR."

# Optionally, extract and install CMake
echo "Extracting $CMAKE_TAR..."
tar -xzf "$CMAKE_TAR"

cd "cmake-$CMAKE_VERSION" || exit

echo "Bootstrapping CMake..."
./bootstrap

echo "Building CMake..."
make -j"$(nproc)"

echo "Installing CMake..."
sudo make install

echo "CMake $CMAKE_VERSION has been installed successfully."
