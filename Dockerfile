FROM litestream/litestream AS litestream

FROM ghcr.io/denoland/denokv:latest AS denokv

FROM debian:latest
COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream
COPY --from=denokv /usr/local/bin/denokv /usr/local/bin/denokv

RUN apt update && apt upgrade -y
RUN apt install openssh-client -y

ENV DENO_KV_SQLITE_PATH="/data/denokv.sqlite3"

RUN mkdir -p ~/.ssh
RUN ssh-keyscan zh2587s2.rsync.net >> ~/.ssh/known_hosts

COPY litestream.yml /etc/litestream.yml
COPY start.sh /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]
