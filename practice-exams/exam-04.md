# Practice Exam 04 — Adversarial / Maximum Difficulty (SY0-701)

25 questions tuned to the **hardest end** of the SY0-701 difficulty band. Every item is built
around a *documented exam trap* — the distractors are the answers candidates actually pick. Several
deliberately offer a "textbook-sounding" option that is wrong *in context*. If a question feels like
it has two right answers, that is the design: one is right in general, one is right *here*.

Weighting (intentional concentration on the high-weight operational domains): **D1 ×3 · D2 ×6 ·
D3 ×4 · D4 ×7 · D5 ×5.** Target time: 35 minutes (90s/question — harder than blueprint pace on
purpose). Portfolio-anchored items marked ★.

> Answer key + "why candidates get this wrong" follows all 25. Commit to an answer before scrolling.

---

## Questions

**Q1 (D1).** A TLS 1.2 service uses static RSA key exchange. An attacker passively records months of
ciphertext, then later compromises the server's private key. What have they gained, and what control
would have prevented it?
- A. Nothing; RSA key exchange already provides forward secrecy
- B. They can decrypt all recorded past sessions; ECDHE (ephemeral) would have prevented it
- C. They can decrypt only future sessions; certificate pinning would have prevented it
- D. Nothing; the recorded traffic was protected by AES-GCM integrity

**Q2 (D1) ★.** ironveil derives its LUKS2 master key with Argon2id rather than PBKDF2-SHA512 for the
passphrase keyslot. A reviewer asks what property Argon2id adds that raising PBKDF2 iteration count
does *not*. Best answer?
- A. Forward secrecy for the volume key
- B. Memory-hardness — resistance to GPU/ASIC parallel cracking, not just CPU-time cost
- C. Non-repudiation of the unlock
- D. Quantum resistance

**Q3 (D1).** Developers store passwords as `SHA-512(password)` and argue SHA-512 is "stronger than
bcrypt." Why is this wrong, and what is the correct fix?
- A. SHA-512 is broken; switch to SHA-3
- B. Fast hashes are the problem for passwords — use a salted, deliberately-slow KDF (Argon2id/bcrypt)
- C. Add a global salt to the SHA-512 and it is sufficient
- D. Encrypt the SHA-512 output with AES

**Q4 (D2).** A web request `GET /report?doc=../../../../etc/shadow` succeeds in returning file
contents. Which attack class is this, and what is the single best primary defence?
- A. SQL injection; use parameterised queries
- B. Privilege escalation; apply least privilege to the web user
- C. Directory/path traversal; canonicalise and validate the path, reject `..` sequences
- D. Local file inclusion; disable `allow_url_include`

**Q5 (D2) ★.** A signed, legitimate Windows process suddenly makes outbound C2 connections; endpoint
AV (signature-based) shows nothing. The malware was loaded directly into that process's memory.
What is the technique class and why did AV miss it?
- A. Fileless/memory injection; the host process is trusted and no malicious file was written to disk
- B. Rootkit; it patched the kernel
- C. Logic bomb; it triggered on a condition
- D. Worm; it self-propagated

**Q6 (D2).** Users at one company are compromised after visiting a legitimate industry news site that
was seeded with an exploit kit. No email was involved. Which best describes the vector?
- A. Spear phishing
- B. Watering-hole attack
- C. Typosquatting
- D. Supply-chain attack

**Q7 (D2).** An attacker captures a WPA2-Personal 4-way handshake and cracks the passphrase *offline*.
The vendor proposes "force a longer passphrase." What is the most complete fix and why?
- A. Longer passphrase only — it fully closes the vector
- B. Switch to WPA3-SAE — it removes the offline-dictionary vector entirely (each guess needs a live exchange)
- C. Hide the SSID — the handshake can no longer be captured
- D. Enable MAC filtering — only known clients can associate

**Q8 (D2).** Which pair correctly maps the "whose trust is abused" distinction?
- A. XSS abuses the site's trust in the user's browser; CSRF abuses the user's trust in the site
- B. XSS abuses the user's trust in the site; CSRF abuses the site's trust in the user's browser
- C. Both abuse the server's trust in itself
- D. XSS and CSRF abuse the same trust relationship; only the payload differs

**Q9 (D2) ★.** spectre's primary finding was an Apache host returning a full directory listing
(CWE-548). A candidate labels this "directory traversal." Why is that wrong?
- A. It is the same thing; the labels are interchangeable
- B. Indexing exposes a listing the server *offers* by misconfiguration; traversal *escapes* the intended directory via crafted input — different mechanisms
- C. CWE-548 is actually SQL injection
- D. Directory listing is not a finding, only an information leak with no class

**Q10 (D3).** A security-critical inline IPS protects a segment processing regulated data. The vendor
asks how it should behave if the IPS hardware fails. Which configuration matches the requirement, and
what is the trade-off?
- A. Fail-open — preserves availability; accept that traffic flows uninspected during failure
- B. Fail-closed — preserves security; accept that the segment loses connectivity during failure
- C. Fail-open — preserves security
- D. It does not matter; an IPS cannot fail

**Q11 (D3).** You must protect one specific public web application from SQLi/XSS at layer 7, in front
of the app, terminating TLS. Which appliance, and which common wrong answer should you avoid?
- A. A stateful network firewall — it inspects L7 HTTP just as well
- B. A WAF in reverse-proxy position — *not* a network firewall, which judges L3/L4 not app payloads
- C. An IDS in passive mode — it can block the requests
- D. A forward proxy — it filters inbound application traffic

**Q12 (D3).** A SOC must detect C2 beaconing on a 40 Gb core link with minimal storage. Which data
source fits, and which is the trap answer?
- A. Full packet capture (Wireshark) — store everything for later
- B. NetFlow/IPFIX — conversation metadata (who/how-much/when) at scale without payload; pcap is the trap (can't keep up, storage-heavy)
- C. SNMPv2c community polling — it captures payloads
- D. SPAN to a laptop running tcpdump — guaranteed full capture at line rate

**Q13 (D3) ★.** ironveil runs a *full-tunnel* WireGuard config (`wg-CH-FI-2`) with AdGuard Home
upstreaming to Quad9 over DoH. A reviewer claims "DNS still leaks because AdGuard binds `*:53` in
clear." Why is the no-plaintext-egress claim still defensible?
- A. Port 53 plaintext only exists *inside* the host; the egress to Quad9 is DoH (443) inside the full tunnel
- B. AdGuard encrypts port 53 itself
- C. The claim is wrong; DNS does leak
- D. WireGuard blocks all DNS so there is no resolution at all

**Q14 (D4).** During litigation hold, an automated retention job is about to purge mailboxes relevant
to the case. What must happen and what is the term for letting the purge proceed?
- A. Let the retention policy run as normal; that is good governance
- B. The legal hold suspends the retention schedule; letting the purge proceed is spoliation (evidence destruction)
- C. Encrypt the mailboxes instead of preserving them
- D. Degauss the mail server

**Q15 (D4).** A live host must be acquired forensically. Which order is correct and what is collected
first?
- A. Disk image first, then RAM, then CPU cache — disk is most important
- B. Order of volatility: CPU cache/registers → RAM → swap → disk → archival — most volatile first
- C. Archival backups first because they are authoritative
- D. Whatever is fastest to copy, to minimise downtime

**Q16 (D4) ★.** A SOC rule fires 200 times/day; every investigated instance has been benign user
behaviour. What is the classification, the real risk, and the correct action?
- A. True positive; escalate each one
- B. False positive; the risk is alert fatigue masking a real true positive; action is rule tuning (not disabling)
- C. False negative; lower the threshold
- D. True negative; no action

**Q17 (D4).** An email passes SPF but the From-domain alignment fails and the body was altered in
transit. Which mechanism would have caught the *tampering*, and which sets the *policy* when checks
fail?
- A. SPF caught tampering; DKIM sets policy
- B. DKIM's signature detects body tampering; DMARC sets the policy (and alignment) when SPF/DKIM fail
- C. DMARC detects tampering; SPF sets policy
- D. TLS detects tampering; SPF sets policy

**Q18 (D4).** Which statement about IDS vs IPS deployment is correct?
- A. An IDS is inline and drops malicious packets
- B. An IPS is passive and only alerts
- C. An IDS is passive/out-of-band (fed by SPAN/TAP) and alerts; an IPS is inline and can drop
- D. Both must be inline to function

**Q19 (D4) ★.** nullbyte enforces per-profile network policy (RethinkDNS) and verified boot
(Titan M2). Mapped to the enterprise mobile-hardening control set, which MDM concept does
per-profile data separation correspond to, and what is the BYOD-specific reason it matters?
- A. Network segmentation; it isolates VLANs
- B. Containerisation; on BYOD a container wipe removes corporate data without touching personal data
- C. Geofencing; it restricts by location
- D. Full-device remote wipe; it is the only option on BYOD

**Q20 (D4).** "Password + security PIN" is proposed as MFA. Is it, and what is a genuinely
multifactor pairing?
- A. Yes, two secrets is multifactor
- B. No — both are "something you know" (one factor); a genuine pair is password + hardware token (know + have)
- C. Yes, because the PIN is numeric and the password is alphanumeric
- D. No — you need three factors for MFA

**Q21 (D4).** A SIEM's correlation across sources keeps failing because event timestamps disagree by
minutes. What is the root cause control, and why does it also matter for Kerberos?
- A. Log retention; Kerberos needs long retention
- B. NTP time synchronisation; correlation needs a common clock and Kerberos rejects tickets with excessive clock skew
- C. Log archiving; Kerberos archives tickets
- D. Encryption of logs; Kerberos encrypts time

**Q22 (D5).** A firm vets a new SaaS vendor's security posture *before* signing, then maintains
ongoing monitoring and patching of the integration afterward. Name the two governance concepts in
order.
- A. Due care (vetting), then due diligence (ongoing)
- B. Due diligence (vetting/investigation), then due care (ongoing reasonable safeguards)
- C. Both are due diligence
- D. Both are due care

**Q23 (D5).** A researcher reports a flaw privately and gives the vendor 90 days before publishing.
No payment is involved. What is this, and what is the trap distractor?
- A. Bug bounty; because vulnerabilities were reported
- B. Responsible (coordinated) disclosure; "bug bounty" is the trap (a bounty requires a *funded* programme)
- C. Black-hat disclosure; it was published
- D. Full disclosure; the vendor was given time

**Q24 (D5) ★.** spectre was conducted with a standard user account and partial knowledge of the
environment, PTES-structured. Which testing classification is this, and which is wrong?
- A. Known/white-box; the tester had an account
- B. Partially-known/grey-box; full credentials+source would be white-box, zero knowledge would be black-box
- C. Black-box; an account is not "knowledge"
- D. Red team; any pentest with an account is a red team

**Q25 (D5).** A business unit cannot meet a control and wants to skip it "informally." What is the
correct governance instrument, and how does it differ from a compensating control?
- A. Just skip it; risk acceptance is informal
- B. A documented, time-bounded, risk-owner-signed exception/exemption; a compensating control instead *meets the intent* by an alternative control
- C. A compensating control means ignoring the requirement
- D. An exception requires no sign-off if the risk is low

---

## Answer key — with "why candidates get this wrong"

**Q1 — B.** Static RSA key exchange has **no forward secrecy**: the same long-term key protects the
session-key delivery, so a later key compromise unlocks all recorded past traffic. *Why missed:*
candidates assume "strong cipher (AES-GCM) = past traffic safe" — but confidentiality of *recorded*
traffic depends on the *key exchange*, not the bulk cipher. ECDHE discards ephemeral keys → PFS.

**Q2 — B.** Argon2id is **memory-hard**: it forces large RAM use per guess, neutralising the massive
parallelism of GPUs/ASICs that pure CPU-time functions (PBKDF2) don't. *Why missed:* "just raise the
iteration count" feels equivalent — it raises CPU cost but not memory cost, so GPU farms still win.

**Q3 — B.** Passwords need *slowness*, not raw hash strength. SHA-512 is fast → billions of guesses/s.
Use a salted, memory-hard KDF. *Why missed:* "bigger number = stronger" intuition; and a global salt
(C) doesn't give per-user uniqueness against targeted cracking.

**Q4 — C.** Classic directory/path traversal; canonicalise+validate the path. *Why missed:* D names
the *outcome* loosely (LFI is adjacent but the stem is a *read* via `..`), and B names the *impact*
(privilege/escalation) rather than the *attack class* the question asks for. The exam separates
"class" from "impact."

**Q5 — A.** Memory/fileless injection into a trusted signed process; nothing on disk for signatures
to match. *Why missed:* "signed process making C2" tempts "rootkit," but no kernel tampering is
described. EDR behavioural detection is the control, not AV.

**Q6 — B.** Watering hole: compromise a site the *target population* visits. *Why missed:* candidates
reach for "supply-chain" (D) — but no trusted software/update was poisoned; the vector was a *visited
site*.

**Q7 — B.** WPA3-SAE replaces the offline-crackable PSK handshake with a live exchange (each guess
costs a round trip) and adds PFS. *Why missed:* "longer passphrase" only raises cost; SSID hiding and
MAC filtering are trivially bypassed and don't touch the handshake-capture vector.

**Q8 — B.** XSS = user trusts the site (script runs in their browser as that site); CSRF = site trusts
the user's authenticated browser. *Why missed:* the two are routinely inverted under time pressure —
memorise the one-liners.

**Q9 — B.** Indexing (CWE-548) = server *offers* a listing via misconfig; traversal = crafted input
*escapes* the web root. Different mechanisms, different CWEs. *Why missed:* both "expose files," so
they blur — but the exam (and interviews) reward the precise discriminator.

**Q10 — B.** Regulated/security-critical segment → **fail-closed** (preserve confidentiality/integrity,
lose availability). *Why missed:* HA instincts say "fail-open so nothing breaks" — correct for a
business-availability link, wrong when the stem prioritises security. Read what the stem optimises.

**Q11 — B.** WAF in reverse-proxy position; a network firewall (A) judges L3/L4 and won't parse
SQLi/XSS payloads. *Why missed:* "NGFW/firewall does everything" overreach; and an IDS (C) is passive
and cannot block.

**Q12 — B.** NetFlow/IPFIX = scalable metadata, minimal storage. *Why missed:* "to be sure, capture
everything" (A/D) ignores that full pcap can't keep up at 40 Gb and the stem said *minimal storage*.
SNMP polls device health, not payloads.

**Q13 — A.** The only plaintext :53 is host-internal (loopback path into AdGuard); the actual *egress*
is DoH/443 to Quad9, encapsulated in the full WireGuard tunnel. *Why missed:* "binds `*:53` = leaks"
conflates the internal bind with the external egress. (Matches CLAUDE.md §5 ironveil ground truth.)

**Q14 — B.** Legal hold **suspends** retention/deletion; proceeding = spoliation. *Why missed:*
"follow policy" sounds like good governance, but a hold overrides routine deletion — destroying held
evidence has legal consequences.

**Q15 — B.** Order of volatility: most volatile first (cache/registers → RAM → swap → disk →
archival). *Why missed:* "image the disk first" is the instinct, but volatile memory (keys, processes,
network state) is gone on power-down.

**Q16 — B.** False positives → tune the rule. *Why missed:* candidates pick "disable the rule" (not
offered, but C/escalation tempts) — disabling creates a *false-negative* blind spot. Tuning preserves
detection while cutting noise (alert fatigue is the real danger).

**Q17 — B.** DKIM's cryptographic signature detects body tampering; DMARC sets policy + alignment when
SPF/DKIM fail. *Why missed:* SPF (sender IP authorisation) is mistaken for an integrity check — it
proves *who sent*, not *that content is intact*.

**Q18 — C.** IDS passive/out-of-band (SPAN/TAP), alerts only; IPS inline, can drop. *Why missed:* the
I/P letters get swapped; remember **P**revention = inline = can drop.

**Q19 — B.** Containerisation: corporate data lives in a managed container; BYOD container wipe removes
work data without touching personal data (privacy + control balance). *Why missed:* "segmentation"
(A) is network-level; full-device wipe (D) is legally fraught on a personal device.

**Q20 — B.** Both password and PIN are "something you know" → single factor. Genuine MFA crosses
*categories* (know + have + are). *Why missed:* "two secrets" feels like two factors; the exam tests
that factors are *categories*, not *count of credentials*.

**Q21 — B.** NTP gives a common clock for correlation; Kerberos rejects tickets beyond the allowed
clock skew (default ~5 min). *Why missed:* candidates link "time problems" to logging config, missing
that authentication (Kerberos) is also time-sensitive.

**Q22 — B.** Due **diligence** = the investigation *before*; due **care** = ongoing reasonable
safeguards *after*. *Why missed:* the two are constantly inverted — diligence = investi**gate**.

**Q23 — B.** Coordinated/responsible disclosure (time before publish). A *bug bounty* specifically
implies a funded reward programme; absence of payment rules it out. *Why missed:* "reported a vuln" →
"bug bounty" reflex.

**Q24 — B.** Grey-box / partially-known: a standard account + partial knowledge. White-box = full
creds+source; black-box = zero knowledge. *Why missed:* "had an account = white-box" overreads; an
account is *partial* knowledge, not full.

**Q25 — B.** A formal, documented, time-bounded, risk-owner-approved **exception/exemption**; a
**compensating control** instead satisfies the requirement's *intent* via an alternative. *Why
missed:* candidates treat "skip it" and "compensating control" as the same — a compensating control
still *meets the objective another way*; an exception *accepts the gap* with sign-off.

---

### Scoring
- **23–25:** exam-ready on traps; you read context, not keywords.
- **19–22:** solid; re-drill the missed traps in the per-domain quick-reference cards.
- **<19:** the gap is trap-recognition under pressure, not knowledge — review `sy0-701-exam-tips.md`
  "Common trap questions" and re-take. Log misses in `error-log.md`.

> Trap themes concentrated here: forward secrecy vs bulk cipher (Q1), memory-hardness (Q2/Q3),
> class-vs-impact (Q4), trust-direction XSS/CSRF (Q8), indexing-vs-traversal (Q9),
> fail-open/closed by priority (Q10), flow-vs-pcap (Q12), legal hold/spoliation (Q14), order of
> volatility (Q15), FP tuning-not-disabling (Q16), SPF/DKIM/DMARC roles (Q17), factor *categories*
> (Q20), NTP+Kerberos skew (Q21), due-diligence-vs-care (Q22), disclosure-vs-bounty (Q23),
> grey-box classification (Q24), exception-vs-compensating-control (Q25).
