#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="${1:-Bank-Safe-Legacy-Audit-HTB}"
mkdir -p "$ROOT_DIR"

write_file() {
  local path="$1"
  shift
  mkdir -p "$(dirname "$ROOT_DIR/$path")"
  cat > "$ROOT_DIR/$path" <<'EOF'
'"$@"'
EOF
}

cat > "$ROOT_DIR/README.md" <<'EOF'
# Bank-Safe-Legacy-Audit-HTB

## Services

| Service | Port | Purpose |
|---|---:|---|
| Debug Server | 42328 | Returns final flag |
| Web Interface | 80/443 | Hosts passive clue via fake cookie / JS comment |

## Fictional CVE

CVE-2026-1337 — Insecure Update Handler in LegacyBackup

- Type: Local file read / limited command injection
- Vector: Unsafe `eval` usage in `backup.sh`
- Impact: Access to restricted local content
- Severity: Medium
- Note: Fully fictional and intentionally safe for challenge use

## Learning Objectives

- Perform practical Linux enumeration.
- Read breadcrumbs from hidden user files.
- Recognize insecure shell scripting patterns.
- Understand how unsafe `eval` can be abused.
- Discover hidden files and directories.
- Trace multi-artifact clue chains.
- Inspect frontend assets for passive hints.
- Use `curl` to validate and interact with services.

## Rules / Requirements

- No brute force required.
- No real malware.
- No persistence beyond challenge design.
- No outbound command-and-control behavior.
- Intended to work offline.
- All malicious behavior is simulated and safe.

## Repository Contents

- `FILESYSTEM.md` — documented challenge filesystem layout.
- `ARTIFACTS.md` — important files, clues, flags, and services.
- `challenge/rootfs/` — source tree for challenge artifacts.
- `challenge/source_material/` — source text for binary artifacts.

## Notes for Builders

The repository includes source material for the PDF and JPG challenge artifacts. If you are packaging this into a live VM, replace the placeholder/source approach with actual generated binary files matching the intended contents.

This challenge is designed to feel like a realistic audit environment while remaining entirely self-contained and safe. The path is primarily linear, but multiple breadcrumbs reinforce each step to reduce player frustration without requiring brute force.
EOF

cat > "$ROOT_DIR/FILESYSTEM.md" <<'EOF'
Filesystem Layout

This document describes the intended Linux-style filesystem structure for the challenge VM.

Full Challenge Filesystem
/
├── bin/
│   ├── bash
│   ├── sh
│   ├── ls
│   ├── cat
│   ├── chmod
│   └── systemctl
│
├── boot/
│   └── grub/
│
├── dev/
│   ├── null
│   ├── tty
│   ├── sda
│   └── random
│
├── etc/
│   ├── passwd
│   ├── shadow
│   ├── hosts
│   ├── fstab
│   ├── updatedb.conf
│   ├── app.conf
│   └── systemd/
│       └── system/
│           └── rev_debug.service
│
├── home/
│   └── bankadmin/
│       ├── flag1.txt
│       ├── .notes
│       ├── .bash_history
│       └── .cache/
│
├── lib/
│   ├── systemd/
│   └── x86_64-linux-gnu/
│
├── media/
│   └── usb/
│
├── mnt/
│   └── backup/
│
├── opt/
│   └── legacy_backup/
│       ├── backup.sh
│       ├── config.ini
│       ├── flag2.txt
│       ├── README
│       └── web/
│           ├── debug_server.py
│           └── index.html
│
├── proc/
│   ├── cpuinfo
│   ├── meminfo
│   └── 1/
│       └── status
│
├── root/
│   ├── .ssh/
│   └── .bashrc
│
├── run/
│   └── systemd/
│
├── sbin/
│   ├── init
│   ├── reboot
│   └── shutdown
│
├── srv/
│   └── http/
│       └── banksafe/
│           ├── index.html
│           └── static/
│               └── cookie.js
│
├── sys/
│   └── kernel/
│
├── tmp/
│   └── tempfiles
│
├── usr/
│   ├── bin/
│   │   ├── python3
│   │   ├── curl
│   │   └── strings
│   ├── sbin/
│   ├── local/
│   │   └── bin/
│   │       └── rev_backdoor
│   └── share/
│       └── .secure_docs/
│           ├── bank_passwords.txt
│           ├── legal_work.pdf
│           ├── flag3_container.jpg
│           └── README_hidden
│
└── var/
    ├── log/
    │   ├── auth.log
    │   ├── syslog
    │   └── rev_debug.log
    ├── backups/
    └── www/
EOF

cat > "$ROOT_DIR/ARTIFACTS.md" <<'EOF'
Challenge Artifacts

This document lists all primary challenge artifacts, flags, clues, and service-related files.

Flags

Flag 1
- Path: /home/bankadmin/flag1.txt
- Value: HTB{initial_recon_master}
- Theme: Recon / enumeration

Flag 2
- Path: /opt/legacy_backup/flag2.txt
- Value: HTB{backup_script_abuse}
- Theme: Script abuse / fictional CVE

Flag 3
- Source: Debug service response on 192.57.164.15:42328
- Value: HTB{DE_AD_B3_3F}
- Theme: Web clue + debug endpoint

User Breadcrumbs

/home/bankadmin/.notes
Purpose:
- points toward /opt/legacy_backup
- hints that hidden docs were moved
- suggests lingering debug artifacts

/home/bankadmin/.bash_history
Purpose:
- acts as a breadcrumb chain
- reveals useful commands and past investigation steps

Backup Utility

/opt/legacy_backup/README
Purpose:
- introduces the utility
- hints that update mode is unsafe
- references debug-era leftovers

/opt/legacy_backup/config.ini
Purpose:
- defines archive and logging behavior
- references update logic
- supports realism

/opt/legacy_backup/backup.sh
Purpose:
- primary exploitation target
- contains fictional unsafe eval behavior

Hidden Secure Docs

/usr/share/.secure_docs/README_hidden
Purpose:
- confirms the directory matters
- hints the PDF contains a passphrase
- points toward image extraction

/usr/share/.secure_docs/bank_passwords.txt
Purpose:
- reinforces that the image passphrase is not guesswork
- directs the player to the PDF

/usr/share/.secure_docs/legal_work.pdf
Purpose:
- contains the passphrase used for image extraction

/usr/share/.secure_docs/flag3_container.jpg
Purpose:
- contains a hidden payload or clue

Web Clues

/srv/http/banksafe/index.html
Purpose:
- static decoy web page
- includes JavaScript clue file

/srv/http/banksafe/static/cookie.js
Purpose:
- plants the endpoint clue in a believable frontend artifact

Debug Service

/etc/systemd/system/rev_debug.service
Purpose:
- systemd service definition for debug server

/opt/legacy_backup/web/debug_server.py
Purpose:
- harmless local HTTP service
- returns final flag

/var/log/rev_debug.log
Purpose:
- reveals port information
- warns that the service should not remain enabled

/etc/app.conf
Purpose:
- additional endpoint breadcrumb
- secondary recovery path if player misses web clue
EOF

cat > "$ROOT_DIR/WALKTHROUGH.md" <<'EOF'
Intended Walkthrough

Step 1 — Enumerate the User Directory

The player should inspect the bankadmin home directory and read:
- /home/bankadmin/flag1.txt
- /home/bankadmin/.notes
- /home/bankadmin/.bash_history

This provides:
- Flag 1
- a path to /opt/legacy_backup
- a hint about hidden docs in /usr/share
- a clue that debug artifacts still exist

Step 2 — Inspect Legacy Backup Utility

The player moves into /opt/legacy_backup/ and examines:
- README
- config.ini
- backup.sh

The intended lesson is to identify unsafe scripting, especially the use of eval in update handling.

This leads to:
- Flag 2
- understanding of fictional CVE-2026-1337

Step 3 — Discover Hidden Documentation

The player follows breadcrumbs to:
- /usr/share/.secure_docs/

Inside are:
- bank_passwords.txt
- README_hidden
- legal_work.pdf
- flag3_container.jpg

The PDF contains the passphrase for the JPG stego container.

Step 4 — Inspect Web and Service Clues

The player may also inspect:
- /srv/http/banksafe/static/cookie.js
- /etc/app.conf
- /var/log/rev_debug.log
- /etc/systemd/system/rev_debug.service

These reveal the endpoint:
- 192.57.164.15:42328

Step 5 — Retrieve Final Flag

The player runs:
curl 192.57.164.15:42328

Expected output:
HTB{DE_AD_B3_3F}
EOF

cat > "$ROOT_DIR/REVIEWER_NOTES.md" <<'EOF'
Reviewer Notes

Safety Summary

All “malicious” behavior in this challenge is simulated and self-contained.

- No real malware is used
- No persistence mechanism beyond challenge artifacts
- No outbound command-and-control behavior
- No destructive payloads
- No credential harvesting
- No lateral movement
- No privilege escalation beyond challenge fiction

Fictional Vulnerability

The challenge references:

CVE-2026-1337 — Insecure Update Handler in LegacyBackup

This is:
- fictional
- challenge-scoped
- intentionally simplified
- not a real-world exploit implementation

Its purpose is educational:
- unsafe shell scripting
- untrusted input handling
- eval misuse

Service Notes

The debug server:
- is harmless
- returns a static string only
- listens on a fixed local port
- does not execute user commands

Stego Notes

The image artifact contains a benign hidden payload used as a clue chain element. It may contain:
- a harmless URL
- a reminder string
- or an endpoint clue

No harmful embedded content is required.

Red Herrings

/usr/local/bin/rev_backdoor is intentionally fake and non-functional.

Its purpose is to:
- increase realism
- introduce noise
- avoid becoming a real exploit vector

Offline Compatibility

The challenge is designed to work fully offline. If external links are used inside flavor content, they should not be required to solve the challenge.

Difficulty Positioning

Suggested difficulty: Medium

Why:
- requires Linux enumeration
- uses breadcrumb chaining
- includes script analysis
- includes hidden content discovery
- includes service interaction
- does not require advanced exploitation or brute force
EOF

cat > "$ROOT_DIR/DEPLOYMENT.md" <<'EOF'
Deployment Notes

Goal

Deploy a Linux VM that resembles a realistic audit target while including all challenge-specific artifacts.

Required Challenge Paths

- /home/bankadmin/
- /opt/legacy_backup/
- /opt/legacy_backup/web/
- /usr/share/.secure_docs/
- /srv/http/banksafe/static/
- /etc/systemd/system/
- /var/log/

Required Files

User Artifacts
- /home/bankadmin/flag1.txt
- /home/bankadmin/.notes
- /home/bankadmin/.bash_history

Backup Artifacts
- /opt/legacy_backup/backup.sh
- /opt/legacy_backup/config.ini
- /opt/legacy_backup/flag2.txt
- /opt/legacy_backup/README

Web / Debug Artifacts
- /opt/legacy_backup/web/debug_server.py
- /srv/http/banksafe/index.html
- /srv/http/banksafe/static/cookie.js
- /etc/systemd/system/rev_debug.service
- /var/log/rev_debug.log
- /etc/app.conf

Hidden Docs
- /usr/share/.secure_docs/bank_passwords.txt
- /usr/share/.secure_docs/README_hidden
- /usr/share/.secure_docs/legal_work.pdf
- /usr/share/.secure_docs/flag3_container.jpg

Permissions Recommendations

chmod +x /opt/legacy_backup/backup.sh
chmod +x /opt/legacy_backup/web/debug_server.py
chmod +x /usr/local/bin/rev_backdoor

Debug Service

Recommended service file:
- /etc/systemd/system/rev_debug.service

Suggested enable/start sequence:
systemctl daemon-reload
systemctl enable rev_debug.service
systemctl start rev_debug.service

Validation Checklist

- [ ] Flag 1 readable in /home/bankadmin/flag1.txt
- [ ] .notes and .bash_history readable
- [ ] backup.sh readable and executable
- [ ] Flag 2 present at /opt/legacy_backup/flag2.txt
- [ ] hidden docs directory exists
- [ ] PDF contains passphrase clue
- [ ] JPG contains hidden clue payload
- [ ] cookie.js includes endpoint clue
- [ ] app.conf includes endpoint clue
- [ ] rev_debug.log references port 42328
- [ ] debug service returns HTB{DE_AD_B3_3F}
EOF

cat > "$ROOT_DIR/challenge/rootfs/etc/app.conf" <<'EOF'
debug_endpoint=192.57.164.15:42328
EOF

mkdir -p "$ROOT_DIR/challenge/rootfs/etc/systemd/system"
cat > "$ROOT_DIR/challenge/rootfs/etc/systemd/system/rev_debug.service" <<'EOF'
[Unit]
Description=Legacy Debug Review Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 /opt/legacy_backup/web/debug_server.py
Restart=always
User=root
WorkingDirectory=/opt/legacy_backup/web

[Install]
WantedBy=multi-user.target
EOF

mkdir -p "$ROOT_DIR/challenge/rootfs/home/bankadmin"
cat > "$ROOT_DIR/challenge/rootfs/home/bankadmin/flag1.txt" <<'EOF'
HTB{initial_recon_master}
EOF

cat > "$ROOT_DIR/challenge/rootfs/home/bankadmin/.notes" <<'EOF'
[bankadmin personal notes]

- legacy backup still runs from /opt/legacy_backup/
- remember to stop checking only visible folders...
- hidden docs were moved under /usr/share during the audit
- web team left some weird debug junk lying around again
- if backup breaks, review config.ini and the update mode
EOF

cat > "$ROOT_DIR/challenge/rootfs/home/bankadmin/.bash_history" <<'EOF'
cd /opt/legacy_backup
cat README
nano backup.sh
bash backup.sh
grep -R "debug" /etc 2>/dev/null
find /usr/share -type d 2>/dev/null
ls -la /usr/share/.secure_docs
strings /usr/share/.secure_docs/flag3_container.jpg | less
curl 192.57.164.15:42328
EOF

mkdir -p "$ROOT_DIR/challenge/rootfs/opt/legacy_backup/web"
cat > "$ROOT_DIR/challenge/rootfs/opt/legacy_backup/README" <<'EOF'
LegacyBackup Utility

Internal archival helper used during migration audits.

Notes:
- Reads runtime settings from config.ini
- Supports archive, verify, and update modes
- Update mode was added quickly during an emergency maintenance cycle
- Debugging support may still be enabled in older builds
- Do not expose this tool to untrusted input

TODO:
- Replace eval-based parser
- Sanitize user-controlled values before execution
- Remove legacy debug hooks before production rollout
EOF

cat > "$ROOT_DIR/challenge/rootfs/opt/legacy_backup/config.ini" <<'EOF'
[general]
mode=archive
backup_dir=/mnt/backup
log_file=/var/log/rev_debug.log

[update]
enabled=true
target=monthly_audit.tar.gz
handler=legacy

[debug]
verbose=true
note=debug endpoint moved during migration
EOF

cat > "$ROOT_DIR/challenge/rootfs/opt/legacy_backup/flag2.txt" <<'EOF'
HTB{backup_script_abuse}
EOF

cat > "$ROOT_DIR/challenge/rootfs/opt/legacy_backup/backup.sh" <<'EOF'
#!/bin/bash

CONFIG="./config.ini"
MODE="${1:-archive}"

if [[ ! -f "$CONFIG" ]]; then
    echo "[!] Missing config.ini"
    exit 1
fi

get_config() {
    section="$1"
    key="$2"
    awk -F '=' -v section="$section" -v key="$key" '
        $0 ~ "\\\["section"\\\\]" { in_section=1; next }
        /^\[/ { in_section=0 }
        in_section && $1 == key { print $2 }
    ' "$CONFIG" | tr -d " "
}

backup_dir="$(get_config general backup_dir)"
log_file="$(get_config general log_file)"
update_enabled="$(get_config update enabled)"
target="$(get_config update target)"
handler="$(get_config update handler)"

echo "[*] Running mode: $MODE" >> "$log_file"

case "$MODE" in
    archive)
        echo "[*] Archiving data to $backup_dir/$target"
        ;;
    verify)
        echo "[*] Verifying backup integrity"
        ;;
    update)
        if [[ "$update_enabled" != "true" ]]; then
            echo "[!] Update mode disabled"
            exit 1
        fi

        echo "[*] Running legacy update handler"
        eval "echo Updating $target with handler $handler"
        ;;
    *)
        echo "Usage: $0 [archive|verify|update]"
        exit 1
        ;;
esac
EOF
chmod +x "$ROOT_DIR/challenge/rootfs/opt/legacy_backup/backup.sh"

cat > "$ROOT_DIR/challenge/rootfs/opt/legacy_backup/web/debug_server.py" <<'EOF'
#!/usr/bin/env python3
from http.server import BaseHTTPRequestHandler, HTTPServer

FLAG = "HTB{DE_AD_B3_3F}"

class DebugHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(FLAG.encode())

    def log_message(self, format, *args):
        return

if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", 42328), DebugHandler)
    print("[*] Debug server listening on 42328")
    server.serve_forever()
EOF
chmod +x "$ROOT_DIR/challenge/rootfs/opt/legacy_backup/web/debug_server.py"

cat > "$ROOT_DIR/challenge/rootfs/opt/legacy_backup/web/index.html" <<'EOF'
Legacy Backup Debug

Legacy Backup Debug Page
This internal page is deprecated and should not be exposed.
EOF

mkdir -p "$ROOT_DIR/challenge/rootfs/srv/http/banksafe/static"
cat > "$ROOT_DIR/challenge/rootfs/srv/http/banksafe/index.html" <<'EOF'
BankSafe Legacy Audit Portal

BankSafe Audit Portal
Legacy migration notice: some review components remain under maintenance.
Please contact internal audit for access to archived documents.
EOF

cat > "$ROOT_DIR/challenge/rootfs/srv/http/banksafe/static/cookie.js" <<'EOF'
document.cookie = "legacy_audit=disabled; path=/; SameSite=Lax";

// TODO remove before release
// backup reviewer endpoint: 192.57.164.15:42328
EOF

mkdir -p "$ROOT_DIR/challenge/rootfs/usr/local/bin"
cat > "$ROOT_DIR/challenge/rootfs/usr/local/bin/rev_backdoor" <<'EOF'
#!/bin/bash
echo "rev_backdoor: failed to initialize legacy socket"
echo "note: this binary was deprecated during migration"
exit 1
EOF
chmod +x "$ROOT_DIR/challenge/rootfs/usr/local/bin/rev_backdoor"

mkdir -p "$ROOT_DIR/challenge/rootfs/usr/share/.secure_docs"
cat > "$ROOT_DIR/challenge/rootfs/usr/share/.secure_docs/README_hidden" <<'EOF'
Secure Docs Archive

These files were moved out of the user home directory during the compliance review.

Contents may include:
- password recovery references
- legal retention paperwork
- image evidence from internal audits

Reminder:
One of the documents contains the passphrase needed for image review.
Do not store credentials in plain text.
EOF

cat > "$ROOT_DIR/challenge/rootfs/usr/share/.secure_docs/bank_passwords.txt" <<'EOF'
Recovered Credential Fragments

archiver_old : B4nkArchive!2024
legal_retention : vault-review-pending
audit_image_passphrase : see legal_work.pdf

notes:
- never reuse review passwords across media exports
- stego container was generated for legal hold verification
EOF

cat > "$ROOT_DIR/challenge/rootfs/usr/share/.secure_docs/legal_work.pdf" <<'EOF'
PLACEHOLDER PDF CONTENT
Replace this file with an actual PDF containing:

Legal Hold Review Notes

Internal evidence image archived for review.
Export passphrase reference: R1ckR0ll-LegalHold
Do not expose supporting materials to public web root.
EOF

cat > "$ROOT_DIR/challenge/rootfs/usr/share/.secure_docs/flag3_container.jpg" <<'EOF'
PLACEHOLDER JPG CONTENT
Replace this file with a real JPG containing hidden payload:

Debug reminder:
Service still responds on 192.57.164.15:42328
EOF

cat > "$ROOT_DIR/challenge/rootfs/var/log/rev_debug.log" <<'EOF'
[2026-01-06 08:12:11] archive run completed
[2026-01-06 08:13:42] verify run completed
[2026-01-06 08:15:02] debug listener check passed on 42328
[2026-01-06 08:15:03] endpoint migrated from web hint to direct listener
[2026-01-06 08:15:04] do not leave this enabled in production
EOF

cat > "$ROOT_DIR/challenge/source_material/legal_work_source.txt" <<'EOF'
Legal Hold Review Notes

Internal evidence image archived for review.
Export passphrase reference: R1ckR0ll-LegalHold
Do not expose supporting materials to public web root.
EOF

cat > "$ROOT_DIR/challenge/source_material/flag3_container_payload.txt" <<'EOF'
Debug reminder:
Service still responds on 192.57.164.15:42328
EOF

cat > "$ROOT_DIR/challenge/source_material/binary_artifact_notes.md" <<'EOF'
Binary Artifact Notes

This folder contains source text for challenge artifacts that should exist as binary files in the live VM.

1) legal_work.pdf
2) flag3_container.jpg
EOF

cat > "$ROOT_DIR/challenge/source_material/image_banner_notes.md" <<'EOF'
Challenge Banner Notes

Recommended local filename:
- images/banksafe-banner.png
EOF

mkdir -p "$ROOT_DIR/images"
cat > "$ROOT_DIR/images/README.md" <<'EOF'
Images

This directory is intended for self-hosted visual assets used by the repository.

Recommended contents:
- banksafe-banner.png — main challenge artwork / banner
EOF

mkdir -p "$ROOT_DIR/challenge/rootfs/etc" "$ROOT_DIR/challenge/rootfs/home/bankadmin" "$ROOT_DIR/challenge/rootfs/var/log" "$ROOT_DIR/challenge/rootfs/root"

cat > "$ROOT_DIR/challenge/rootfs/etc/os-release" <<'EOF'
NAME="Parrot GNU/Linux"
PRETTY_NAME="Parrot GNU/Linux 7.3"
ID=parrot
ID_LIKE=debian
HOME_URL="https://www.parrotsec.org/"
SUPPORT_URL="https://www.parrotsec.org/docs/"
BUG_REPORT_URL="https://www.parrotsec.org/community/"
VERSION_ID="7.3"
EOF

cat > "$ROOT_DIR/challenge/rootfs/etc/hostname" <<'EOF'
banksafe-audit
EOF

cat > "$ROOT_DIR/challenge/rootfs/etc/hosts" <<'EOF'
127.0.0.1   localhost
127.0.1.1   banksafe-audit
::1         localhost ip6-localhost ip6-loopback
EOF

cat > "$ROOT_DIR/challenge/rootfs/etc/fstab" <<'EOF'
# <file system> <mount point> <type> <options> <dump> <pass>
UUID=00000000-0000-0000-0000-000000000001 / ext4 defaults 0 1
UUID=00000000-0000-0000-0000-000000000002 /home ext4 defaults 0 2
tmpfs /tmp tmpfs defaults,nodev,nosuid 0 0
EOF

cat > "$ROOT_DIR/challenge/rootfs/etc/issue" <<'EOF'
Parrot GNU/Linux 7.3 \n \l
EOF

cat > "$ROOT_DIR/challenge/rootfs/etc/motd" <<'EOF'
Welcome to BankSafe audit host.
Authorized use only.
EOF

cat > "$ROOT_DIR/challenge/rootfs/etc/timezone" <<'EOF'
America/New_York
EOF

cat > "$ROOT_DIR/challenge/rootfs/etc/resolv.conf" <<'EOF'
nameserver 1.1.1.1
nameserver 8.8.8.8
EOF

cat > "$ROOT_DIR/challenge/rootfs/etc/passwd" <<'EOF'
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bankadmin:x:1000:1000:Bank Admin:/home/bankadmin:/bin/bash
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
EOF

cat > "$ROOT_DIR/challenge/rootfs/etc/group" <<'EOF'
root:x:0:
daemon:x:1:
bankadmin:x:1000:
www-data:x:33:
systemd-journal:x:190:
EOF

cat > "$ROOT_DIR/challenge/rootfs/var/log/syslog" <<'EOF'
Jan  6 08:12:11 banksafe systemd[1]: Started Legacy Debug Review Service.
Jan  6 08:15:02 banksafe debug_server.py[2143]: listening on 42328
Jan  6 08:15:04 banksafe systemd[1]: Warning: debug listener should not remain enabled in production.
EOF

cat > "$ROOT_DIR/challenge/rootfs/var/log/auth.log" <<'EOF'
Jan  6 08:02:19 banksafe sudo:   bankadmin : TTY=pts/0 ; PWD=/home/bankadmin ; USER=root ; COMMAND=/bin/ls /usr/share/.secure_docs
Jan  6 08:03:42 banksafe sudo:   bankadmin : TTY=pts/0 ; PWD=/home/bankadmin ; USER=root ; COMMAND=/bin/cat /opt/legacy_backup/README
EOF

cat > "$ROOT_DIR/challenge/rootfs/var/log/dpkg.log" <<'EOF'
2026-01-06 08:00:01 install parrot-tools 7.3
2026-01-06 08:00:04 install python3 3.13.1
EOF

cat > "$ROOT_DIR/challenge/rootfs/home/bankadmin/.profile" <<'EOF'
export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin"
export EDITOR=nano
EOF

cat > "$ROOT_DIR/challenge/rootfs/home/bankadmin/.bashrc" <<'EOF'
alias ll='ls -la'
alias c='clear'
EOF

cat > "$ROOT_DIR/challenge/rootfs/root/.bashrc" <<'EOF'
PS1='[root@banksafe \W]\$ '
EOF

mkdir -p "$ROOT_DIR/challenge/rootfs/home/bankadmin/Desktop" "$ROOT_DIR/challenge/rootfs/home/bankadmin/Documents" "$ROOT_DIR/challenge/rootfs/home/bankadmin/Downloads"
cat > "$ROOT_DIR/challenge/rootfs/home/bankadmin/Desktop/README.txt" <<'EOF'
Internal audit workstation.
See /opt/legacy_backup and /usr/share/.secure_docs for review artifacts.
EOF

cat > "$ROOT_DIR/challenge/rootfs/home/bankadmin/Documents/README.txt" <<'EOF'
Finance audit notes are stored elsewhere.
EOF

cat > "$ROOT_DIR/challenge/rootfs/home/bankadmin/Downloads/README.txt" <<'EOF'
No user downloads present.
EOF

chmod +x "$ROOT_DIR/challenge/rootfs/opt/legacy_backup/backup.sh" "$ROOT_DIR/challenge/rootfs/opt/legacy_backup/web/debug_server.py" "$ROOT_DIR/challenge/rootfs/usr/local/bin/rev_backdoor"

echo "Repository created at: $ROOT_DIR"
EOF

chmod +x "$ROOT_DIR/setup_repo.sh"
echo "Wrote setup_repo.sh in $ROOT_DIR"
