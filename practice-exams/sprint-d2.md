# Sprint Exam — Domain 2: Threats, Vulnerabilities & Mitigations (22%)

10 hard D2 items: threat actors, social engineering, malware, application/network attacks, and the
2.3 vulnerability catalogue. Single best answer; key below the divider.

**Q1.** Many usernames tried against one host, all with the *same* small set of common passwords. The attack?
A) Brute force  B) Credential stuffing  C) Password spraying  D) Rainbow table

**Q2.** Credential stuffing differs from spraying because it:
A) Uses one password everywhere  B) Reuses username/password pairs leaked from other breaches  C) Targets Kerberos  D) Needs physical access

**Q3.** A finance clerk receives an email — correct invoice thread, but the bank details changed. Attack?
A) Whaling  B) Business email compromise (BEC)  C) Vishing  D) Watering hole

**Q4.** Malware that provides ongoing remote control and hides at/below the OS level:
A) Worm  B) Rootkit (+ RAT for control)  C) Logic bomb  D) PUP

**Q5.** Which is a *fileless* malware indicator?
A) A new `.exe` in `Temp`  B) Encoded PowerShell launched from Office, nothing written to disk  C) A quarantined file  D) A signed driver

**Q6.** A page reflects `?q=<script>…</script>` back unescaped. Vulnerability + best fix?
A) SQLi — prepared statements  B) Reflected XSS — context-aware output encoding + CSP  C) CSRF — tokens  D) SSRF — egress filter

**Q7.** An attacker submits `../../../../etc/passwd` to a download parameter. This is:
A) SSRF  B) Directory/path traversal  C) XXE  D) LDAP injection

**Q8.** A dependency has a known CVE with a public exploit. The MOST relevant prioritisation input?
A) CVSS base only  B) Exploit availability/active exploitation (EPSS, CISA KEV) on top of CVSS  C) Asset colour tag  D) Vendor size

**Q9.** "Race condition / TOCTOU" vulnerabilities arise from:
A) Weak passwords  B) A gap between checking a resource and using it  C) Unsalted hashes  D) Open ports

**Q10.** A legitimate industry forum is compromised to serve an exploit to its visitors. Attack?
A) Spear phishing  B) Watering hole  C) Typosquatting  D) Supply chain (build system)

---
---

## Answer Key — Sprint D2

1. **C** — few passwords, many accounts = spraying (evades lockout).
2. **B** — stuffing replays leaked credential *pairs*.
3. **B** — invoice/bank-detail change on a real thread = BEC (also "invoice fraud").
4. **B** — rootkit for stealth/persistence; a RAT supplies the remote control.
5. **B** — living-off-the-land via encoded PowerShell, no disk artefact.
6. **B** — reflected XSS; encode on output for the context + CSP defence-in-depth.
7. **B** — path traversal to read arbitrary files.
8. **B** — real-world exploitability (EPSS/KEV) sharpens CVSS-only ranking.
9. **B** — TOCTOU is the check-to-use timing gap.
10. **B** — compromising a site the targets *visit* = watering hole.

**Score:** 9–10 mastery · 7–8 solid · ≤6 re-read D2 social engineering + the 2.3 catalogue + applied drills.
