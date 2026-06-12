# SY0-701 Domain 2 — Threats, Vulnerabilities & Mitigations (22%)

The largest concept domain. Maps to classic notes in
[1.0-threats-attacks-vulnerabilities.md](1.0-threats-attacks-vulnerabilities.md)
plus threat intelligence and mitigation depth.

---

## 1. Threat intelligence

Intelligence about threats comes from multiple tiers of source:

| Source | Type | Use |
|--------|------|-----|
| OSINT | Open-source | Public threat data, breach disclosures, NIST NVD |
| ISAC | Industry-sharing | Sector-specific threat feeds (financial, energy, healthcare) |
| Dark web monitoring | Closed source | Credential dumps, exploit sales, targeted chatter |
| Vendor feeds | Commercial | Paid TI feeds (Recorded Future, CrowdStrike Falcon Intel) |
| Government advisories | Official | NCSC, CISA, US-CERT alerts |

**Structured threat intel standards:**
- **STIX** (Structured Threat Information eXpression) — the data format for threat intel objects
  (indicators, TTPs, threat actors, campaigns).
- **TAXII** (Trusted Automated eXchange of Indicator Information) — the transport protocol for
  sharing STIX data between organisations.
- **MITRE ATT&CK** — adversary TTP knowledge base; tactics (the *why*) → techniques (the *how*).
  The gold standard for mapping observed behaviour to known threat actor methods.
- **Cyber Kill Chain** (Lockheed Martin) — seven phases: Recon → Weaponisation → Delivery →
  Exploitation → Installation → C2 → Actions on Objectives. Useful for defender disruption points.
- **IoC (Indicator of Compromise)** — artefact indicating a system may be compromised: IP, domain,
  file hash, registry key, unusual traffic pattern. Operational-level intelligence.
- **IoA (Indicator of Attack)** — behavioural pattern indicating an attack in progress (e.g.
  lateral movement, privilege escalation). More strategic than IoCs.

---

## 2. Threat actors and attributes

| Actor | Motivation | Sophistication | Notes |
|-------|-----------|----------------|-------|
| Script kiddie | Thrill, notoriety | Low — uses existing tools | Opportunistic; high volume |
| Hacktivist | Ideology, politics | Low–medium | Defacement, DoS, data leaks |
| Insider | Revenge, money, negligence | Variable — has legitimate access | Hardest to detect |
| Organised crime | Financial | Medium–high | Ransomware, BEC, data theft |
| Nation-state / APT | Espionage, sabotage | Very high; zero-days; long dwell | Advanced + Persistent + Threat |
| Competitor | Commercial advantage | Variable | Industrial espionage |

**APT definition (exam-critical):** "Advanced" = custom tooling, zero-days, skilled operators.
"Persistent" = maintains access for months or years (dwell time). "Threat" = organised, funded.
APT ≠ just a nation-state — state-sponsored criminal groups also qualify.

**Threat actor attributes the exam tests:** internal vs external; level of sophistication;
resources/funding; intent (disruptive vs espionage vs financial); intent affects countermeasure choice.

---

## 3. Social engineering — psychology and variants

Social engineering is the #1 attack vector because it bypasses technical controls by targeting
the human. Underlying **Cialdini principles** (memorise these — the exam tests the mechanism, not just the name):

| Principle | Mechanism |
|-----------|-----------|
| **Authority** | Target complies because the request appears to come from someone with authority (IT, executive, regulator) |
| **Urgency** | Time pressure short-circuits deliberate evaluation ("act now or your account will be closed") |
| **Scarcity** | Artificial shortage drives action ("only one slot left") |
| **Consensus / social proof** | "Everyone else has already done this" normalises the request |
| **Familiarity / liking** | Trust built through apparent shared interests or prior relationship |
| **Trust** | Pre-established credibility reduces scrutiny |
| **Intimidation** | Fear of consequences overrides rational evaluation |

**Attack variants (know all of these):**

| Attack | Channel | Key characteristic |
|--------|---------|-------------------|
| Phishing | Email | Broad, volume-based; hyperlinks and attachments |
| Spear phishing | Email | Targeted; uses personal details about the victim |
| Whaling | Email | Targets executives specifically |
| Vishing | Voice / phone | Real-time call; exploits lack of visual cues |
| Smishing | SMS | Shortened URLs; mobile context reduces scrutiny |
| Pharming | DNS / hosts file | Redirects legitimate domain to malicious IP |
| Watering hole | Web | Compromises a site the target is known to visit |
| Pretexting | Any | Fabricates a scenario (false pretext) to extract information |
| Tailgating / piggybacking | Physical | Follows authorised person through access-controlled door |
| Dumpster diving | Physical | Recovers sensitive discarded material |
| Shoulder surfing | Physical | Observes credentials or sensitive data being entered |
| Baiting | Physical | Leaves malicious media (USB) in a location the target will find it |
| BEC / invoice fraud | Email | Impersonates a known contact to divert payments |

**AI-amplified threats (SY0-701 emphasis):**
- LLM-generated phishing: fluent, personalised, free of grammar "tells" — classic detection signals degrade.
- Deepfake voice (vishing): voice cloning for CEO fraud; already deployed in live attacks.
- Automated pretext research: AI-driven OSINT aggregation to build convincing backstories.
- Defence shift: from "does this look right?" to "does this *request* make sense in context?";
  out-of-band callback verification; phishing-resistant FIDO2 MFA.

> Portfolio link: [mirage](../../mirage) directly studies phishing/smishing/vishing and models
> the causal mechanisms (urgency, authority, trust, deception, obfuscation) that AI-generated
> social engineering relies on. Finding: LLMs detect surface patterns but miss multi-hop causal
> chains — directly relevant to this SY0-701 topic.

---

## 4. Malware taxonomy

| Type | Defining trait | Attack/defence note |
|------|----------------|---------------------|
| **Virus** | Needs a host file + user action to spread | Attach to executables; spread via user sharing |
| **Worm** | Self-propagating over a network, no user action | Faster spread; EternalBlue/WannaCry |
| **Trojan** | Disguised as legitimate software | No replication; relies on social engineering for delivery |
| **RAT** | Remote Access Trojan — gives attacker remote control | Usually installed via trojan; persistent |
| **Ransomware** | Encrypts data, demands payment | Offline backups + immutable storage defeat it |
| **Crypto-malware** | Cryptomining variant | Resource exhaustion; network detection via C2 beacons |
| **Rootkit** | Hides at OS/kernel/firmware level | Subverts the OS; survives reboots; hard to detect |
| **Bootkit** | Persists in the boot chain (MBR/EFI) | Defeated by verified boot / Secure Boot |
| **Logic bomb** | Triggers on a condition (date, event, file present) | Insider threat vector |
| **Keylogger / spyware** | Captures input / monitors activity | Credential theft; exfiltration |
| **Backdoor** | Bypasses normal authentication | Often planted by other malware for persistent access |
| **Fileless** | Lives in memory / abuses LOLBins (PowerShell, WMI, certutil) | Evades signature scanners; EDR + behavioural detection needed |
| **Botnet** | Network of compromised hosts (bots) controlled via C2 | DDoS amplification; credential stuffing; spam |

> Portfolio link: [nullbyte](../../nullbyte) verified boot + Titan M2 defeats **bootkits** at
> the hardware level. [oracle](../../oracle)'s security applications section covers **malware
> visualisation** — classifying malware by rendering binaries as images, a CNN-based detection technique.

---

## 5. Application attacks

**Injection:**
- **SQL injection (SQLi):** malicious SQL inserted into an input field; reads, modifies, or deletes
  database data. Defence: parameterised queries / prepared statements — the only real fix.
- **Command injection:** OS commands injected via an application input.
- **LDAP/XML/XPath injection:** same principle, different target protocol.

**Web attacks:**
- **XSS (Cross-Site Scripting):** malicious script injected into a trusted website, executes in
  another user's browser. Types: **stored** (persists in DB), **reflected** (in URL parameter),
  **DOM-based** (client-side only).
  - *"XSS abuses the user's trust in the site."*
- **CSRF (Cross-Site Request Forgery):** tricks an authenticated user's browser into sending an
  unintended request to a site where they are logged in.
  - *"CSRF abuses the site's trust in the user's browser."*
  - Defence: anti-CSRF tokens; SameSite cookie attribute.

**Memory/execution attacks:**
- **Buffer overflow:** writes beyond allocated buffer boundary; overwrites adjacent memory (return
  address, adjacent variables). Can lead to arbitrary code execution. Defence: ASLR, stack canaries, DEP/NX, safe APIs.
- **Integer overflow:** value exceeds integer type maximum, wraps around.
- **Race condition / TOCTOU (Time-of-Check to Time-of-Use):** condition changes between the
  security check and the use of the resource.
- **DLL injection:** forces a process to load a malicious DLL.
- **Heap spray:** fills heap with shellcode; increases probability of jumping to shellcode.
- **Memory injection (umbrella term, objective 2.3):** writing into another process's address
  space to run attacker code — DLL injection, process hollowing, and reflective loading are
  variants. *Exam cue:* "code ran inside a legitimate signed process" → memory injection, which is
  also why it evades signature AV (the host binary is trusted). Defence: EDR behavioural detection,
  not signatures.

**Path/directory traversal and inclusion:**
- **Directory (path) traversal:** `../../etc/passwd` style input escapes the web root to read
  arbitrary files. Defence: canonicalise + validate paths, run the service with least privilege,
  no user input in file paths.
  - *Mechanism:* the app concatenates user input into a filesystem path without normalising `..`
    sequences. *Commonly confused with* SQLi (database) and LFI — traversal is **filesystem** read.
- **File inclusion (LFI/RFI):** the app `include()`s a path the attacker controls — **local**
  (read/execute a file already on the server) or **remote** (pull attacker-hosted code; needs the
  runtime to allow remote URLs). RFI → remote code execution.
- *Exam trap:* a stem showing `GET /download?file=../../../../etc/shadow` is **directory
  traversal**, not "privilege escalation" — the wrong answer names the *outcome*; the question
  asks the *attack class*.
- *Portfolio connection:* spectre's CWE-548 directory **indexing** finding is adjacent but
  distinct — indexing exposes a listing the server *offers*; traversal *escapes* the intended
  directory. Knowing the difference is a clean interview discriminator.

> Portfolio link: [spectre](../../spectre) found directory listing (CWE-548) and information
> disclosure (CWE-200) on the Apache host; [gauntlet](../../gauntlet) documents exploitation
> of MS17-010 (buffer overflow in SMBv1).

---

## 6. Network attacks

**Authentication attacks:**
- **Pass-the-hash:** capture the NTLM hash from one system and use it to authenticate elsewhere
  without cracking it. Defence: credential guard, privileged access workstations, SMB signing.
- **Pass-the-ticket:** steal Kerberos TGT/TGS tickets for lateral movement. Defence: short ticket
  lifetimes, privileged access management.
- **Password spraying:** try a few common passwords across many accounts; avoids lockout thresholds.
  Very effective against weak password policies.
- **Credential stuffing:** use breached credential pairs to attack other services; relies on
  password reuse. Defence: MFA; breach monitoring (HaveIBeenPwned integration).
- **Rainbow tables:** precomputed hash-to-plaintext tables. Defeated by **salting**.

**Network attacks:**
- **MITM / on-path:** attacker intercepts and optionally modifies traffic between two parties.
  Defence: mutual TLS, certificate pinning, HSTS.
- **SSL stripping:** downgrades HTTPS to HTTP; intercepts cleartext. Defence: HSTS.
- **Replay:** captures and retransmits a valid authentication credential. Defence: nonces, timestamps.
- **Session hijacking:** steals a session token after authentication. Defence: HttpOnly/Secure
  cookies, short session lifetimes, IP binding.
- **DoS / DDoS:** volumetric (bandwidth exhaustion), protocol (SYN flood), application-layer
  (HTTP flood). Amplification/reflection attacks use misconfigured DNS/NTP/SSDP to amplify traffic.
- **DNS poisoning / cache poisoning:** inserts fraudulent DNS records into a resolver's cache.
  Defence: DNSSEC, DoH/DoT.
- **ARP poisoning / spoofing:** sends fake ARP replies to map attacker's MAC to a target IP;
  enables MITM on a LAN. Defence: dynamic ARP inspection, 802.1X.
- **MAC flooding:** floods a switch's CAM table until it fails open (broadcasts to all ports).
- **Deauthentication / deauth:** 802.11 deauth frames (unencrypted in WPA2) used to kick clients;
  forces reconnect to capture handshakes. Mitigated by **802.11w** (management frame protection).

**Wireless / RF attacks (know all of these — recurring exam items):**
- **Rogue access point:** an unauthorised AP plugged into the network — an unmanaged entry point.
- **Evil twin:** a malicious AP spoofing a legitimate SSID so clients auto-connect; harvests
  credentials / runs MITM. Defence: 802.1X/EAP-TLS, "verify the network" user training, WPA3.
- **Jamming:** RF interference denies wireless availability (a DoS at the physical layer).
- **Bluejacking** (sending unsolicited messages) vs **bluesnarfing** (stealing data over Bluetooth) —
  know the difference: jacking = push, snarfing = theft.
- **RFID / NFC attacks:** cloning or relay attacks on contactless cards/badges. Relevant to physical
  access control and contactless payment.
- **WPS attacks:** brute-forcing the WPS PIN to recover the WPA passphrase. Defence: disable WPS.
- **Disassociation:** like deauth — forcibly drops a client; also mitigated by 802.11w.

---

## 7. Vulnerability management lifecycle

**Lifecycle:** Identify → Assess/Prioritise → Remediate → Verify → Report → (repeat)

**Scanning types:**
- **Credentialed vs non-credentialed:** credentialed provides deeper visibility (full file system,
  registry, service configs); non-credentialed reflects external attacker view.
- **Agent vs network-based:** agents provide continuous endpoint visibility; network-based scans
  periodically from a scanner.
- **Intrusive vs non-intrusive:** intrusive scanning can cause service disruption; non-intrusive
  is safer but may miss some findings.

**Output:**
- **False positive:** flagged as a vulnerability but is not one → wastes remediation effort.
- **False negative:** real vulnerability missed → dangerous; creates false confidence.
- Tuning scanners reduces false positives; combine multiple scanners to reduce false negatives.

**Scoring and cataloguing:**
- **CVE** (Common Vulnerabilities and Exposures) — catalogue entry for a known vulnerability.
  Format: CVE-YYYY-NNNNN.
- **CVSS** (Common Vulnerability Scoring System) — 0–10 numerical severity score. Base metrics:
  attack vector, attack complexity, privileges required, user interaction, scope, CIA impact.
- **CWE** (Common Weakness Enumeration) — weakness *types* (e.g. CWE-548 directory listing,
  CWE-89 SQL injection). CVSS measures severity; CWE describes the type of flaw.
- **CISA KEV** (Known Exploited Vulnerabilities) — CISA's curated list of vulnerabilities with
  confirmed active exploitation. Highest-priority patching target.

**Prioritisation:** CVSS × asset criticality × exploitability (KEV listed? Public exploit
available?). A CVSS 9.8 with no exploit code ranks below a CVSS 7.5 that is actively exploited.

> Portfolio link: [spectre](../../spectre) maps findings to CWE, estimates CVSS scores, and
> uses CIS benchmarks for the hardening baseline — the full practical vulnerability management
> cycle.

---

## 8. Attack surface and attack vectors

**Attack surface** = the sum of all possible entry and extraction points.
**Attack vector** = the specific path or method used by an attacker.

Reducing the surface is cheaper than blocking every vector. Core surface reduction: disable
unnecessary services, remove default credentials, close unused ports, patch, segment networks,
remove legacy protocols.

**Recon types:**
- **Passive / OSINT:** no contact with the target — WHOIS, DNS records, certificate transparency,
  Shodan, LinkedIn, GitHub leaks, Google dorking. Hard to detect; leaves no logs on the target.
- **Active:** direct contact — port scanning, banner grabbing, directory enumeration, ping sweeps.
  Detectable in firewall/IDS logs.

> Portfolio link: [spectre](../../spectre) ran the full active recon phase — nmap, WhatWeb,
> Nikto, Gobuster — and mapped each finding back to attack-surface reduction in countermeasures.

---

## 9. Mitigations

**Technical:**
- Patching and patch management cycles
- Input validation, parameterised queries
- Network segmentation, VLANs, DMZ
- FIDO2 MFA (phishing-resistant), password managers
- EDR for endpoint visibility
- WAF for web application protection
- DNS filtering (DoH/DoT, blocklists)
- Immutable and offsite backups (defeats ransomware)

**Administrative:**
- Security awareness training, phishing simulations
- Incident response plan, playbooks
- Vendor/supply-chain risk management
- Acceptable Use Policy (AUP), clear desk policy
- Background checks, least privilege principle

**Physical:**
- Mantraps, badge access, biometric entry
- CCTV monitoring
- Device labelling, cable locks, USB blockers
- Secure disposal (shredding, degaussing, crypto-erase)

---

## 10. Vulnerability types — the full 2.3 catalogue

The exam tests recognition of *where* a vulnerability lives, not just named attacks:

| Type | Description | Example / defence |
|------|-------------|-------------------|
| **Application** | Flaws in app code/logic | Injection, XSS, memory bugs — secure SDLC, code review |
| **OS-based** | Weaknesses in the operating system | Unpatched kernel; harden + patch |
| **Web-based** | Server/web-stack flaws | Directory listing (CWE-548 — spectre's finding), misconfig |
| **Hardware / firmware** | Physical / low-level | Unpatchable firmware; **end-of-life (EOL)** and **legacy** systems no longer receiving patches → compensating controls |
| **Virtualization** | Hypervisor/VM flaws | **VM escape** (break out to host), **VM sprawl** (unmanaged VMs) |
| **Cloud-specific** | Cloud config & shared-responsibility gaps | Open S3 bucket, over-permissive IAM, exposed management plane |
| **Supply chain** | Trust in a third party is abused | Compromised software update (SolarWinds-style), malicious dependency, hardware implant, MSP compromise |
| **Cryptographic** | Weak/old crypto | MD5/SHA-1, weak TLS, poor key management, hard-coded keys |
| **Misconfiguration** | Insecure defaults / human error | Default creds, open ports, verbose errors — the most common real-world root cause |
| **Mobile device** | Mobile-specific | Sideloading, jailbreak/root, insecure storage, lost-device data |
| **Zero-day** | No patch exists yet (vendor unaware/unfixed) | Defence is behavioural detection + defence-in-depth, not signatures |

**Supply-chain depth (heavily emphasised in SY0-701):** the four vectors are **software** (poisoned
update/dependency), **hardware** (implant/counterfeit), **service provider / MSP** (a trusted vendor
with access is breached), and **open-source dependency** (typosquatting, abandoned packages).
Mitigations: vendor due diligence, SBOM (Software Bill of Materials), code signing, and least-
privilege third-party access.

> Portfolio link: [ironveil](../../ironveil)'s elimination of vendor cloud daemons and minimal
> attack surface is a direct supply-chain / misconfiguration reduction; [oracle](../../oracle)'s
> assurance discipline (validate the model before trusting it) is the same instinct applied to ML.

## 11. Indicators of malicious activity (2.4)

What a SOC actually *sees* when something is wrong — the bridge to Domain 4 triage:

- **Account anomalies:** lockouts, concurrent sessions, **impossible travel**, blocked/unusual logins.
- **Resource anomalies:** unexpected CPU/memory/bandwidth consumption (cryptomining, exfil, DoS).
- **Network anomalies:** out-of-cycle / out-of-hours traffic, beaconing to one host, traffic to known-
  bad domains/IPs, large outbound transfers.
- **Content / integrity:** blocked content alerts, unexpected file changes (FIM), defacement.
- **Logging anomalies:** **missing logs** (an attacker clearing tracks is itself an indicator),
  sudden log volume spikes.
- **Published / documented:** the attacker leaks/announces the breach, or it appears on a dark-web
  dump — sometimes the first sign of a compromise is external.

---

### Quick self-test
- APT: what makes it "advanced", "persistent", "threat"?
- Password spraying vs credential stuffing vs brute force — what is different about each?
- XSS vs CSRF — whose trust is being abused in each?
- False positive vs false negative — which is more dangerous in a security context?
- CVE vs CVSS vs CWE — the catalogue entry, the score, the weakness type.
- STIX vs TAXII — the format vs the transport.
- Why is passive recon harder to detect than active, and why does that matter operationally?
- What two controls defeat rainbow table attacks?
- Evil twin vs rogue AP — which spoofs an existing SSID, and which is an unauthorised AP on the LAN?
- Bluejacking vs bluesnarfing — which one steals data?
- Name the four supply-chain attack vectors and one mitigation for each.
- VM escape vs VM sprawl — which is an attack and which is a management/hygiene problem?
- Why is "missing logs" treated as an indicator of compromise rather than a routine IT issue?

### Scenario drills

1. *A vendor pushes a routine software update; days later, multiple customers of that vendor are
   breached through the updated binary.* Which vulnerability type and vector? → **Supply-chain
   (software)** — the trust in the vendor's update channel was abused (SolarWinds pattern).
2. *Staff receive a fluent, personalised, grammatically perfect phishing email referencing a real
   internal project.* Which two SY0-701 themes are in play, and what defence still holds? →
   **AI-generated social engineering** + **spear phishing**; the classic "grammar tells" are gone, so
   defence shifts to context ("does this request make sense?") + **phishing-resistant FIDO2 MFA** and
   out-of-band verification.
3. *A SOC sees a user account log in from London and Tokyo within ten minutes, then a spike in
   outbound traffic to an unfamiliar domain.* Which indicators fired? → **Impossible travel** +
   **anomalous outbound/beaconing** — likely account compromise with exfiltration; contain the account.
4. *An asset cannot be patched because the vendor no longer exists and the firmware is EOL.* What
   vulnerability type, and what is the correct response when you cannot remediate? → **Hardware/
   firmware EOL/legacy**; apply **compensating controls** (segment/isolate the host, restrict access,
   monitor closely) and document the risk exception.
5. *A penetration tester finds the web server returns a full directory listing.* Name the CWE, the
   vulnerability type, and the fix. → **CWE-548 (directory listing)**, a **web-based / misconfiguration**
   vulnerability; disable auto-indexing (`Options -Indexes`). *(This is spectre's primary finding.)*

---

## Quick reference card — Domain 2

One-page revision sheet. If any line is not instant recall, re-read that section above.

**Acronyms:**
APT (advanced persistent threat) · OSINT/ISAC (open-source intel / sharing centre) · STIX/TAXII
(intel format / transport) · IoC/IoA (indicator of compromise / of attack) · TTP (tactics,
techniques, procedures) · BEC (business email compromise) · RAT (remote access trojan) ·
SQLi/XSS/CSRF (injection / cross-site scripting / request forgery) · TOCTOU (time-of-check
time-of-use) · CVE/CVSS/CWE/KEV (catalogue entry / severity score / weakness type / known-exploited
list) · SBOM (software bill of materials) · EOL/EOSL (end of life / of service life)

**Key term one-liners:**
- Threat actors by motivation: script kiddie (thrill) · hacktivist (ideology) · insider (revenge/
  money/negligence) · organised crime (financial) · nation-state/APT (espionage, long dwell).
- Social-engineering levers: authority · urgency · scarcity · consensus · familiarity · trust ·
  intimidation — the exam tests the *mechanism*, not the name.
- Channel map: phishing (email) · spear/whaling (targeted/exec email) · vishing (voice) ·
  smishing (SMS) · pharming (DNS) · watering hole (site the target visits) · baiting (planted media).
- Malware traits: virus (host file + user action) · worm (self-propagating) · trojan (disguise) ·
  rootkit (kernel hide) · bootkit (boot chain — beaten by verified boot) · logic bomb (trigger
  condition) · fileless (memory/LOLBins — needs EDR, not signatures).
- Wireless: rogue AP (unauthorised) vs evil twin (spoofed SSID) · deauth/disassociation (beaten by
  802.11w) · bluejacking (push) vs bluesnarfing (theft) · disable WPS.
- Credential attacks: brute force (one account, many guesses) · spraying (many accounts, few
  guesses) · stuffing (breached pairs reused) · rainbow tables (beaten by salting).
- Supply-chain vectors: software update · hardware implant · MSP/service provider · open-source
  dependency. Mitigations: due diligence, SBOM, code signing, least-privilege vendor access.
- Vuln scan outputs: false positive (wasted effort) vs false negative (missed attack — the
  dangerous one). Credentialed scans see more; KEV listing outranks raw CVSS.

**Exam traps:**
- XSS abuses the *user's* trust in the site; CSRF abuses the *site's* trust in the user's browser.
- APT ≠ nation-state only — funded criminal groups qualify.
- A CVSS 7.5 on KEV (actively exploited) outranks a CVSS 9.8 with no exploit.
- Zero-day defence is behavioural detection + defence in depth — never signatures.
- Missing logs are an *indicator*, not an IT hiccup.
- Passive recon leaves no logs on the target — you cannot detect what never touched you.

---

## Scenario bank — situation → action

Ten decision-format questions, distinct from the drills above and from
[soc-scenarios](../scenarios/soc-scenarios.md). Format: situation → what do you do? → correct
action → why → portfolio link.

**1. The one-letter package**
- **Situation:** A build pipeline pulls `pyt0rch-utils` — a package one character off a popular
  library, published last week, already in three internal projects.
- **What do you do?** Classify the threat and respond.
- **Correct action:** Treat as **typosquatting / open-source supply chain** compromise: freeze the
  pipeline, remove the package, audit what it did (exfil? credentials?), then enforce dependency
  pinning, an internal registry/allow-list, and SBOM generation.
- **Why:** Attackers publish lookalike packages precisely because one developer typo grants code
  execution inside your build. Trust in a name is not verification.
- **Portfolio link:** [oracle](../../oracle)'s discipline — validate the artefact before trusting
  it — is the same instinct the dependency chain needs.

**2. The parcel that costs £1.99**
- **Situation:** Staff report SMS messages: "Your parcel is held — pay £1.99" with a shortened
  link. Two admit entering their corporate password on the resulting page (it "looked like the
  company portal").
- **What do you do?** Name the attack and run the response.
- **Correct action:** **Smishing** with credential harvesting: force-reset both accounts, check
  for logins since the click (impossible travel, new MFA enrolments), block the domain, alert all
  staff, and report the URL.
- **Why:** Mobile screens hide URL detail and shortened links defeat inspection — assume harvested
  credentials are already being replayed; speed of reset beats analysis here.
- **Portfolio link:** [mirage](../../mirage) studies exactly these channels (phishing/smishing/
  vishing) and the urgency-plus-small-amount lever this lure uses.

**3. The forum everyone reads**
- **Situation:** EDR flags drive-by exploit attempts on four engineers' laptops within an hour.
  All four had visited the same niche industry forum that morning.
- **What do you do?** Identify the technique and respond beyond the four hosts.
- **Correct action:** Treat as a **watering hole** attack: isolate/scan the four hosts, block the
  forum at web filtering, hunt for the same IOCs estate-wide, and notify the forum operator.
  Patch level and EDR coverage decide who survived.
- **Why:** Watering holes compromise a site the *target group* trusts — the four alerts are a
  sample, not the population; anyone who visited is in scope.
- **Portfolio link:** [nullbyte](../../nullbyte) confines browsing to low-trust compartments —
  per-profile isolation is the architectural answer to "a trusted site turned hostile".

**4. `' OR 1=1--` in the logs**
- **Situation:** WAF logs show a burst of requests against the login endpoint containing
  `' OR 1=1--` and UNION SELECT strings, all returning HTTP 403.
- **What do you do?** Classify and decide whether 403 means "done".
- **Correct action:** **SQL injection** probing: confirm the WAF blocked *all* variants (not just
  these), verify the application itself uses parameterised queries, and hunt for any 200 responses
  to similar payloads before/after the burst.
- **Why:** A WAF is a compensating control, not the fix — the fix is in the code. Blocked probes
  also tell you you're being actively targeted; the attacker's next payload may not match the rule.
- **Portfolio link:** [spectre](../../spectre)'s method applies: verify the finding, map it to its
  CWE (here CWE-89), and fix root cause rather than trusting the front-line filter.

**5. The server that got slow**
- **Situation:** A batch server's CPU has sat at 100% for days. You find an unfamiliar process
  named `kworkerd` (not a real kernel thread) connecting to a mining pool on port 3333.
- **What do you do?** Classify and respond.
- **Correct action:** **Cryptomining malware** (resource-consumption indicator): isolate, capture
  the binary and persistence mechanism, find the entry vector (often an unpatched service or
  stolen SSH key), eradicate, patch, and watch for re-infection.
- **Why:** Cryptominers are low-noise by design — sustained anomalous resource use IS the
  indicator. The miner also proves an attacker had execution; the same door admits worse payloads.
- **Portfolio link:** [ironveil](../../ironveil)'s minimal-services baseline is what makes an
  imposter process stand out — you can't spot anomalies without a known-good normal.

**6. Clean scan, dirty host**
- **Situation:** A host behaves erratically; connections appear in firewall logs that local tools
  don't show. The installed AV reports the system clean.
- **What do you do?** Reconcile the contradiction.
- **Correct action:** Suspect a **rootkit**: examine the host from *outside* its OS — boot from
  trusted media, compare external network captures against local netstat output, image the disk
  for offline analysis. Rebuild from known-good rather than "cleaning".
- **Why:** A kernel-level rootkit controls the APIs the AV asks — the OS is lying. Visibility must
  come from a layer the attacker doesn't own.
- **Portfolio link:** [nullbyte](../../nullbyte)'s verified boot is the architectural counter: a
  hardware root of trust validates the OS before it can lie to you.

**7. The leaving admin's parting gift**
- **Situation:** During offboarding checks on a departing (and disgruntled) admin, you find a
  scheduled task created last month: on the 1st of next month it deletes the finance share.
- **What do you do?** Classify and scope the response.
- **Correct action:** A **logic bomb** (insider threat): disable it, preserve it as evidence,
  then audit *everything* that account touched — one discovered implant means the search is for
  the second one. Involve HR/legal; tighten offboarding to same-day access revocation.
- **Why:** Logic bombs weaponise legitimate access plus time delay. Discovery of one device is
  the start of the investigation, not the end.
- **Portfolio link:** [spectre](../../spectre)'s hash-verified session logs model the evidence
  discipline this investigation needs — provable, timestamped, tamper-evident records.

**8. The crash that's more than a crash**
- **Situation:** A legacy in-house service crashes whenever a request field exceeds ~1,000
  characters. A developer calls it "just a stability bug".
- **What do you do?** Reframe the risk and respond.
- **Correct action:** Treat as a probable **buffer overflow**: a crash on long input is the
  canonical symptom, and what crashes today may execute shellcode tomorrow. Confirm DEP/ASLR are
  enabled, get the input-handling code fixed (bounds checking), and restrict network exposure
  meanwhile.
- **Why:** The distance between denial-of-service and code execution is attacker skill, not your
  controls. MS17-010 was "just" an SMB parsing bug.
- **Portfolio link:** [gauntlet](../../gauntlet)'s Blue writeup walks exactly that path — an SMBv1
  buffer overflow from crash-class bug to SYSTEM shell.

**9. DNS that's too chatty**
- **Situation:** DNS logs show one workstation making thousands of queries for long, random-looking
  subdomains of a single external domain — `a8f3e2...x91.example-cdn.net` — at a steady rate.
- **What do you do?** Identify the channel and respond.
- **Correct action:** **DNS tunnelling** (exfiltration or C2 over port 53): block/sinkhole the
  domain, isolate the workstation, estimate exfil volume from query count × payload size, and
  identify what data the host could reach.
- **Why:** DNS is allowed outbound almost everywhere, so attackers encode data in queries. High-
  entropy subdomains at machine-regular intervals are the signature; resolvers that log are the
  detection point.
- **Portfolio link:** [ironveil](../../ironveil) routes every DNS query through a logging,
  filtering resolver (AdGuard Home) before it leaves the host — precisely the visibility this
  detection depends on.

**10. The scanner's red wall**
- **Situation:** This month's scan: 14 criticals on an isolated dev box, and one medium-severity
  finding on the internet-facing payment server — which CISA added to KEV yesterday.
- **What do you do?** Order the remediation queue.
- **Correct action:** Patch the payment server's KEV-listed medium **first**. The dev-box
  criticals follow, prioritised by exposure and asset value.
- **Why:** Priority = severity × exposure × exploitability × asset criticality — not raw CVSS.
  Actively-exploited beats theoretical; internet-facing beats isolated; payment beats dev.
- **Portfolio link:** [spectre](../../spectre) ranks findings the same way — qualitative
  likelihood × impact per finding, not a single scanner number.
