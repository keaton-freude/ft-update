FROM raspbian/stretch
WORKDIR /root

ARG SSH_PRIVATE_KEY
ARG SSH_PUBLIC_KEY


# Apt-get
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update -y && apt-get install -y --no-install-recommends rssh python python3 python3-pip python3-dev libz-dev build-essential apt-transport-https ca-certificates curl git wget && rm -rf /var/lib/apt/lists/*

# SSH
RUN mkdir -p /root/.ssh && chmod 0700 /root/.ssh && ssh-keyscan github.com > /root/.ssh/known_hosts

RUN echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa && echo "$SSH_PUBLIC_KEY" > /root/.ssh/id_rsa.pub && chmod 600 /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa.pub

# Build the bootloader needed for PyInstaller
RUN wget https://github.com/pyinstaller/pyinstaller/archive/develop.tar.gz
RUN tar xvf develop.tar.gz
RUN cd pyinstaller-develop/bootloader && python3 ./waf all && cd
RUN rm develop.tar.gz

# Install pipenv
RUN python3 -m pip install pipenv


# Repo
RUN cd /root && git clone git@github.com:keaton-freude/ft-update.git
