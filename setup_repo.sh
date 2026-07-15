#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="${1:-Bank-Safe-Legacy-Audit-HTB}"
mkdir -p "$ROOT_DIR"

mkdir -p \
  "$ROOT_DIR/build" \
  "$ROOT_DIR/build/chroot" \
  "$ROOT_DIR/build/chroot/etc/systemd/system" \
  "$ROOT_DIR/build/chroot/home/bankadmin/Desktop" \
  "$ROOT_DIR/build/chroot/home/bankadmin/Documents" \
  "$ROOT_DIR/build/chroot/home/bankadmin/Downloads" \
  "$ROOT_DIR/build/chroot/opt/legacy_backup/web" \
  "$ROOT_DIR/build/chroot/srv/http/banksafe/static" \
  "$ROOT_DIR/build/chroot/usr/local/bin" \
  "$ROOT_DIR/build/chroot/usr/share/.secure_docs" \
  "$ROOT_DIR/build/chroot/var/log" \
  "$ROOT_DIR/build/staging" \
  "$ROOT_DIR/build/staging/rootfs" \
  "$ROOT_DIR/build/staging/rootfs/etc/systemd/system" \
  "$ROOT_DIR/build/staging/rootfs/home/bankadmin/Desktop" \
  "$ROOT_DIR/build/staging/rootfs/home/bankadmin/Documents" \
  "$ROOT_DIR/build/staging/rootfs/home/bankadmin/Downloads" \
  "$ROOT_DIR/build/staging/rootfs/opt/legacy_backup/web" \
  "$ROOT_DIR/build/staging/rootfs/srv/http/banksafe/static" \
  "$ROOT_DIR/build/staging/rootfs/usr/local/bin" \
  "$ROOT_DIR/build/staging/rootfs/usr/share/.secure_docs" \
  "$ROOT_DIR/build/staging/rootfs/var/log"

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
├── boot/
├── dev/
├── etc/
├── home/
├── lib/
├── media/
├── mnt/
├── opt/
├── proc/
├── root/
├── run/
├── sbin/
├── srv/
├── sys/
├── tmp/
├── usr/
└── var/
EOF

cat > "$ROOT_DIR/ARTIFACTS.md" <<'EOF'
Challenge Artifacts

This document lists all primary challenge artifacts, flags, clues, and service-related files.
EOF

cat > "$ROOT_DIR/WALKTHROUGH.md" <<'EOF'
Intended Walkthrough

Step 1 — Enumerate the User Directory
Step 2 — Inspect Legacy Backup Utility
Step 3 — Discover Hidden Documentation
Step 4 — Inspect Web and Service Clues
Step 5 — Retrieve Final Flag
EOF

cat > "$ROOT_DIR/REVIEWER_NOTES.md" <<'EOF'
Reviewer Notes

All malicious behavior is simulated and self-contained.
EOF

cat > "$ROOT_DIR/DEPLOYMENT.md" <<'EOF'
Deployment Notes

Deploy a Linux VM that resembles a realistic audit target while including all challenge-specific artifacts.
EOF

cat > "$ROOT_DIR/build/README.md" <<'EOF'
Build directory

This folder contains VM staging material and generated filesystem trees.
EOF

cat > "$ROOT_DIR/build/tree_manifest.txt" <<'EOF'
build/
├── chroot/
│   ├── etc/systemd/system/
│   ├── home/bankadmin/Desktop/
│   ├── home/bankadmin/Documents/
│   ├── home/bankadmin/Downloads/
│   ├── opt/legacy_backup/web/
│   ├── srv/http/banksafe/static/
│   ├── usr/local/bin/
│   ├── usr/share/.secure_docs/
│   └── var/log/
└── staging/
    └── rootfs/
        ├── etc/systemd/system/
        ├── home/bankadmin/Desktop/
        ├── home/bankadmin/Documents/
        ├── home/bankadmin/Downloads/
        ├── opt/legacy_backup/web/
        ├── srv/http/banksafe/static/
        ├── usr/local/bin/
        ├── usr/share/.secure_docs/
        └── var/log/
EOF

copy_files() {
  local dst="$1"
  mkdir -p "$dst/etc/systemd/system" "$dst/home/bankadmin/Desktop" "$dst/home/bankadmin/Documents" "$dst/home/bankadmin/Downloads" \
           "$dst/opt/legacy_backup/web" "$dst/srv/http/banksafe/static" "$dst/usr/local/bin" "$dst/usr/share/.secure_docs" "$dst/var/log"

  cat > "$dst/etc/app.conf" <<'EOF'
debug_endpoint=192.57.164.15:42328
EOF

  cat > "$dst/etc/systemd/system/rev_debug.service" <<'EOF'
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

  cat > "$dst/home/bankadmin/flag1.txt" <<'EOF'
HTB{initial_recon_master}
EOF

  cat > "$dst/home/bankadmin/.notes" <<'EOF'
[bankadmin personal notes]

- legacy backup still runs from /opt/legacy_backup/
- remember to stop checking only visible folders...
- hidden docs were moved under /usr/share during the audit
- web team left some weird debug junk lying around again
- if backup breaks, review config.ini and the update mode
EOF

  cat > "$dst/home/bankadmin/.bash_history" <<'EOF'
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

  cat > "$dst/home/bankadmin/.profile" <<'EOF'
export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin"
export EDITOR=nano
EOF

  cat > "$dst/home/bankadmin/.bashrc" <<'EOF'
alias ll='ls -la'
alias c='clear'
EOF

  cat > "$dst/home/bankadmin/Desktop/README.txt" <<'EOF'
Internal audit workstation.
See /opt/legacy_backup and /usr/share/.secure_docs for review artifacts.
EOF

  cat > "$dst/home/bankadmin/Documents/README.txt" <<'EOF'
Finance audit notes are stored elsewhere.
EOF

  cat > "$dst/home/bankadmin/Downloads/README.txt" <<'EOF'
No user downloads present.
EOF

  cat > "$dst/opt/legacy_backup/README" <<'EOF'
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

  cat > "$dst/opt/legacy_backup/config.ini" <<'EOF'
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

  cat > "$dst/opt/legacy_backup/flag2.txt" <<'EOF'
HTB{backup_script_abuse}
EOF

  cat > "$dst/opt/legacy_backup/backup.sh" <<'EOF'
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
  chmod +x "$dst/opt/legacy_backup/backup.sh"

  cat > "$dst/opt/legacy_backup/web/debug_server.py" <<'EOF'
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
  chmod +x "$dst/opt/legacy_backup/web/debug_server.py"

  cat > "$dst/opt/legacy_backup/web/index.html" <<'EOF'
Legacy Backup Debug

Legacy Backup Debug Page
This internal page is deprecated and should not be exposed.
EOF

  cat > "$dst/srv/http/banksafe/index.html" <<'EOF'
BankSafe Legacy Audit Portal

BankSafe Audit Portal
Legacy migration notice: some review components remain under maintenance.
Please contact internal audit for access to archived documents.
EOF

  cat > "$dst/srv/http/banksafe/static/cookie.js" <<'EOF'
document.cookie = "legacy_audit=disabled; path=/; SameSite=Lax";

// TODO remove before release
// backup reviewer endpoint: 192.57.164.15:42328
EOF

  cat > "$dst/usr/local/bin/rev_backdoor" <<'EOF'
#!/bin/bash
echo "rev_backdoor: failed to initialize legacy socket"
echo "note: this binary was deprecated during migration"
exit 1
EOF
  chmod +x "$dst/usr/local/bin/rev_backdoor"

  cat > "$dst/usr/share/.secure_docs/README_hidden" <<'EOF'
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

  cat > "$dst/usr/share/.secure_docs/bank_passwords.txt" <<'EOF'
Recovered Credential Fragments

archiver_old : B4nkArchive!2024
legal_retention : vault-review-pending
audit_image_passphrase : see legal_work.pdf

notes:
- never reuse review passwords across media exports
- stego container was generated for legal hold verification
EOF

  cat > "$dst/usr/share/.secure_docs/legal_work.pdf" <<'EOF'
PLACEHOLDER PDF CONTENT
Replace this file with an actual PDF containing:

Legal Hold Review Notes

Internal evidence image archived for review.
Export passphrase reference: R1ckR0ll-LegalHold
Do not expose supporting materials to public web root.
EOF

  cat > "$dst/usr/share/.secure_docs/flag3_container.jpg" <<'EOF'
PLACEHOLDER JPG CONTENT
Replace this file with a real JPG containing hidden payload:

Debug reminder:
Service still responds on 192.57.164.15:42328
EOF

  cat > "$dst/var/log/rev_debug.log" <<'EOF'
[2026-01-06 08:12:11] archive run completed
[2026-01-06 08:13:42] verify run completed
[2026-01-06 08:15:02] debug listener check passed on 42328
[2026-01-06 08:15:03] endpoint migrated from web hint to direct listener
[2026-01-06 08:15:04] do not leave this enabled in production
EOF

  cat > "$dst/etc/os-release" <<'EOF'
NAME="Parrot GNU/Linux"
PRETTY_NAME="Parrot GNU/Linux 7.3"
ID=parrot
ID_LIKE=debian
HOME_URL="https://www.parrotsec.org/"
SUPPORT_URL="https://www.parrotsec.org/docs/"
BUG_REPORT_URL="https://www.parrotsec.org/community/"
VERSION_ID="7.3"
EOF

  cat > "$dst/etc/hostname" <<'EOF'
banksafe-audit
EOF

  cat > "$dst/etc/hosts" <<'EOF'
127.0.0.1   localhost
127.0.1.1   banksafe-audit
::1         localhost ip6-localhost ip6-loopback
EOF

  cat > "$dst/etc/fstab" <<'EOF'
# <file system> <mount point> <type> <options> <dump> <pass>
UUID=00000000-0000-0000-0000-000000000001 / ext4 defaults 0 1
UUID=00000000-0000-0000-0000-000000000002 /home ext4 defaults 0 2
tmpfs /tmp tmpfs defaults,nodev,nosuid 0 0
EOF

  cat > "$dst/etc/issue" <<'EOF'
Parrot GNU/Linux 7.3 \n \l
EOF

  cat > "$dst/etc/motd" <<'EOF'
Welcome to BankSafe audit host.
Authorized use only.
EOF

  cat > "$dst/etc/timezone" <<'EOF'
America/New_York
EOF

  cat > "$dst/etc/resolv.conf" <<'EOF'
nameserver 1.1.1.1
nameserver 8.8.8.8
EOF

  cat > "$dst/etc/passwd" <<'EOF'
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bankadmin:x:1000:1000:Bank Admin:/home/bankadmin:/bin/bash
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
EOF

  cat > "$dst/etc/group" <<'EOF'
root:x:0:
daemon:x:1:
bankadmin:x:1000:
www-data:x:33:
systemd-journal:x:190:
EOF

  cat > "$dst/var/log/syslog" <<'EOF'
Jan  6 08:12:11 banksafe systemd[1]: Started Legacy Debug Review Service.
Jan  6 08:15:02 banksafe debug_server.py[2143]: listening on 42328
Jan  6 08:15:04 banksafe systemd[1]: Warning: debug listener should not remain enabled in production.
EOF

  cat > "$dst/var/log/auth.log" <<'EOF'
Jan  6 08:02:19 banksafe sudo:   bankadmin : TTY=pts/0 ; PWD=/home/bankadmin ; USER=root ; COMMAND=/bin/ls /usr/share/.secure_docs
Jan  6 08:03:42 banksafe sudo:   bankadmin : TTY=pts/0 ; PWD=/home/bankadmin ; USER=root ; COMMAND=/bin/cat /opt/legacy_backup/README
EOF

  cat > "$dst/var/log/dpkg.log" <<'EOF'
2026-01-06 08:00:01 install parrot-tools 7.3
2026-01-06 08:00:04 install python3 3.13.1
EOF
}

copy_files "$ROOT_DIR/build/chroot"
copy_files "$ROOT_DIR/build/staging/rootfs"

echo "Repository and build folder created at: $ROOT_DIR"
