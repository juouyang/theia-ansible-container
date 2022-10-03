docker run -d --name theia \
    -p 3000:3000 \
    -v $(pwd)/demo/project:/home/project \
    -v $(pwd)/demo/theia-settings:/home/theia/.theia \
    -v $(pwd)/demo/ssh-config:/home/theia/.ssh \
    juouyang/theia-ansible
