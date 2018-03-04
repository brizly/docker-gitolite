FROM arm32v7/fedora:27
RUN dnf -y install gitolite3 openssh-server hostname findutils glibc-locale-source
RUN localedef -v -c -i de_DE -f UTF-8 de_DE.UTF-8 || true
RUN ssh-keygen -A
RUN useradd git
ADD admin.pub /tmp/admin.pub
USER git
ENV USER=git
RUN gitolite setup -pk /tmp/admin.pub
USER root
EXPOSE 22/tcp
ENTRYPOINT /usr/sbin/sshd -D
