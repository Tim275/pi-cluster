FROM python:3.11-alpine

# Basis-Pakete installieren
RUN apk add --no-cache \
    openssh-client \
    bash \
    curl \
    git \
    rsync \
    sshpass

# Ansible installieren
RUN pip install ansible

# Working directory
WORKDIR /ansible

# Entrypoint
CMD ["tail", "-f", "/dev/null"]
