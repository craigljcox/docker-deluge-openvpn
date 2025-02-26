FROM linuxserver/deluge:latest
LABEL maintainer=""

VOLUME /config
VOLUME /downloads

# Install openvpn and utilities
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y wget git curl jq sudo ufw iputils-ping openvpn bc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY root/ /

ENV OPENVPN_USERNAME=**None** \
    OPENVPN_PASSWORD=**None** \
    OPENVPN_PROVIDER=**None** \
    ENABLE_UFW=false \
    UFW_ALLOW_GW_NET=false \
    UFW_EXTRA_PORTS= \
    UFW_DISABLE_IPTABLES_REJECT=false \
    DROP_DEFAULT_ROUTE=

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -L -f https://api.ipify.org || exit 1

# Expose port and run
EXPOSE 8112 58846 58946 58946/udp
