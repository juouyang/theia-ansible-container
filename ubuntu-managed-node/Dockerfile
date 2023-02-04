# Use the official Ubuntu 20.04 base image
FROM ubuntu:20.04

# Update the package list and install the OpenSSH server
RUN apt-get update && apt-get install -y openssh-server

# Create an SSH key for the root user
RUN ssh-keygen -A

# Copy the SSH key and authorized_keys file
COPY id_rsa.pub /root/.ssh/authorized_keys

# Set the root password to "password"
RUN echo "root:password" | chpasswd

RUN mkdir /run/sshd \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Expose the SSH port
EXPOSE 22

# Start the SSH server
CMD ["/usr/sbin/sshd", "-D"]
