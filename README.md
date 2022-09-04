# theia-ansible-container

## Build

```
docker build -t theia-ansible-container:dev .
```

## Run

```
docker run --rm -it -p 3000:3000 -v $(pwd)/ansible/demo:/home/project theia-ansible-container:dev
```