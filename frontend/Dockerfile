FROM ubuntu:22.04

# Preparation
RUN apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y locales && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y software-properties-common wget curl nano htop pkg-config apt-utils unzip build-essential

RUN DEBIAN_FRONTEND=noninteractive curl -sL https://deb.nodesource.com/setup_22.x | bash && apt-get install -y --force-yes nodejs

WORKDIR /app

# # Dependencies will be installed during runtime
# # to avoid volume mounting issues with node_modules dir
# COPY package.json package-lock.json* ./
# RUN npm i

# Prep entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the port the app runs on
EXPOSE 3000

