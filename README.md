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
  curl 192.57.164.15:42328
