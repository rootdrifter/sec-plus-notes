# Sprint Exam — Domain 4: Security Operations (28% — highest weight)

10 hard D4 items: IAM, hardening, vuln management, alerting/monitoring, IR, forensics, automation.
This is the biggest domain — drill it hardest. Single best answer; key below the divider.

**Q1.** A `4624` Logon Type **10** from an external IP to a server means:
A) Interactive console logon  B) Successful RDP (RemoteInteractive) logon  C) Service logon  D) Batch job

**Q2.** Following order of volatility, the FIRST thing to capture from a live compromised host is:
A) The disk image  B) Memory (RAM) / volatile state  C) Backup tapes  D) The firewall config

**Q3.** A SIEM rule fires on Event `1102`. Why is this high priority?
A) A user logged in  B) The Windows Security audit log was cleared — classic anti-forensics  C) A patch installed  D) A service started normally

**Q4.** SOAR's main value over manual triage is:
A) Replacing analysts  B) Automating repeatable response (enrich, contain, ticket) to cut MTTR  C) Encrypting logs  D) Scanning for vulns

**Q5.** Authenticated vs unauthenticated vulnerability scan — the authenticated scan:
A) Is louder and less accurate  B) Logs in to assess real patch/config state → fewer false positives  C) Can't see missing patches  D) Only scans web apps

**Q6.** Which email-authentication trio, combined, best prevents spoofing of your domain?
A) TLS + HSTS + DNSSEC  B) SPF + DKIM + DMARC  C) PGP + S/MIME + TLS  D) SPF + CAA + MX

**Q7.** A user reports their account "did things they didn't do" overnight. The MOST useful first data source:
A) CPU temperature  B) Authentication logs (`4624/4625`, geo, times) + session history  C) The marketing site  D) DHCP scope

**Q8.** "Least privilege" is operationally enforced for admins MOST effectively by:
A) Sharing one admin account  B) Just-in-time/privileged access management with approval + logging  C) A longer password  D) Disabling MFA for speed

**Q9.** Allow-listing (application control) is stronger than deny-listing because:
A) It blocks only known-bad  B) It permits only known-good, so novel/unknown binaries are blocked by default  C) It needs no maintenance  D) It is the same thing

**Q10.** During eradication you find a malicious *scheduled task* and a new *service*. These map to which ATT&CK tactic?
A) Initial Access  B) Persistence  C) Exfiltration  D) Impact

---
---

## Answer Key — Sprint D4

1. **B** — Logon Type 10 = RemoteInteractive (RDP). (Type 3 = network, 2 = interactive console.)
2. **B** — RAM first; powering off or imaging disk first destroys volatile evidence.
3. **B** — `1102` = Security log cleared; alert on it directly.
4. **B** — SOAR automates the repeatable parts to reduce MTTR (analysts still decide).
5. **B** — credentialed scans see real patch/config state and cut false positives.
6. **B** — SPF (authorised senders) + DKIM (signature) + DMARC (policy/alignment + reporting).
7. **B** — auth logs reveal impossible travel, off-hours, and brute-force success.
8. **B** — JIT/PAM grants elevated rights temporarily, with approval and audit.
9. **B** — allow-listing denies-by-default, stopping unknown malware.
10. **B** — scheduled tasks + new services are Persistence techniques.

**Score:** 9–10 mastery · 7–8 solid · ≤6 re-read D4 — it's 28% of the exam; prioritise the applied SOC drills.
