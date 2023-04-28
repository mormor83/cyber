FROM ubuntu:latest

LABEL maintainer="Bibin Wilson <bibinwilsonn@gmail.com>"

# Make sure the package repository is up to date.
RUN apt-get update && \
    apt-get install -qy git && \
# Install a basic SSH server
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
# Install JDK 11
    apt-get install -y openjdk-11-jdk ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f && \
# Install curl
    apt-get install -qy curl && \
# Cleanup old packages
    apt-get -qy autoremove && \
# Add user jenkins to the image
    adduser --quiet jenkins && \
# Set password for the jenkins user
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.m2
# Copy authorized keys
COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys

# Copy scripts
COPY zip_job.py /tmp
COPY custom-init.sh /tmp
COPY upload.sh /tmp
RUN  find /tmp -name "*.sh" -exec chmod +x {} \;

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/

#set Java
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
RUN export JAVA_HOME

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]