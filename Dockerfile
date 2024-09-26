FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update -y

RUN apt-get install -y \
    sudo wget git curl unzip gnupg\
    vim zsh cmake gcc g++

# Add user
RUN useradd -s /bin/zsh -m creeper && \
    echo "creeper:creeper" | chpasswd && adduser creeper sudo && \
    echo "creeper ALL=(ALL:ALL)  NOPASSWD:ALL" >> /etc/sudoers

USER creeper
WORKDIR /home/creeper
ENV USER=creeper
ENV WORKDIR=/home/creeper

# get the latest clangd and clang-format from tsinghua mirror
COPY .devcontainer/script/clang-install.sh .
RUN bash ./clang-install.sh && rm clang-install.sh

# install oh my zsh & change theme to af-magic
COPY .devcontainer/script/zsh-install.sh .
RUN bash ./zsh-install.sh && rm clang-install.sh