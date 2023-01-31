mkdir -p $(pwd)/demo/project
mkdir -p $(pwd)/demo/theia-settings
mkdir -p $(pwd)/demo/ssh-config

docker run -d --name theia \
    -p 3000:3000 \
    -v $(pwd)/demo/project:/home/project \
    -v $(pwd)/demo/theia-settings:/home/theia/.theia \
    -v $(pwd)/demo/ssh-config:/home/theia/.ssh \
    juouyang/theia-ansible@sha256:24a020878b100719ae81d84ad17cd67902a473a13539570fb84d01f2e86e37c7
