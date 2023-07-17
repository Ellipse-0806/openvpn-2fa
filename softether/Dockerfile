FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y \
        procps \
        make \
        git \
        gcc \
        libreadline-dev \
        libssl-dev \
        zlib1g-dev

ARG FILENAME=SoftEtherVPN_Stable
ARG RELEASEPATH=https://github.com/SoftEtherVPN
RUN git clone $RELEASEPATH/$FILENAME.git

COPY --chmod=644 src/Server.c $FILENAME/src/Cedar/Server.c

RUN cd $FILENAME && \
    ./configure && \
    make && \
    make install

COPY --chmod=700 setting/setup.sh /root/setting/setup.sh
COPY --chmod=644 setting/softether-setting.txt /root/setting/softether-setting.txt

CMD ["/bin/sh", "/root/setting/setup.sh"]

# ARG USERNAME=user
# ARG GROUPNAME=user
# ARG UID=1000
# ARG GID=1000
# RUN groupadd -g $GID $GROUPNAME && \
#     useradd -m -s /bin/bash -u $UID -g $GID $USERNAME



# USER $USERNAME
# WORKDIR /home/$USERNAME/