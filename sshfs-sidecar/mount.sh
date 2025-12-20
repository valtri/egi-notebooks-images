#! /usr/bin/env bash

MOUNT_OPTS=${MOUNT_OPTS:--o reconnect}
MOUNT_PATH=${MOUNT_PATH:-/mnt/}
REMOTE_PATH=${REMOTE_PATH:-}

if [ ! -d "$MOUNT_PATH" ]; then
	mkdir -p "$MOUNT_PATH"
fi

if [ -n "$VERBOSE_KERBEROS" ]; then
	echo "KRB5_CONFIG: $KRB5_CONFIG"
	echo "KRB5CCNAME: $KRB5CCNAME"
	krb5conf=${KRB5_CONFIG:-/etc/krb5.conf}
	ls -la "$krb5conf"
	klist -efan
	if klist -s; then
		echo "Kerberos ticked valid"
	else
		echo "Warning: Kerberos ticked invalid!"
	fi
fi

do_umount() {
	fusermount3 -u -z "$MOUNT_PATH" 2>/dev/null || :
}

trap "do_umount" INT TERM ABRT

IFS=" " read -r -a mount_opts <<<"$MOUNT_OPTS"

if [ -n "$REMOTE_PATH" ]; then
	set -o xtrace
	sshfs -f "$REMOTE_PATH" "$MOUNT_PATH" "${mount_opts[@]}"
	echo "SSHFS terminated, return code $?"
else
	echo "REMOTE_PATH not specified, not mounting sshfs"
fi
