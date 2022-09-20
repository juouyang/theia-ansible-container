docker run --rm -it \
    --cpus=1 --memory=1g \
    -p 3000:3000 \
    -v $(pwd)/demo/project:/home/project \
    -v $(pwd)/demo/theia-settings:/home/theia/.theia \
    juouyang/theia-ansible:20220907-061744