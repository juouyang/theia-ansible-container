podman network create ansible
podman pod create --name=ansible

podman run --cap-add AUDIT_WRITE -d --name managed-node1 \
    --pod=ansible --network ansible --uts=private --hostname managed-node1 \
    ubuntu-managed-node
podman run --cap-add AUDIT_WRITE -d --name managed-node2 \
    --pod=ansible --network ansible --uts=private --hostname managed-node2 \
     ubuntu-managed-node

mkdir -p $(pwd)/demo/project
mkdir -p $(pwd)/demo/theia-settings
mkdir -p $(pwd)/demo/ssh-config
chmod -R 777 $(pwd)/demo/project

podman run -d --name theia \
    --pod=ansible \
    --network ansible \
    -p 3000:3000 \
    -v $(pwd)/demo/project:/home/project:Z \
    -v $(pwd)/demo/theia-settings:/home/theia/.theia:Z \
    -v $(pwd)/demo/ssh-config:/home/theia/.ssh:Z \
    theia-ansible