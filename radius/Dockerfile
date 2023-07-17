FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y \
        freeradius \
        freeradius-utils \
        libpam-google-authenticator

RUN echo 'client private-network-1 {\n  ipaddr= 0.0.0.0/0\n  secret=testing123\n  shortname=private-network-1\n}' >> /etc/freeradius/3.0/clients.conf && \
    echo 'DEFAULT Group != "radius-enabled", Auth-Type := Reject\n  Reply-Message = "Your account has is unavailable."\nDEFAULT Auth-Type := PAM\n' >> /etc/freeradius/3.0/users

COPY --chmod=644 setting/radiusd.conf /etc/freeradius/3.0/radiusd.conf
COPY --chmod=644 setting/default /etc/freeradius/3.0/sites-available/default
COPY --chmod=644 setting/radiusd /etc/pam.d/radiusd

RUN ln -s /etc/freeradius/3.0/mods-available/pam /etc/freeradius/3.0/mods-enabled/pam

ARG USERNAME=user
ARG GROUPNAME=user
ARG RADIUSGROUP=radius-enabled
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $GROUPNAME && \
    groupadd $RADIUSGROUP && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME && \
    gpasswd -a $USERNAME $RADIUSGROUP

RUN service freeradius start
USER $USERNAME
WORKDIR /home/$USERNAME/