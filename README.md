# theia-ansible-container

## Build

```
docker build -t theia-ansible-container:dev .
```

## Run

```
docker run --rm -it -p 3000:3000 theia-ansible-container:dev
```

```
docker run --rm -it -p 3000:3000 -v $(pwd)/ansible/demo:/home/project/demo theia-ansible-container:dev
```