# SSHFS Sidecar Image

SSHFS sidecar image.

## Usage

Using environment:

- `REMOTE_PATH`: remote path as user@host:dir (required)
- `MOUNT_OPTS`: space separated arguments for _sshfs_ command (default: see mount.sh)
- `MOUNT_PATH`: mount path (default: _/mnt_)
- `VERBOSE_KERBEROS`: check Kerberos environment (default: empty)

Examples:

```shell
REMOTE_PATH="$(id -un)@examplehost:~"
docker run --privileged -it --rm --name sshmount \
  -v /etc/krb5.conf:/etc/krb5.conf:ro \
  -v /tmp/krb5cc_$(id -u):/tmp/krb5cc_1000:ro \
  -v /tmp/sshfs:/mnt:shared \
  -v $HOME/.ssh/known_hosts:/home/ubuntu/.ssh/known_hosts:ro \
  -e REMOTE_PATH="$REMOTE_PATH" \
  -e MOUNT_OPTS="-d -o PreferredAuthentications=gssapi-with-mic -o reconnect -o transform_symlinks" \
  -e VERBOSE_KERBEROS=1 \
  sshfs-sidecar
```

```shell
REMOTE_PATH="$(id -un)@examplehost:~"
docker run --privileged -it --rm --name sshmount \
  -v /tmp/sshfs:/mnt:shared \
  -v $HOME/.ssh/known_hosts:/home/ubuntu/.ssh/known_hosts:ro \
  -v "$SSH_AUTH_SOCK":/tmp/ssh-agent \
  -e SSH_AUTH_SOCK=/tmp/ssh-agent \
  -e REMOTE_PATH="$REMOTE_PATH" \
  -e MOUNT_OPTS="-d -o PreferredAuthentications=publickey -o reconnect -o transform_symlinks" \
  sshfs-sidecar
```
