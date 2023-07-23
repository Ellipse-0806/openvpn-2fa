FROM debian:bookworm-slim

RUN set -eux; \
        apt-get update; \
        apt-get install -y --no-install-recommends \
            ca-certificates \
		    netbase \
		    tzdata \
	    ; \
	    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
        apt-get update; \
        apt-get install -y --no-install-recommends \
            procps \
            make \
            git \
            gcc \
            libreadline-dev \
            libssl-dev \
            zlib1g-dev \
        ; \
        rm -rf /var/lib/apt/lists/*

ARG FILENAME=SoftEtherVPN_Stable
ARG RELEASEPATH=https://github.com/SoftEtherVPN
RUN git clone $RELEASEPATH/$FILENAME.git

COPY --chmod=644 src/Server.c $FILENAME/src/Cedar/Server.c

RUN cd $FILENAME; \
    ./configure; \
    make; \
    make install; \
    rm -rf /$FILENAME

COPY --chmod=700 setting/setup.sh /root/setting/setup.sh
COPY --chmod=644 setting/softether-setting.ini /root/setting/softether-setting.ini

EXPOSE 1194/udp
EXPOSE 5555/tcp

CMD ["/bin/sh", "/root/setting/setup.sh"]

# ARG USERNAME=user
# ARG GROUPNAME=user
# ARG UID=1000
# ARG GID=1000
# RUN set -eux; \
#         groupadd -g $GID $GROUPNAME; \
#         useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

# USER $USERNAME
# WORKDIR /home/$USERNAME/