FROM ubuntu:18.04
USER root

RUN set -xe && \
  # Required tools for the apt mangling and our universal build tools.
  apt-get update && \
  apt-get install -y \
      cmake \
      git \
      gpg \
      ninja-build \
      wget && \
  \
  rm -rf /var/lib/apt/lists/*

# TODO(benvanik): include compiler setup here

RUN useradd --create-home -s /bin/bash builder
USER builder
ENV \
  DEBIAN_FRONTEND=noninteractive \
  HOME=/home/builder
