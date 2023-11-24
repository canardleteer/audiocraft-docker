# audiocraft-docker

Wraps [audiocraft](https://github.com/facebookresearch/audiocraft) in a docker
image.

Untested.

## Build the image

```shell
docker build -t audiocraft:latest .
```

## Run the image

```shell
docker run -it --rm \
    -v $(pwd)/cache:/root/.cache \
    -v $(pwd)/output:/app/output \
    --gpus=all \
    -p 8895:8895 \
    audiocraft:latest
```

You can now visit the webapp locally: [http://127.0.0.1:8895/](http://127.0.0.1:8895/)

## TODO

- Setup landing pad for downloaded & generated datasets
  - Currently, we just capture a `~/.cache`.
- Setup reasonable entrypoint (precache of models, webapp, etc)
