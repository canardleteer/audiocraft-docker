# audiocraft-docker

Wraps [audiocraft](https://github.com/facebookresearch/audiocraft) in a docker
image.

No real testing in place other than that it won't publish if it can't build.

Updated 20240201, with what appears to be `1.3.0a1`, but they don't tag
consistently.

## Build the image

```shell
docker build -t audiocraft:latest .
```

This image could probably be slimmed down quite a bit, once expected usage
patterns are established.

## Run the locally built image

```shell
mkdir -p {cache,output};
docker run -it --rm \
    -v $(pwd)/cache:/root/.cache \
    -v $(pwd)/output:/app/output \
    --gpus=all \
    -p 8895:8895 \
    audiocraft:latest
```

You can now visit the webapp locally: [http://127.0.0.1:8895/](http://127.0.0.1:8895/)

## Run the Dockerhub image

Link to: [[dockerhub repo]](https://hub.docker.com/r/canardleteer/audiocraft-docker)

```shell
mkdir -p {cache,output};
docker run -it --rm \
    -v $(pwd)/cache:/root/.cache \
    -v $(pwd)/output:/app/output \
    --gpus=all \
    -p 8895:8895 \
    canardleteer/audiocraft-docker:main
```

You can now visit the webapp locally: [http://127.0.0.1:8895/](http://127.0.0.1:8895/)

## MAGNeT Model

The new MAGNeT Model does work locally, with the cache working appropriately.

It will need to download the model the first time, but should persist to cache.

```shell
mkdir -p {cache,output};
docker run -it --rm \
    -v $(pwd)/cache:/root/.cache \
    -v $(pwd)/output:/app/output \
    --gpus=all \
    -p 8895:8895 \
    --entrypoint=/usr/bin/python3 \
    canardleteer/audiocraft-docker:main -m demos.magnet_app --listen 0.0.0.0 --server_port 8895
```

You can now visit the MAGNeT webapp locally: [http://127.0.0.1:8895/](http://127.0.0.1:8895/)

Not going to both making a second image/profile for it at the moment.

## Github Action

I've never used Gitlab Actions much, just other YAML based CI systems.

:fingers_crossed: A docker image should be pushed to `canardleteer/audiocraft-docker` on Dockerhub.

If that does work, you should be able to:

```shell
# upstream all the things
docker pull canardleteer/audiocraft-docker:main

# pinned audiocraft (disabled for now)
# docker pull canardleteer/audiocraft-docker:v1.1.0

# the latest versioned audiocraft (disabled for now)
# docker pull canardleteer/audiocraft-docker:v1.1.0
```

## TODO

- Setup landing pad for downloaded & generated datasets
  - Currently, we just capture a `~/.cache`.
  - It appears there is a `AUDIOCRAFT_CACHE_DIR` env var we could use.
- Setup reasonable entrypoint (precache of models, webapp, etc)
- I need to think about the version pulling based on tag dynamics a
  bit more. Container env != audiocraft version, etc... But for now
  it's hotwired, with floating tags.
