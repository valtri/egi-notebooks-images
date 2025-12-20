FROM ubuntu:24.04

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    bash \
	krb5-user \
	sshfs \
	tini \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# to support unprivileged mounts
RUN sed -ie 's/#\s*\(user_allow_other\)/\1/' /etc/fuse.conf

COPY mount.sh /usr/local/bin/

ENTRYPOINT [ "tini", "-g", "--", "mount.sh" ]
HEALTHCHECK CMD grep '\<fuse\.sshfs\>' /proc/mounts
