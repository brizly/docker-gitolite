FROM arm32v7/fedora
RUN dnf -y update \
    && dnf -y install gitolite3 openssh-server hostname findutils
RUN ssh-keygen -A
RUN useradd git
ADD admin.pub /tmp/admin.pub
USER git
ENV USER=git
RUN gitolite setup -pk /tmp/admin.pub
USER root
CMD /usr/sbin/sshd -D
