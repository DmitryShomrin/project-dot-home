FROM ubuntu:24.10

ENV PIPX_BIN_DIR=/usr/local/bin

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y sshpass git openssh-client python3 python3-pip pipx && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN pipx install ansible-core==2.17.6 && \
    pipx install ansible==10.5.0 ansible-lint==24.9.2 && \
    rm -rf /root/.cache/pip*

RUN mkdir /ansible

WORKDIR /ansible

CMD [ "ansible-playbook", "--version" ]