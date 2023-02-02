# theia-ansible-container

## Build

Need 8G ram for webpack while building image. [[link](https://github.com/jupyterhub/jupyterlab-hub/issues/44)]

```
docker build --progress=plain -t theia-ansible:dev .
```

## Run

```
mkdir -p $(pwd)/demo/project
mkdir -p $(pwd)/demo/theia-settings
mkdir -p $(pwd)/demo/ssh-config
```

docker
```
docker run --rm -it -p 3000:3000 \
    -v $(pwd)/demo/project:/home/project \
    -v $(pwd)/demo/theia-settings:/home/theia/.theia \
    -v $(pwd)/demo/ssh-config:/home/theia/.ssh \
    theia-ansible:dev
```

podman
```
chmod -R 777 $(pwd)/demo

podman run -d --name theia \
    -p 3000:3000 \
    -v $(pwd)/demo/project:/home/project:Z \
    -v $(pwd)/demo/theia-settings:/home/theia/.theia:Z \
    -v $(pwd)/demo/ssh-config:/home/theia/.ssh:Z \
    docker.io/juouyang/theia-ansible@sha256:24a020878b100719ae81d84ad17cd67902a473a13539570fb84d01f2e86e37c7
```
