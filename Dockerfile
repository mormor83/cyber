FROM ubuntu:latest
ENV VERSION=1.2.0
LABEL key="value"
RUN apt-get update &&  \
    # Install a basic SSH server
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
    # Install JDK 8 (latest stable edition at 2019-04-01)
    apt-get install -qy openjdk-8-jdk && \
    # Add user jenkins to the image
    adduser --quiet jenkins && \
    # Set password for the jenkins user 
    echo "jenkins:mormor83" | chpasswd && \
    mkdir /home/jenkins/.m2 && \
    apt-get install -qy python3.10 && \
    apt-get install -qy python3-pip && \
    apt-get install -qy vim && \
    apt-get install -qy zip && \
    apt-get install -qy unzip 
COPY zip_job.py /tmp
COPY custom-init.sh /tmp/custom-init.sh
RUN  chmod +x /tmp/custom-init.sh

RUN chown -R jenkins:jenkins /home/jenkins/.m2/  
#    chown -R jenkins:jenkins /home/jenkins/.ssh/
# Standard SSH port
EXPOSE 22

CMD [ "/bin/bash" ] 