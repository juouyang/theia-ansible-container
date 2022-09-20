# theia-ansible-container

## Build

Need 4G ram for webpack while building image. [[link](https://github.com/jupyterhub/jupyterlab-hub/issues/44)]

```
docker build --progress=plain -t theia-ansible:dev .
```

## Run

```
docker run --rm -it -p 3000:3000 \
    -v $(pwd)/demo/project:/home/project \
    -v $(pwd)/demo/theia-settings:/home/theia/.theia \
    theia-ansible:dev
```