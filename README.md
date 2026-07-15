# Bank-Safe-Legacy-Audit-HTB-

![Challenge Banner](https://github.com/user-attachments/assets/69b33f98-9167-4578-9c7f-5743b5ca2e26)

---

# Bank‑Safe Legacy Audit  
HTB‑Style Challenge VM

## Badges
<p align="left">
  <img src="https://img.shields.io/badge/Category-Linux%20%2F%20Web%20%2F%20Forensics-blue" />
  <img src="https://img.shields.io/badge/Difficulty-Medium-yellow" />
  <img src="https://img.shields.io/badge/Flags-3-success" />
  <img src="https://img.shields.io/badge/Release-Standalone%20VM-lightgrey" />
  <img src="https://img.shields.io/badge/Author-Frank%20C.%20Francis%20(WKT12.tech)-black" />
  <img src="https://img.shields.io/badge/Edition-HTB%20Release%20Edition-green" />
</p>

---

## Overview

BankSafe – Legacy Audit VM is a standalone Hack‑The‑Box‑style challenge built around a fictional bank’s outdated Linux audit workstation.  
The system contains insecure scripting, misplaced documentation, a harmless steganography trail, and a forgotten debug endpoint.  
Players must enumerate the filesystem, analyze user breadcrumbs, inspect legacy automation, and uncover internal review artifacts to recover all flags.

---

## Challenge Metadata

- **Challenge Name:** BankSafe – Legacy Audit VM  
- **Category:** Linux / Web / Forensics / Scripting  
- **Difficulty:** Medium  
- **Flags:** 3  
- **Author:** Frank C. Francis (WKT12.tech)  
- **Edition:** HTB Release Edition  
- **Release Type:** Standalone Challenge VM  
- **Intended Skill Level:** Intermediate  

---

## Scenario

A routine internal audit becomes a layered investigation.  
A legacy backup utility shows unsafe scripting behavior, compliance documents have been relocated into a hidden directory, and a dormant debug service was never removed from production.

Players will:

- enumerate user‑space artifacts  
- inspect legacy backup tooling  
- discover hidden documentation  
- follow a stego‑related breadcrumb chain  
- inspect frontend assets for passive clues  
- interact with an exposed debug endpoint  

---

## Core Mechanics

- Linux filesystem enumeration  
- Hidden file and directory discovery  
- User breadcrumb analysis  
- Bash script review  
- Fictional local script vulnerability  
- Steganography clue chain  
- Frontend source inspection  
- Service and log analysis  
- Curl‑based endpoint interaction  

---

## Flags

### Flag 1 — Recon
- **Location:** `/home/bankadmin/flag1.txt`  
- **Value:** `HTB{initial_recon_master}`  
- **Method:** Inspect hidden notes and shell history during basic enumeration.

### Flag 2 — Exploitation
- **Location:** `/opt/legacy_backup/flag2.txt`  
- **Value:** `HTB{backup_script_abuse}`  
- **Method:** Abuse fictional `CVE‑2026‑1337` in `backup.sh`.

### Flag 3 — Debug Endpoint
- **Location:** Response from debug service on port `42328`  
- **Value:** `HTB{DE_AD_B3_3F}`  
- **Method:** Discover endpoint clues through artifacts and web hints, then query:

```bash
curl 192.57.164.15:42328


---

Services

Service	Port	Purpose	
Debug Server	42328	Returns final flag	
Web Interface	80/443	Hosts passive clue via fake cookie / JS comment	


---

Fictional CVE — LegacyBackup

CVE‑2026‑1337 — Insecure Update Handler

• Type: Local file read / limited command injection
• Vector: Unsafe eval usage in backup.sh
• Impact: Access to restricted local content
• Severity: Medium
• Note: Fully fictional and intentionally safe for challenge use


---

Learning Objectives

• Perform practical Linux enumeration
• Read breadcrumbs from hidden user files
• Recognize insecure shell scripting patterns
• Understand how unsafe eval can be abused
• Discover hidden files and directories
• Trace multi‑artifact clue chains
• Inspect frontend assets for passive hints
• Use curl to validate and interact with services


---

Rules / Requirements

• No brute force required
• No real malware
• No persistence beyond challenge design
• No outbound command‑and‑control behavior
• Intended to work offline
• All malicious behavior is simulated and safe


---

Repository Contents

• FILESYSTEM.md — documented challenge filesystem layout
• ARTIFACTS.md — important files, clues, flags, and services
• challenge/rootfs/ — source tree for challenge artifacts
• challenge/source_material/ — source text for binary artifacts


---

Notes for Builders

This repository includes source material for the PDF and JPG challenge artifacts.
When packaging into a live VM, replace placeholder/source files with generated binary artifacts matching the intended contents.

The challenge is designed to feel like a realistic audit environment while remaining entirely self‑contained and safe.
The path is primarily linear, but multiple breadcrumbs reinforce each step to reduce player frustration without requiring brute force.

---

HTB Release Edition Notes

This edition follows the HTB challenge style:

• Clean, linear progression with layered clues
• No guesswork or brute forcing
• Realistic audit‑style environment
• Multiple reinforcement breadcrumbs
• Safe, fictional vulnerabilities
• Offline‑friendly VM design
