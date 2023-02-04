docker stop ubuntu-managed-node1
docker rm ubuntu-managed-node1
docker stop ubuntu-managed-node2
docker rm ubuntu-managed-node2

docker network create ansible

docker run -d -p 10022:22 --name ubuntu-managed-node1 --network ansible ubuntu-managed-node
docker run -d -p 20022:22 --name ubuntu-managed-node2 --network ansible ubuntu-managed-node
