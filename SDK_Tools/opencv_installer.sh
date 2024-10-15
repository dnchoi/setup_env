#!/bin/bash

CV_VERSION="4.5.0"
CUDA_PATH="/usr/local/cuda"
CUDA_ARCH_NUM="7.5"

# Check if the first argument is "CUDA"
if [[ "$1" == "CUDA" ]]; then
  ENABLE_CUDA=ON
else
  ENABLE_CUDA=OFF
fi

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get -y install g++
sudo apt-get -y install build-essential cmake
sudo apt-get -y install pkg-config
sudo apt-get -y install libjpeg-dev libpng-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libx264-dev libxine2-dev
sudo apt-get -y install lib41-dev v4l-utils
sudo apt-get -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
sudo apt-get -y install libgtk2.0-dev
sudo apt-get -y install mesa-utils libgl1-mesa-dri libgtkgl2.0-dev libgtkglext1-dev
sudo apt-get -y install libatlas-base-dev gfortran libeigen3-dev
sudo apt-get -y install python2.7-dev python3-dev python-numpy python3-numpy
sudo apt-get -y install libgtk-3-dev
sudo apt-get -y install libqt5-dev

sudo apt install -y libgstreamer1.0-0 libgstreamer1.0-dev \
gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-plugins-base \
gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly  \
gstreamer1.0-alsa gstreamer1.0-libav gstreamer1.0-gl gstreamer1.0-gtk3 \
gstreamer1.0-qt5 gstreamer1.0-pulseaudio libgstreamer-plugins-base1.0-dev

sudo apt-get install -y gst-omx-listcomponents gstreamer1.0-omx-bellagio-config gstreamer1.0-omx-generic gstreamer1.0-omx-generic-config


mkdir -p ~/opencv_$CV_VERSION
cd ~/opencv_$CV_VERSION
wget -O opencv-$CV_VERSION.zip https://github.com/Itseez/opencv/archive/$CV_VERSION.zip
unzip opencv-$CV_VERSION.zip
wget -O opencv_contrib-$CV_VERSION.zip https://github.com/Itseez/opencv_contrib/archive/$CV_VERSION.zip
unzip opencv_contrib-$CV_VERSION.zip
cd opencv-$CV_VERSION
mkdir build
cd build


# Base CMake options
CMAKE_OPTIONS="
-D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_C_COMPILER=/usr/bin/gcc \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D INSTALL_C_EXAMPLES=ON \
-D BUILD_DOCS=OFF \
-D BUILD_PERF_TESTS=OFF \
-D BUILD_TESTS=OFF \
-D BUILD_PACKAGE=OFF \
-D BUILD_EXAMPLES=OFF \
-D WITH_TBB=ON \
-D ENABLE_FAST_MATH=1 \
-D WITH_IPP=OFF \
-D WITH_V4L=ON \
-D WITH_1394=OFF \
-D WITH_GTK=ON \
-D WITH_QT=OFF \
-D WITH_OPENGL=ON \
-D WITH_OPENCL=OFF \
-D WITH_EIGEN=ON \
-D WITH_FFMPEG=ON \
-D WITH_GSTREAMER=ON \
-D BUILD_JAVA=OFF \
-D BUILD_opencv_python3=ON \
-D BUILD_opencv_python2=OFF \
-D BUILD_NEW_PYTHON_SUPPORT=ON \
-D OPENCV_SKIP_PYTHON_LOADER=ON \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-$CV_VERSION/modules \
"

# Conditional CUDA options
if [[ "$ENABLE_CUDA" == "ON" ]]; then
  CMAKE_OPTIONS+=" \
-D ENABLE_FAST_MATH=1 \
-D CUDA_FAST_MATH=1 \
-D CUDA_TOOLKIT_ROOT_DIR=$CUDA_PATH \
-D WITH_CUDA=ON \
-D WITH_CUBLAS=ON \
-D WITH_CUFFT=ON \
-D WITH_NVCUVID=ON \
-D WITH_CUDNN=ON \
-D OPENCV_DNN_CUDA=ON \
-D CUDA_ARCH_BIN=$CUDA_ARCH_NUM \
-D CUDA_ARCH_PTX=$CUDA_ARCH_NUM \
-D CUDNN_LIBRARY=/usr/local/cuda/lib64/libcudnn.so \
-D CUDNN_INCLUDE_DIR=/usr/local/cuda/include \
"
else
  CMAKE_OPTIONS+=" -D WITH_CUDA=OFF "
fi

cmake $CMAKE_OPTIONS ..

make -j20

sudo make install
sudo pkg-config --modversion opencv4
sudo ldconfig
