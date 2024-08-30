#!/bin/sh
echo "$SSH_PRIV_KEY" | base64 -d >~/.ssh/id_ed25519
echo "$SSH_PUB_KEY" | base64 -d >~/.ssh/id_ed25519.pub
if ! test -d /data; then
	mkdir /data
fi
if ! test -f /data/denokv.sqlite3; then
	litestream restore /data/denokv.sqlite3
fi
# acquite some distributed lock here?
litestream replicate -exec '/usr/local/bin/denokv serve'
