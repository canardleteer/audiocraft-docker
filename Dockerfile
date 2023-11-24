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

EXPOSE 8895

# Launch the web app by default, override the entrypoint to load a shell or ipython, or whatever.
ENTRYPOINT [ "python3", "-m", "demos.musicgen_app", "--listen", "0.0.0.0", "--server_port", "8895" ]



