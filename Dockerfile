# Use latest Python runtime as a parent image
FROM ubuntu:18.04

# Meta-data
LABEL maintainer="C Ferraren <cliferraren@gmail.com>" \
      description="Data Science Container\
      Libraries, data, and code in one image"

RUN apt-get update && apt-get install -y wget ca-certificates \
    build-essential python3.7 python3.7-dev python3-pip \
    git curl vim \
    libfreetype6-dev \
    libhdf5-serial-dev \
    libzmq3-dev \
    pkg-config \
    libhdf5-dev \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip
RUN pip3 install tensorflow numpy==1.14.5 && \
    pip3 install --upgrade pandas scipy matplotlib seaborn jupyter pyyaml h5py && \
    pip3 install scikit-learn==0.20rc1 && \
    pip3 install keras

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Create mountpoint
VOLUME /app/data

# Jupyter and Tensorboard ports
EXPOSE 8888 6006

# Run jupyter when container launches
CMD ["jupyter", "notebook", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]
