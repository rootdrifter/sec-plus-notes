# SY0-701 Practice Questions (50)

Fifty exam-style practice items across all five domains, **weighted by exam percentage**
(D1 6 · D2 11 · D3 9 · D4 14 · D5 10). Each item gives the answer, a **distractor note** (why the
tempting wrong answers are wrong), and a **portfolio link** where the concept appears in the
rootdrifter portfolio. Original practice items written to drill the domain notes — not real exam
questions. Track misses and route back to the domain file:
[D1](domains/sy0-701-1-general-security-concepts.md) ·
[D2](domains/sy0-701-2-threats-vulnerabilities-mitigations.md) ·
[D3](domains/sy0-701-3-security-architecture.md) ·
[D4](domains/sy0-701-4-security-operations.md) ·
[D5](domains/sy0-701-5-program-management.md).

> For the real exam also practise **performance-based questions (PBQs)** — drag-and-drop and
> configuration tasks this text format can't fully replicate.

---

## Domain 1 — General Security Concepts (6)

**Q1.** A visible, recording CCTV camera provides which two *control functions*?
**A:** Deterrent (discourages) + detective (records for review).
**Distractor note:** "Preventive" is tempting but a camera doesn't *stop* entry; "corrective" fixes
after the fact, which it also doesn't do. Don't confuse control *functions* with control *types*
(technical/managerial/operational/physical).

**Q2.** Which authentication method is phishing-resistant, and why?
**A:** FIDO2 / WebAuthn security key — the credential is cryptographically bound to the site's origin,
so a look-alike phishing domain can't use it.
**Distractor note:** TOTP apps and SMS codes feel "MFA-strong" but are relayable by a real-time
adversary-in-the-middle phishing kit.
**Portfolio link:** [ironveil](../../ironveil) — Nitrokey 3A NFC FIDO2 hardware key.

**Q3.** In Zero Trust, which component *decides* access and which *enforces* it at the resource?
**A:** The Policy Decision Point (PDP — Policy Engine + Policy Administrator) decides; the Policy
Enforcement Point (PEP) enforces.
**Distractor note:** People invert PDP/PEP, or assume a single device does both — the split is the point.

**Q4.** Hashing provides which security property, and which does it NOT provide?
**A:** Integrity (tamper-evidence); it does NOT provide confidentiality (a hash isn't encryption).
**Distractor note:** "Hashing protects the password's confidentiality" is the classic trap — hashing +
salting protects *stored* passwords from reversal, but a hash is one-way, not encryption.
**Portfolio link:** [spectre](../../spectre) — SHA-256 evidence chain (integrity, not secrecy).

**Q5.** Why is Argon2id preferred over plain SHA-256 for storing passwords? (Also: what defeats rainbow tables?)
**A:** It's a deliberately slow, memory-hard key-derivation function (key stretching) with salting —
making offline brute force expensive, and salting defeats precomputed rainbow tables. SHA-256 is fast
and (unsalted) rainbow-table-vulnerable.
**Distractor note:** "SHA-256 is more secure because it's a strong hash" confuses collision-resistance
with brute-force resistance — speed is the weakness here. "A longer hash" doesn't stop rainbow tables;
salting does.
**Portfolio link:** [ironveil](../../ironveil) — LUKS2 uses Argon2id.

**Q6.** Define the three A's of AAA and say which underpins non-repudiation.
**A:** Authentication (who you are), Authorisation (what you may do), Accounting (what you did).
Accounting/auditing underpins non-repudiation — the logged record ties an action to an identity.
**Distractor note:** Authorisation is often miscalled the non-repudiation enabler; it's the *accounting*
trail that proves an action occurred.

---

## Domain 2 — Threats, Vulnerabilities & Mitigations (11)

**Q7.** What three attributes make a threat an "APT"?
**A:** Advanced (custom tooling/zero-days), Persistent (long dwell time — months/years), Threat
(organised, funded).
**Distractor note:** "APT = nation-state only" is wrong — state-sponsored criminal groups also qualify;
the defining traits are capability + persistence + organisation, not just who.

**Q8.** Password spraying vs credential stuffing vs brute force — distinguish them.
**A:** Spraying = a few common passwords across many accounts (dodges lockout). Stuffing = breached
username/password pairs reused on other services (relies on reuse). Brute force = many guesses against
one account.
**Distractor note:** All three are "guessing", but the breadth/data differs — stuffing specifically
needs a prior breach dump.

**Q9.** XSS vs CSRF — whose trust is abused in each?
**A:** XSS abuses the *user's* trust in the site (script runs in their browser). CSRF abuses the
*site's* trust in the authenticated browser.
**Distractor note:** Easy to swap. Defences also differ: output encoding/CSP (XSS) vs anti-CSRF tokens
+ SameSite (CSRF).

**Q10.** A wireless AP broadcasts the same SSID as the corporate Wi-Fi so clients auto-connect. Name it.
**A:** Evil twin.
**Distractor note:** "Rogue AP" is close but means an *unauthorised* AP on the network, not necessarily
one impersonating a known SSID; "jamming" is RF denial, not impersonation.

**Q11.** A trusted vendor's software update is poisoned and pushed to all its customers. Category + one fix.
**A:** Supply-chain (software) vulnerability; mitigations: code signing / update-integrity verification,
SBOM, vendor due diligence, least-privilege vendor access.
**Distractor note:** Tempting to call it "malware" — it *is* malware, but the testable concept is the
*supply-chain trust* being abused (SolarWinds pattern).
**Portfolio link:** [ironveil](../../ironveil) — vendor cloud-daemon elimination reduces this surface.

**Q12.** CVE vs CVSS vs CWE vs KEV.
**A:** CVE = catalogued vulnerability instance; CVSS = 0–10 severity score; CWE = weakness *type*;
KEV = CISA's list of vulnerabilities under *active exploitation* (top patch priority).
**Distractor note:** People treat CVSS as the whole prioritisation — but a CVSS 7.5 on the KEV list
outranks a CVSS 9.8 with no known exploit.
**Portfolio link:** [spectre](../../spectre) — primary finding CWE-548 (directory listing).

**Q13.** Fileless malware evades signature AV by doing what, and what detects it?
**A:** Living in memory / abusing LOLBins (PowerShell, WMI, certutil) rather than writing a file;
behavioural EDR detects it.
**Distractor note:** "Better antivirus signatures" won't catch it — there's often no file to sign.

**Q14.** Pass-the-hash — what is captured and what's a key mitigation?
**A:** An NTLM hash captured from one host and replayed to authenticate elsewhere *without cracking it*;
mitigations: Credential Guard, SMB signing, privileged-access workstations.
**Distractor note:** "Crack the hash" isn't required — that's the trap; the hash itself is the credential.

**Q15.** An asset can't be patched (EOL, vendor gone). Vulnerability type + correct response.
**A:** Hardware/firmware EOL/legacy; response = compensating controls (segment/isolate, restrict
access, monitor) + a documented risk exception — you can't remediate, so you contain.
**Distractor note:** "Just take it offline" may be impossible for OT/critical systems — compensating
controls is the testable answer.

**Q16.** Passive vs active reconnaissance — which is harder to detect and why does it matter?
**A:** Passive/OSINT (WHOIS, certificate transparency, Shodan, LinkedIn) makes no contact with the
target, so it leaves no logs there; active recon (scanning, banner grabbing) shows in firewall/IDS logs.
**Distractor note:** Both are "recon", but only active recon is detectable on the target — relevant to
what a SOC can actually see.
**Portfolio link:** [spectre](../../spectre) — active recon (nmap/Nikto/Gobuster) is logged/detectable.

**Q17.** AI-generated phishing removes which classic detection signal, and what defence still holds?
**A:** It removes the "grammar/spelling tells"; defence shifts to context ("does this *request* make
sense?") + phishing-resistant FIDO2 MFA + out-of-band verification.
**Distractor note:** "Train users to spot bad grammar" is now weak guidance — fluency is cheap.
**Portfolio link:** [mirage](../../mirage) — studies the causal mechanisms AI phishing relies on.

---

## Domain 3 — Security Architecture (9)

**Q18.** Under the cloud shared-responsibility model, what does the customer ALWAYS own?
**A:** Their data, identity/access management (IAM), and configuration of what they put *in* the cloud
(across IaaS/PaaS/SaaS).
**Distractor note:** "The provider secures everything in SaaS" is the trap — misconfigured customer IAM
is the most common cloud breach cause.

**Q19.** You must expose a web server to the internet but keep the internal DB unreachable from outside.
**A:** Place the web server in a screened subnet (DMZ) between two firewalls; the DB stays on an
internal segment with no inbound path.
**Distractor note:** "Just firewall the DB" — the architectural answer is the DMZ/segmentation pattern.

**Q20.** RTO vs RPO.
**A:** RTO = max tolerable downtime ("back within X"). RPO = max tolerable data loss in time ("lose at
most X" → drives backup frequency).
**Distractor note:** Frequently swapped; RPO is about *data*, RTO is about *time to restore*.

**Q21.** Hot vs warm vs cold DR site — which is fastest failover at highest cost?
**A:** Hot site (live-replicated, minutes to fail over, highest cost).
**Distractor note:** Warm sounds "ready" but needs restore time (hours); cold is space/power only (days).

**Q22.** Type 1 vs Type 2 hypervisor, and what is VM escape?
**A:** Type 1 = bare-metal (runs on hardware directly); Type 2 = hosted (runs on an OS). VM escape =
breaking out of a guest VM to execute on the hypervisor/host — the critical virtualisation risk.
**Distractor note:** "VM sprawl" is a management/hygiene problem, not the escape attack — don't conflate.

**Q23.** Why does OT/ICS prioritise availability over confidentiality?
**A:** These run physical/industrial processes where downtime is unacceptable or unsafe; you can't take
a turbine offline to patch on a whim — so availability leads and you segment + use compensating controls.
**Distractor note:** Reflexively applying "confidentiality first" (IT thinking) is the trap for OT.

**Q24.** Full vs incremental vs differential backup — which is fastest to *back up* and fastest to *restore*?
**A:** Incremental is fastest to back up (only changes since the last backup). Full is fastest to
restore (single set). Differential sits between (all changes since the last full).
**Distractor note:** People assume one type wins both — there's a backup-speed vs restore-speed trade-off.

**Q25.** Ransomware encrypts production AND the latest backup (the backup share was writable). What single
property would have saved them?
**A:** Immutable/WORM (or offline air-gapped) backups — the "offsite + immutable" leg of 3-2-1.
**Distractor note:** "More frequent backups" doesn't help if the backups are themselves encryptable.

**Q26.** What do the three numbers in the 3-2-1 backup rule mean?
**A:** 3 copies of data, on 2 different media types, with 1 copy offsite.
**Distractor note:** Sometimes misremembered as "3 backups" — it's 3 total *copies* (including the
production data).

---

## Domain 4 — Security Operations (14)

**Q27.** SIEM vs SOAR.
**A:** SIEM aggregates + correlates + alerts on logs; SOAR adds automated/orchestrated response
(playbooks) on top.
**Distractor note:** SOAR isn't a "better SIEM" — it's the automation/response layer.
**Portfolio link:** [watchtower](../../watchtower) — the planned Wazuh SIEM lab.

**Q28.** RADIUS vs TACACS+ — what does each encrypt and which transport?
**A:** RADIUS (UDP) encrypts only the password field; TACACS+ (TCP) encrypts the entire payload and
separates auth/authz/accounting. Use TACACS+ for device administration.
**Distractor note:** "Both fully encrypt" is wrong — RADIUS leaves most of the packet in the clear.

**Q29.** OAuth 2.0 vs OpenID Connect — which is authentication, which is authorisation?
**A:** OAuth 2.0 = authorisation (delegated access tokens). OpenID Connect = authentication (adds an ID
token on top of OAuth — "Login with Google").
**Distractor note:** Treating OAuth as a login/authentication protocol is the classic exam trap.

**Q30.** Is "password + PIN" multifactor? Give a genuinely multifactor pair.
**A:** No — both are *knowledge*. A true pair: password (knowledge) + hardware token/TOTP (possession),
or password + fingerprint (inherence).
**Distractor note:** Two of the same factor is multi-*step*, not multi-*factor*.

**Q31.** Order the NIST SP 800-61 incident-response phases.
**A:** Preparation → Detection/Analysis → Containment → Eradication → Recovery → Lessons Learned.
**Distractor note:** People put Eradication before Containment — you contain (stop spread) before you
eradicate (remove).

**Q32.** Live acquisition: collect RAM or the disk image first, and why?
**A:** RAM first — it's more volatile (lost on power-down, changing constantly); disk is non-volatile.
**Distractor note:** "Image the disk first to preserve it" inverts the order of volatility.
**Portfolio link:** [spectre](../../spectre) — evidence-integrity discipline (hashing, logging).

**Q33.** Which three DNS records authenticate email senders, and which sets the failure *policy*?
**A:** SPF (authorised IPs), DKIM (cryptographic signature), DMARC (policy none/quarantine/reject +
alignment + reporting). DMARC sets the policy and depends on SPF/DKIM.
**Distractor note:** DMARC without SPF/DKIM does nothing — it's the policy layer, not a standalone check.
**Portfolio link:** [mirage](../../mirage) — phishing/social-engineering research.

**Q34.** True positive vs false positive vs false negative — which is most dangerous and why?
**A:** False negative — a real attack with no alert; it goes undetected and creates false confidence.
**Distractor note:** False positives are costly (alert fatigue) but visible/tunable; the silent miss is
worse.

**Q35.** A SIEM rule fires 200×/day, all benign so far. Classify and fix.
**A:** False positives → tune the rule (thresholds, context, allow-list known-good).
**Distractor note:** "Disable the rule" risks creating a false-negative blind spot — tune, don't kill.

**Q36.** A Windows service runs as SYSTEM with a binary in a user-writable directory. Technique + fix.
**A:** Insecure service permissions / privilege escalation (replace binary, restart → SYSTEM); fix =
restrict write perms on service binaries (and quote service paths for the unquoted-path variant).
**Distractor note:** "Unquoted path" is a related but distinct variant — here the issue is the writable binary.
**Portfolio link:** [gauntlet](../../gauntlet) — Steel Mountain privesc; [watchtower](../../watchtower) scenario 4.

**Q37.** EDR vs traditional AV.
**A:** AV = signature detection of known malware; EDR = continuous telemetry + behavioural detection +
response/rollback (catches fileless/novel).
**Distractor note:** "EDR is just AV with a dashboard" undersells the behavioural/response capability.

**Q38.** Which two log sources best confirm a host beaconed to a C2 domain?
**A:** DNS/proxy logs (resolution of the bad domain) + NetFlow/firewall logs (the periodic outbound
connection). Endpoint/Sysmon shows the process.
**Distractor note:** A packet capture is ground truth but storage-heavy and not always available —
DNS+flow are the practical first stops.
**Portfolio link:** [watchtower](../../watchtower) — scenario 8 (reverse shell / C2 beacon).

**Q39.** What is NAC and when does it act?
**A:** Network Access Control posture-checks a device (patch level, AV, cert) *before* granting network
access, quarantining non-compliant hosts; often 802.1X-backed.
**Distractor note:** NAC isn't a firewall — it's admission control at connect time.

**Q40.** Why is NTP critical to both a SIEM and Kerberos?
**A:** SIEM correlation across sources needs aligned timestamps; Kerberos rejects tickets when clock
skew exceeds the tolerance (~5 min). Bad time breaks detection *and* auth.
**Distractor note:** Time sync looks like trivial housekeeping — it's load-bearing for both.

---

## Domain 5 — Program Management, Risk & Compliance (10)

**Q41.** A firm buys cyber-insurance instead of fixing the root cause. Risk strategy + residual exposure.
**A:** Transference; residual = reputational damage and operational disruption insurance won't cover
(and no payout if negligence is shown).
**Distractor note:** Insurance ≠ the risk disappearing — transference moves *financial* impact only.

**Q42.** Compute ALE: AV £200K, EF 0.30, ARO 0.25. Is a £30K/yr control justified on ALE alone?
**A:** SLE = 200K×0.30 = £60K; ALE = 60K×0.25 = £15K/yr. The £30K control exceeds the £15K annual
expected loss → not justified on ALE alone (unless it covers other risks or a compliance mandate).
**Distractor note:** Forgetting ARO and comparing the control to SLE (£60K) wrongly "justifies" it.

**Q43.** Which agreement is a non-binding statement of intent?
**A:** MOU (Memorandum of Understanding).
**Distractor note:** SLA (service levels), BPA (business partnership), NDA (confidentiality), MSA
(master services) are all more formal/binding — MOU is the soft one.

**Q44.** GDPR: breach reporting deadline and to whom?
**A:** Notify the supervisory authority within 72 hours of becoming aware; notify affected data subjects
without undue delay if high risk to their rights.
**Distractor note:** "Notify everyone immediately/within 24h" — the specific figure is 72 hours to the
authority.

**Q45.** Name the five NIST CSF functions in order.
**A:** Identify → Protect → Detect → Respond → Recover. (CSF 2.0 adds **Govern** as an overarching
function.)
**Distractor note:** Don't confuse with the NIST 800-61 IR lifecycle — CSF is the program framework.

**Q46.** SOC 2 Type I vs Type II.
**A:** Type I = control *design* at a point in time; Type II = control *operating effectiveness over a
period* (e.g. 6–12 months).
**Distractor note:** Type II is the stronger assurance customers usually want — Type I is a snapshot.

**Q47.** Data controller vs data processor (GDPR).
**A:** The controller decides the *purpose and means* of processing; the processor acts on the
controller's instructions.
**Distractor note:** A cloud/SaaS vendor is usually the *processor*, not the controller — easy to invert.

**Q48.** KRI vs KPI — which is the leading indicator of rising risk?
**A:** KRI (Key Risk Indicator) is a leading indicator of rising risk (e.g. growing unpatched-host
count); a KPI measures performance against a goal (often lagging).
**Distractor note:** Both are "metrics" — the KRI is the forward-looking risk signal.

**Q49.** Why does an SBOM matter for supply-chain risk?
**A:** A Software Bill of Materials lists every component/dependency, so when a component is found
vulnerable you can immediately find everywhere it's used and respond.
**Distractor note:** It's not just an inventory nicety — it's what makes supply-chain response *fast*.

**Q50.** Audit vs assessment.
**A:** An audit checks conformance against a defined standard/control set (pass/fail); an assessment
evaluates overall posture and maturity (often advisory).
**Distractor note:** Used interchangeably in speech, but the exam distinguishes conformance-checking
from posture-evaluation.

---

*Scoring: track by domain; below ~80% in a domain → re-read that domain file and re-test. The
distractor notes are the highest-value part — exam questions are won by eliminating the *tempting*
wrong answer, not just recognising the right one.*
