FROM ubuntu:12.04
MAINTAINER Tobias Kramheller

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       software-properties-common \
       python-software-properties \
       python-pip net-tools \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean
# Install Ansible.
RUN apt-add-repository -y ppa:ansible/ansible \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       ansible \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && touch -m -t 200101010101.01 /var/lib/apt/lists \
    && apt-get clean


RUN pip install --upgrade pip
RUN pip install --upgrade pytest
RUN pip install ansible-lint testinfra

# Install Ansible inventory file
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts
