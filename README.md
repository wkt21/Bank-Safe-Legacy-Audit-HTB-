# Bank-Safe-Legacy-Audit-HTB-

![Challenge Banner](https://github.com/user-attachments/assets/69b33f98-9167-4578-9c7f-5743b5ca2e26)

## A Hack The Box-Style Challenge  
**BankSafe – Legacy Audit VM**

A fictional bank’s legacy Linux audit VM contains weak scripting, hidden documentation, a harmless steganography trail, and a forgotten debug endpoint. Players must enumerate the filesystem, inspect user breadcrumbs, analyze insecure automation, and uncover internal review artifacts to recover all flags.

---

## Challenge Metadata

- **Challenge Name:** BankSafe – Legacy Audit VM
- **Category:** Linux / Web / Forensics / Scripting
- **Difficulty:** Medium
- **Flags:** 3
- **Author:** Frank C. Francis (WKT12.tech)
- **Release Type:** Standalone Challenge VM
- **Intended Skill Level:** Intermediate

---

## Scenario

What begins as a standard internal audit quickly becomes a layered investigation. A legacy backup utility appears to contain unsafe scripting behavior, compliance documents have been relocated into a hidden directory, and a dormant debug service was never properly removed from the system.

Players must:
- enumerate user-space artifacts
- inspect legacy backup tooling
- discover hidden documentation
- follow stego-related breadcrumbs
- inspect web-facing assets for clues
- interact with an exposed debug endpoint

---

## Core Mechanics

- Linux filesystem enumeration
- Hidden file discovery
- User breadcrumb analysis
- Bash script review
- Fictional local script vulnerability
- Hidden directory discovery
- Steganography clue chain
- Frontend source inspection
- Service and log analysis
- Curl-based endpoint interaction

---

## Flags

### Flag 1 — Recon
- **Location:** `/home/bankadmin/flag1.txt`
- **Value:** `HTB{initial_recon_master}`
- **Method:** Read hidden notes and shell history during basic enumeration.

### Flag 2 — Exploitation
- **Location:** `/opt/legacy_backup/flag2.txt`
- **Value:** `HTB{backup_script_abuse}`
- **Method:** Abuse fictional `CVE-2026-1337` in `backup.sh`.

### Flag 3 — Debug Endpoint
- **Location:** response from the debug service on port `42328`
- **Value:** `HTB{DE_AD_B3_3F}`
- **Method:** Discover endpoint clues through artifacts and web hints, then run:
  ```bash
  curl 192.57.164.15:423268
--- 

# Services
-ServicePortPurposeDebug Server42328Returns final flagWeb InterfaceFictional CVECVE-2026-1337 — Insecure Update Handler in

# LegacyBackupType: Local file read / limited command injectionVector: Unsafe eval usage in backup.shImpact: Access to restricted local contentSeverity: MediumNote: Fully fictional and intentionally safe for challenge useLearning ObjectivesPerform practical Linux enumerationRead breadcrumbs from hidden user filesRecognize insecure shell scripting patternsUnderstand how unsafe eval can be abusedDiscover hidden files and directoriesTrace multi-artifact clue chainsInspect frontend assets for passive hintsUse curl to validate and interact with servicesNo brute force requiredNo real malwareNo persistence beyond challenge designNo outbound command-and-control behaviorIntended to work offlineAll malicious behavior is simulated and safeRepository 

# ContentsFILESYSTEM.md —documented challenge filesystem layoutARTIFACTS.md — important files, clues, flags, and serviceschallenge/rootfs/ — source tree for challenge 

# artifactschallenge/source_material/ — source text for binary artifactsNotes for BuildersThe repository includes source material for the PDF and JPG challenge artifacts. 

# If you are packaging this into a live VM, you should replace the placeholder/source approach with actual generated binary files matching the intended contents.This challenge is designed to feel like a realistic audit environment while remaining entirely self-contained and safe. The path is primarily linear, but multiple breadcrumbs reinforce each step to reduce player frustration without requiring brute force.
+## Services
+
+| Service | Port | Purpose |
+|---|---:|---|
+| Debug Server | 42328 | Returns final flag |
+| Web Interface | 80/443 | Hosts passive clue via fake cookie / JS comment |
+
+## Fictional CVE
+
+CVE-2026-1337 — Insecure Update Handler in LegacyBackup
+
+- Type: Local file read / limited command injection
+- Vector: Unsafe `eval` usage in `backup.sh`
+- Impact: Access to restricted local content
+- Severity: Medium
+- Note: Fully fictional and intentionally safe for challenge use
+
+## Learning Objectives
+
+- Perform practical Linux enumeration.
+- Read breadcrumbs from hidden user files.
+- Recognize insecure shell scripting patterns.
+- Understand how unsafe `eval` can be abused.
+- Discover hidden files and directories.
+- Trace multi-artifact clue chains.
+- Inspect frontend assets for passive hints.
+- Use `curl` to validate and interact with services.
+
+## Rules / Requirements
+
+- No brute force required.
+- No real malware.
+- No persistence beyond challenge design.
+- No outbound command-and-control behavior.
+- Intended to work offline.
+- All malicious behavior is simulated and safe.
+
+## Repository Contents
+
+- `FILESYSTEM.md` — documented challenge filesystem layout.
+- `ARTIFACTS.md` — important files, clues, flags, and services.
+- `challenge/rootfs/` — source tree for challenge artifacts.
+- `challenge/source_material/` — source text for binary artifacts.
+
+## Notes for Builders
+
+The repository includes source material for the PDF and JPG challenge artifacts. If you are packaging this into a live VM, replace the placeholder/source approach with actual generated binary files matching the intended contents.
+
+This challenge is designed to feel like a realistic audit environment while remaining entirely self-contained and safe. The path is primarily linear, but multiple breadcrumbs reinforce each step to reduce player frustration without requiring brute force.
*** Add File: challenge/rootfs/etc/os-release
+NAME="Parrot GNU/Linux"
+PRETTY_NAME="Parrot GNU/Linux 7.3"
+ID=parrot
+ID_LIKE=debian
+HOME_URL="https://www.parrotsec.org/"
+SUPPORT_URL="https://www.parrotsec.org/docs/"
+BUG_REPORT_URL="https://www.parrotsec.org/community/"
+VERSION_ID="7.3"
*** Add File: challenge/rootfs/etc/hostname
+banksafe-audit
*** Add File: challenge/rootfs/etc/hosts
+127.0.0.1   localhost
+127.0.1.1   banksafe-audit
+::1         localhost ip6-localhost ip6-loopback
*** Add File: challenge/rootfs/etc/fstab
+# <file system> <mount point> <type> <options> <dump> <pass>
+UUID=00000000-0000-0000-0000-000000000001 / ext4 defaults 0 1
+UUID=00000000-0000-0000-0000-000000000002 /home ext4 defaults 0 2
+tmpfs /tmp tmpfs defaults,nodev,nosuid 0 0
*** Add File: challenge/rootfs/etc/issue
+Parrot GNU/Linux 7.3 \n \l
*** Add File: challenge/rootfs/etc/motd
+Welcome to BankSafe audit host.
+Authorized use only.
*** Add File: challenge/rootfs/etc/timezone
+America/New_York
*** Add File: challenge/rootfs/etc/resolv.conf
+nameserver 1.1.1.1
+nameserver 8.8.8.8
*** Add File: challenge/rootfs/etc/passwd
+root:x:0:0:root:/root:/bin/bash
+daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
+bankadmin:x:1000:1000:Bank Admin:/home/bankadmin:/bin/bash
+www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
*** Add File: challenge/rootfs/etc/group
+root:x:0:
+daemon:x:1:
+bankadmin:x:1000:
+www-data:x:33:
+systemd-journal:x:190:
*** Add File: challenge/rootfs/var/log/syslog
+Jan  6 08:12:11 banksafe systemd[1]: Started Legacy Debug Review Service.
+Jan  6 08:15:02 banksafe debug_server.py[2143]: listening on 42328
+Jan  6 08:15:04 banksafe systemd[1]: Warning: debug listener should not remain enabled in production.
*** Add File: challenge/rootfs/var/log/auth.log
+Jan  6 08:02:19 banksafe sudo:   bankadmin : TTY=pts/0 ; PWD=/home/bankadmin ; USER=root ; COMMAND=/bin/ls /usr/share/.secure_docs
+Jan  6 08:03:42 banksafe sudo:   bankadmin : TTY=pts/0 ; PWD=/home/bankadmin ; USER=root ; COMMAND=/bin/cat /opt/legacy_backup/README
*** Add File: challenge/rootfs/var/log/dpkg.log
+2026-01-06 08:00:01 install parrot-tools 7.3
+2026-01-06 08:00:04 install python3 3.13.1
*** Add File: challenge/rootfs/home/bankadmin/.profile
+export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin"
+export EDITOR=nano
*** Add File: challenge/rootfs/home/bankadmin/.bashrc
+alias ll='ls -la'
+alias c='clear'
*** Add File: challenge/rootfs/root/.bashrc
+PS1='[root@banksafe \W]\\$ '
*** Add File: challenge/rootfs/home/bankadmin/Desktop/README.txt
+Internal audit workstation.
+See /opt/legacy_backup and /usr/share/.secure_docs for review artifacts.
*** Add File: challenge/rootfs/home/bankadmin/Documents/README.txt
+Finance audit notes are stored elsewhere.
*** Add File: challenge/rootfs/home/bankadmin/Downloads/README.txt
+No user downloads present.
*** End Patch
