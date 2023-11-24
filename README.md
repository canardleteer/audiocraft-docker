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
    --gpus=all \
    -p 8895:8895 \
    audiocraft:latest
```

I have validated that at least something happens, by running:

```shell
gunicorn -w 4 -b 0.0.0.0:8895 -t 120 'scripts.mos:app'  --access-logfile -
```

## TODO

- Setup landing pad for downloaded images
- Setup useful demos script (if one doesn't exist, I haven't looked)
- Setup reasonable entrypoint
