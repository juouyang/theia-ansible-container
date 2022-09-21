podman run --rm -it \
    -p 3000:3000 \
    -v $(pwd)/demo/project:/home/project \
    -v $(pwd)/demo/theia-settings:/home/theia/.theia \
    localhost/juouyang/theia-ansible:20220907-061744
