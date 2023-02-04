ssh-keygen -t rsa -b 2048 -C "ansible@training" -f $PWD/id_rsa -q -N "" <<<n >/dev/null 2>&1
docker build -t ubuntu-managed-node .
