FROM debian:9

ENV container=docker
ENV LC_ALL=C
ENV DEBIAN_FRONTEND=noninteractive

RUN echo 'deb http://archive.debian.org/debian stretch main contrib non-free' > /etc/apt/sources.list
RUN echo 'deb-src http://archive.debian.org/debian stretch main contrib non-free' >> /etc/apt/sources.list
RUN echo 'deb http://archive.debian.org/debian-security stretch/updates main contrib non-free' >> /etc/apt/sources.list
RUN echo 'deb-src http://archive.debian.org/debian-security stretch/updates main contrib non-free' >> /etc/apt/sources.list
RUN echo 'deb http://archive.debian.org/debian stretch-updates main contrib non-free' >> /etc/apt/sources.list
RUN echo 'deb-src http://archive.debian.org/debian stretch-updates main contrib non-free' >> /etc/apt/sources.list
RUN apt-get update \
    && apt-get install -y --no-install-recommends systemd python sudo bash iproute2 net-tools openssh-server openssh-client vim \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config
RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp*

RUN systemctl set-default multi-user.target
RUN sed -i 's#root:\*#root:sa3tHJ3/KuYvI#' /etc/shadow


ENV init=/lib/systemd/systemd
VOLUME [ "/sys/fs/cgroup" ]

ENTRYPOINT ["/lib/systemd/systemd"]

