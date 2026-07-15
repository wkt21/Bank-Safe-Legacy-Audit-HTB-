
## `markdown/build.md`

```md
# Build Folder

```text
build/
├── README.md
├── tree_manifest.txt
├── chroot/
│   ├── etc/
│   │   ├── app.conf
│   │   ├── fstab
│   │   ├── group
│   │   ├── hostname
│   │   ├── hosts
│   │   ├── issue
│   │   ├── motd
│   │   ├── os-release
│   │   ├── passwd
│   │   ├── resolv.conf
│   │   ├── systemd/system/rev_debug.service
│   │   └── timezone
│   ├── home/
│   │   └── bankadmin/
│   │       ├── .bash_history
│   │       ├── .bashrc
│   │       ├── .notes
│   │       ├── .profile
│   │       ├── Desktop/README.txt
│   │       ├── Documents/README.txt
│   │       └── Downloads/README.txt
│   ├── opt/
│   │   └── legacy_backup/
│   │       ├── README
│   │       ├── backup.sh
│   │       ├── config.ini
│   │       ├── flag2.txt
│   │       └── web/
│   │           ├── debug_server.py
│   │           └── index.html
│   ├── srv/
│   │   └── http/
│   │       └── banksafe/
│   │           ├── index.html
│   │           └── static/cookie.js
│   ├── usr/
│   │   ├── local/bin/rev_backdoor
│   │   └── share/.secure_docs/
│   │       ├── README_hidden
│   │       ├── bank_passwords.txt
│   │       ├── flag3_container.jpg
│   │       └── legal_work.pdf
│   └── var/log/
│       ├── auth.log
│       ├── dpkg.log
│       ├── rev_debug.log
│       └── syslog
└── staging/
    └── rootfs/
        └── same mirrored structure
