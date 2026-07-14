# Bank-Safe-Legacy-Audit-HTB-

<img width="1536" height="1024" alt="IMG_2089" src="https://github.com/user-attachments/assets/69b33f98-9167-4578-9c7f-5743b5ca2e26" />




A Hack The Box Challenge 
BankSafe – Legacy Audit VM

HTB Challenge Submission Metadata

---

🟩 General Information

Challenge Name: BankSafe – Legacy Audit VM
Category: Linux / Web / Forensics / Scripting
Difficulty: Medium
Flags: 3
Author: Frank C. Francis (WKT12.tech)
Release Type: Standalone Challenge VM
Intended Player Skill Level: Intermediate (comfortable with Linux, scripting, basic stego)

---

🟦 Technical Summary

Short Description:
A legacy audit VM from a fictional bank contains a vulnerable backup script (fictional CVE‑2026‑1337), a hidden steganography payload, and a debug endpoint exposed through a non‑working cookie. Players must enumerate the filesystem, exploit the insecure script, uncover hidden directories, extract stego data, and interact with a harmless debug service to retrieve all flags.

Core Mechanics:

• Recon of user directories
• Exploitation of a fictional CVE (unsafe eval in backup.sh)
• Discovery of hidden folder under /usr/share/.secure_docs
• Steganography extraction using password hidden in PDF
• Inspecting dev tools for a fake cookie
• Curling a debug endpoint on port 42328
• No brute forcing required


---

🟧 Flags

Flag 1 – Recon

Location: /home/bankadmin/flag1.txt
Value: HTB{initial_recon_master}
Method: Basic enumeration + reading .notes and .bash_history.

---

Flag 2 – Exploitation

Location: /opt/legacy_backup/flag2.txt
Value: HTB{backup_script_abuse}
Method: Exploit fictional CVE‑2026‑1337 in backup.sh to read restricted file.

---

Flag 3 – Debug Endpoint

Location: Returned by debug server on port 42328
Value: HTB{DE_AD B3_3F}
Method:

• Inspect dev tools → find fake cookie referencing 192.57.164.15:42328
• Run:curl 192.57.164.15:42328

• Server returns final flag.


---

🟥 Filesystem Layout (Challenge Artifacts)

/
├── home/bankadmin/
│   ├── flag1.txt
│   ├── .notes
│   └── .bash_history
├── opt/legacy_backup/
│   ├── backup.sh
│   ├── config.ini
│   ├── flag2.txt
│   └── README
├── usr/share/.secure_docs/
│   ├── bank_passwords.txt
│   ├── legal_work.pdf
│   ├── flag3_container.jpg
│   └── README_hidden
├── etc/systemd/system/rev_debug.service
└── opt/legacy_backup/web/debug_server.py


---

🟪 Services & Ports

Service	Port	Purpose	
Debug Server	42328	Returns final flag via curl	
Web Interface	80/443 (optional)	Hosts fake cookie hint	


---

🟫 Fictional CVE

CVE‑2026‑1337 — Insecure Update Handler in LegacyBackup

Type: Local file read / limited command injection
Vector: Unsafe eval in backup.sh
Impact: Read restricted file (flag2.txt)
Severity: Medium
Notes: Fully fictional, safe, and contained.

---

🟨 Player Learning Objectives

• Linux enumeration
• Reading breadcrumbs in user files
• Understanding insecure scripting patterns
• Exploiting a fictional CVE safely
• Discovering hidden directories
• Steganography extraction
• Inspecting dev tools for clues
• Using curl to interact with debug services


---

🟩 Challenge Requirements

• No brute forcing
• No real malware
• No outbound connections
• All behavior is simulated and safe
• Works fully offline


---

🟦 Reviewer Notes

• All “malicious” behavior is simulated.
• Debug server is harmless and local-only.
• Stego payload contains Rickroll URL for flavor.
• Challenge is linear but multi‑layered (3 steps).
• Difficulty aligns with HTB’s “Medium” category.
