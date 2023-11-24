ARG CUDA_VERSION=12.0.0
ARG UBUNTU_VERSION=22.04

# NOTE(canardleteer): I don't know what the minimal image I should use yet is.
FROM nvidia/cuda:${CUDA_VERSION}-cudnn8-devel-ubuntu${UBUNTU_VERSION}

ARG AUDIOCRAFT_BRANCH=main

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y git python3 python3-pip ipython3 ffmpeg && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install 'torch>=2.0' numpy Flask gunicorn

RUN git clone --recurse-submodules --branch ${AUDIOCRAFT_BRANCH} -j8 https://github.com/facebookresearch/audiocraft.git . && \
    pip3 install -e .

# NOTE(canardleteer): Reading through the docs, there is an offering in an
#                     example. I haven't tested it yet, that listens on this
#                     port and needs a user defined. I was able to spin it up,
#                     after making this directory as well. I haven't used it
#                     more than validating that the simple webui comes up.
EXPOSE 8895
ENV USER=genericuser
RUN mkdir -p /tmp/audiocraft_root/mos_storage

ENTRYPOINT [ "/bin/bash" ]



