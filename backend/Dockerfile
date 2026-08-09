# Use the official Python image from the Docker Hub
FROM ubuntu:22.04

# Preparation
RUN apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y locales && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y software-properties-common wget curl nano htop pkg-config apt-utils unzip build-essential

# Install Python
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y libcairo2-dev
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y python3 python3-pip python3-dev python3-venv

# Create and activate Python virtual environment
RUN python3 -m venv /app

# Copy the requirements file into the container
COPY requirements.txt .
RUN /app/bin/pip install --upgrade setuptools wheel certifi
RUN /app/bin/pip install -r requirements.txt

# Set the working directory in the container
WORKDIR /app/src

# Prep entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the port the app runs on
# Django server port
EXPOSE 8000

# Jupyterlab port
EXPOSE 8888
