To get started, run the following:

```
$ nix develop
$ poetry run python -m sample_package
Hello, world!
```

Docker Image:

```
docker load < $(nix build -L .\#docker-image --print-out-paths --no-link)
```

Running with nix:

```
nix run
```
