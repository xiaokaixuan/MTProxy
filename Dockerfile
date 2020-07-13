FROM debian:stable-slim as builder

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update; \
    apt-get install -y --no-install-recommends git curl ca-certificates build-essential libssl-dev zlib1g-dev 2>/dev/null && \
    git clone https://github.com/TelegramMessenger/MTProxy.git /MTProxy && \
    cd /MTProxy && make


FROM debian:stable-slim

COPY --from=builder /MTProxy/objs/bin/mtproto-proxy /MTProxy/
COPY entrypoint.sh /entrypoint.sh

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update; \
    apt-get install -y --no-install-recommends busybox curl ca-certificates 2>/dev/null && \
    chmod a+x /entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]

