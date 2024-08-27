#!/busybox/sh
if ! test -d /data; then
	mkdir /data
fi
if ! test -f /data/denokv.sqlite3; then
	litestream restore /data/denokv.sqlite3
fi
# acquite some distributed lock here?
litestream replicate -exec '/usr/local/bin/denokv serve'
