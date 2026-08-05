## MacBook backup design.

Most of the important files are already been stored in Seafile sync folder, which are backed up safely from its server side (Raspberry Pi). The backup strategy for the server is written in its separate file.

A few tools are needed for this purpose,

## plist

plist is the automation file works on MacBook controlled by `launchctl`. It has the form of a bunch of key-value pairs. It needs at least three pair to run:

1. Name of this automation
1. Behavior of this automation, execute a `.sh` file for example.
1. Interval of this automation. (unit in seconds, 7200 is two hours)

After writing/editing the plist file, do not forget to bootout (if already running) and bootstrap it again using `launchctl` commands.

## Borg + borgmatic

Borg is the popular choice for backup software which will be introduced on its own. Borg runs locally on your machine and backup my files to a repo. For me, it's on a Hetzner storage box in a Germany datacenter.

## Keychain and Password

The Hetzner storage box could be connected via SSH-Key or password. The password is currently same as my Hetzner account.

The Repo is encrypted by a passphrase AND a repo key. Both are stored safely in my designated password manager. Each time create new archives needs the passphrase, so the automation process needs access to this passphrase reliably.

Surely I don't want to write my passphrase in the configuration file in plain text. On MacOS, the system keychain is the solution. Use `security` to add the passphrase into keychain and then write the read command into borgmatic yaml file at the pass command section.
