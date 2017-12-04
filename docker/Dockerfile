FROM ubuntu:16.04

LABEL name orbslam
LABEL description "ORB SLAM image"
LABEL author "roshnee"

ENV DEBIAN_FRONTEND noninteractive
ENV OPENCV 3.1.0
ENV DISPLAY :0

# Initial update and install of dependency that can add apt-repos
RUN apt-get -y update && apt-get install -y software-properties-common python-software-properties

# Add global apt repos
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise universe" \
 && add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise main restricted universe multiverse" \
 && add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise-updates main restricted universe multiverse" \
 && add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse"

# nvidia-docker 1.0
LABEL com.nvidia.volumes.needed="nvidia_driver"
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf \
 && echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# Get dependencies
RUN apt-get update && apt-get install -y \
	libgtk2.0-dev \
	libjpeg-dev \
	libjasper-dev \
	libopenexr-dev cmake python-dev \
	python-numpy python-tk libtbb-dev \
	libeigen2-dev yasm libfaac-dev \
	libopencore-amrnb-dev libopencore-amrwb-dev \
	libtheora-dev libvorbis-dev libxvidcore-dev \
	libx264-dev libqt4-dev libqt4-opengl-dev \
	sphinx-common libv4l-dev libdc1394-22-dev \
	libavcodec-dev libavformat-dev libswscale-dev \
	libglew-dev libboost-dev libboost-python-dev libboost-serialization-dev \
	libcanberra-gtk-module \
	htop nano wget git unzip \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /opt && wget http://bitbucket.org/eigen/eigen/get/3.2.10.tar.gz -O eigen3.tgz \
 && tar zxvf eigen3.tgz && cd eigen-eigen-b9cd8366d4e8 \
 && mkdir build && cd build \
 && cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=RELEASE .. \
 && make install \
 && cd /opt && git clone https://github.com/stevenlovegrove/Pangolin.git \
 && cd Pangolin && mkdir build && cd build && cmake  .. \
 && make -j4 && make install \
 && cd /opt && wget https://codeload.github.com/opencv/opencv/zip/$OPENCV -O opencv.zip \
 && unzip opencv.zip \
 && cd opencv-$OPENCV && mkdir build && cd build \
 && cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_CUDA=OFF -D WITH_OPENGL=OFF .. \
 && make -j4 && make install \
 && rm -rf /opt/* && ldconfig

RUN cd /opt \
 && git clone https://github.com/Roshnee/ORB_SLAM2.git \
 && cd ORB_SLAM2 \
 && git checkout LiveDemo \
 && chmod +x build.sh && sh build.sh

WORKDIR /opt/ORB_SLAM2

ENTRYPOINT ["/opt/ORB_SLAM2/Examples/Monocular/live_demo"]
CMD ["Vocabulary/ORBvoc.txt", "Examples/Monocular/EuRoC.yaml", "200"]
