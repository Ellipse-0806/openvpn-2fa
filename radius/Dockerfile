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
            freeradius \
            freeradius-utils \
            libpam-google-authenticator \
        ; \
        rm -rf /var/lib/apt/lists/*

RUN set -eux; \
        echo 'client private-network-1 {\n  ipaddr= 0.0.0.0/0\n  secret=testing123\n  shortname=private-network-1\n}' >> /etc/freeradius/3.0/clients.conf; \
        echo 'DEFAULT Group != "radius-enabled", Auth-Type := Reject\n  Reply-Message = "Your account has is unavailable."\nDEFAULT Auth-Type := PAM\n' >> /etc/freeradius/3.0/users

COPY --chmod=644 setting/radiusd.conf /etc/freeradius/3.0/radiusd.conf
COPY --chmod=644 setting/default /etc/freeradius/3.0/sites-available/default
COPY --chmod=644 setting/radiusd /etc/pam.d/radiusd

RUN ln -s /etc/freeradius/3.0/mods-available/pam /etc/freeradius/3.0/mods-enabled/pam

ARG USERNAME=user
ARG RADIUSGROUP=radius-enabled
ARG UID=1000
RUN set -eux; \
        groupadd $RADIUSGROUP; \
        useradd -m -s /bin/bash -u $UID $USERNAME; \
        gpasswd -a $USERNAME $RADIUSGROUP

EXPOSE 1182/udp
EXPOSE 1183/tcp

# USER $USERNAME
# WORKDIR /home/$USERNAME/

# RUN set -eux; \
#         google-authenticator -t -d -f -r 3 -R 30 -w 17 -q

USER root
CMD ["freeradius", "-f"]
