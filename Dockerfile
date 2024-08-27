FROM litestream/litestream AS litestream

FROM ghcr.io/denoland/denokv:latest
COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream

ENV DENO_KV_SQLITE_PATH="/data/denokv.sqlite3"

COPY litestream.yml /etc/litestream.yml
COPY start.sh /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]
