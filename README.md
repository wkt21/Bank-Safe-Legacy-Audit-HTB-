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



---

# Services

ServicePortPurposeDebug Server42328Returns final flagWeb InterfaceFictional CVECVE-2026-1337 — Insecure Update Handler in LegacyBackupType: Local file read / limited command injectionVector: Unsafe eval usage in backup.shImpact: Access to restricted local contentSeverity: MediumNote: Fully fictional and intentionally safe for challenge useLearning ObjectivesPerform practical Linux enumerationRead breadcrumbs from hidden user filesRecognize insecure shell scripting patternsUnderstand how unsafe eval can be abusedDiscover hidden files and directoriesTrace multi-artifact clue chainsInspect frontend assets for passive hintsUse curl to validate and interact with servicesNo brute force requiredNo real malwareNo persistence beyond challenge designNo outbound command-and-control behaviorIntended to work offlineAll malicious behavior is simulated and safeRepository ContentsFILESYSTEM.md — documented challenge filesystem layoutARTIFACTS.md — important files, clues, flags, and serviceschallenge/rootfs/ — source tree for challenge artifactschallenge/source_material/ — source text for binary artifactsNotes for BuildersThe repository includes source material for the PDF and JPG challenge artifacts. If you are packaging this into a live VM, you should replace the placeholder/source approach with actual generated binary files matching the intended contents.This challenge is designed to feel like a realistic audit environment while remaining entirely self-contained and safe. The path is primarily linear, but multiple breadcrumbs reinforce each step to reduce player frustration without requiring brute force.
