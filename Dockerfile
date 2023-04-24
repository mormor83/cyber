FROM ubuntu:latest
ENV VERSION=1.2.0
RUN apt-get update && apt-get install -y --no-install-recommends \
    ##apt-get install -qy git && \
    # Install a basic SSH server
    openssh-server \
    mkdir -p /var/run/sshd \
    # Install JDK 8 (latest stable edition at 2019-04-01)
    openjdk-8-jdk \
    # Install maven
    maven \
    # Add user jenkins to the image
    adduser --quiet jenkins && \
    # Set password for the jenkins user (you may want to alter this).
    echo "jenkins:jenkins" | chpasswd  \
    mkdir /home/jenkins/.m2 \
    python3.10 \
    python3-pip \
    vim \
    zip \
    unzip
COPY zip_job.py /tmp
COPY custom-init.sh /usr/local/bin/custom-init.sh

RUN chown -R jenkins:jenkins /home/jenkins/.m2/  \
    chown -R jenkins:jenkins /home/jenkins/.ssh/
# Standard SSH port
EXPOSE 22

CMD [ "/bin/bash" ] 