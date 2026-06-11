# SY0-701 Acronym Master List

Comprehensive A–Z of acronyms appearing across the domain notes. SY0-701 tests acronym
recognition heavily, and the exam's own acronym appendix is large. Each entry: expansion,
one-line definition, primary domain, and any easily-confused alternative.

For the high-yield *disambiguation* pairs (the ones the exam deliberately confuses), see also the
tighter list in `domains/sy0-701-exam-tips.md` — this file is the broad reference; that one is the
trap-focused subset.

| Acronym | Expansion | One-line definition | Domain | Easily confused with |
|---------|-----------|---------------------|--------|----------------------|
| AAA | Authentication, Authorization, Accounting | The access-control framework | D1/D4 | — |
| ABAC | Attribute-Based Access Control | Access by evaluated attributes/policy | D4 | RBAC (by role), DAC, MAC |
| ACL | Access Control List | Ordered allow/deny rules | D3/D4 | capability list |
| AES | Advanced Encryption Standard | Symmetric block cipher (128/192/256) | D1 | RSA (asymmetric) |
| ALE | Annualised Loss Expectancy | SLE × ARO | D5 | SLE, ARO |
| AP | Access Point | Wireless network attachment point | D2/D3 | evil twin = rogue AP |
| API | Application Programming Interface | Service interface; attack surface for microservices | D3 | — |
| APT | Advanced Persistent Threat | Stealthy, well-resourced, long-dwell actor | D2 | script kiddie |
| ARO | Annualised Rate of Occurrence | Expected events per year | D5 | ARP (networking) |
| ARP | Address Resolution Protocol | IP→MAC mapping; poisoning enables MITM | D2 | ARO |
| ASLR | Address Space Layout Randomization | Randomises memory layout vs exploits | D3 | DEP |
| BYOD | Bring Your Own Device | User-owned device, managed container | D4 | COPE, CYOD |
| CA | Certificate Authority | Issues/signs digital certificates | D1 | RA, OCSP responder |
| CASB | Cloud Access Security Broker | Policy/visibility broker for cloud apps | D3 | CSPM |
| CER | Crossover Error Rate (=EER) | Biometric point where FAR=FRR | D1 | FAR, FRR |
| CIS | Center for Internet Security | Publishes hardening benchmarks | D5 | NIST, ISO |
| COPE | Corporate-Owned, Personally Enabled | Org device, personal use allowed | D4 | BYOD, CYOD |
| CRL | Certificate Revocation List | List of revoked certs (pull model) | D1 | OCSP (query model) |
| CSPM | Cloud Security Posture Management | Continuous cloud misconfiguration detection | D3 | CASB |
| CSRF | Cross-Site Request Forgery | Abuses site's trust in the user's browser | D2 | XSS (browser trusts site) |
| CVE | Common Vulnerabilities and Exposures | Catalogued specific vulnerability | D2 | CWE (class) |
| CVSS | Common Vulnerability Scoring System | Severity score 0–10 | D2 | CVE |
| CWE | Common Weakness Enumeration | Class of weakness (e.g. CWE-548) | D2 | CVE (instance) |
| CYOD | Choose Your Own Device | Org device from an approved list | D4 | BYOD, COPE |
| DAC | Discretionary Access Control | Owner sets permissions | D4 | MAC, RBAC |
| DDoS | Distributed Denial of Service | Many-source availability attack | D2 | DoS (single source) |
| DEP | Data Execution Prevention | Marks memory non-executable | D3 | ASLR |
| DKIM | DomainKeys Identified Mail | Cryptographic signature on email | D4 | SPF, DMARC |
| DLP | Data Loss Prevention | Detects/blocks data exfiltration | D4 | DRM |
| DMARC | Domain-based Message Auth, Reporting & Conformance | Email policy using SPF+DKIM alignment | D4 | SPF, DKIM |
| DNSSEC | DNS Security Extensions | Authenticity/integrity of DNS records (not confidentiality) | D3 | DoH/DoT (confidentiality) |
| DoS | Denial of Service | Availability attack from one source | D2 | DDoS |
| DRP | Disaster Recovery Plan | Restore operations after a disaster | D5 | BCP (broader) |
| EAP | Extensible Authentication Protocol | 802.1X auth framework (EAP-TLS etc.) | D4 | RADIUS (carries it) |
| EDR | Endpoint Detection and Response | Behaviour-based endpoint detection | D4 | EPP, XDR |
| EER | Equal Error Rate (=CER) | Biometric FAR=FRR crossover | D1 | FAR/FRR |
| FAR | False Acceptance Rate | Impostors accepted (security risk) | D1 | FRR |
| FIM | File Integrity Monitoring | Alerts on unauthorised file change | D4 | DLP |
| FRR | False Rejection Rate | Legitimate users rejected (usability) | D1 | FAR |
| GDPR | General Data Protection Regulation | EU data-protection law | D5 | — |
| HIDS | Host Intrusion Detection System | Detection on the endpoint | D4 | NIDS |
| HSM | Hardware Security Module | Tamper-resistant key storage/crypto | D1 | TPM (per-device) |
| IaaS | Infrastructure as a Service | Cloud VMs/storage/network | D3 | PaaS, SaaS |
| IaC | Infrastructure as Code | Declarative, version-controlled infra | D3 | SOAR (security automation) |
| IAM | Identity and Access Management | Manages identities + entitlements | D4 | PAM (privileged subset) |
| IoA | Indicator of Attack | Behavioural sign of ongoing attack | D2 | IoC |
| IoC | Indicator of Compromise | Forensic evidence of breach | D2 | IoA |
| IPS/IDS | Intrusion Prevention/Detection System | Blocks vs alerts on malicious traffic | D4 | HIDS/NIDS |
| ISO | International Organization for Standardization | 27001/27002 security standards | D5 | NIST, CIS |
| LDAP | Lightweight Directory Access Protocol | Directory queries (often AD) | D4 | Kerberos |
| MAC | Mandatory Access Control | System-enforced labels (e.g. SELinux) | D4 | DAC; also Media Access Control |
| MDM | Mobile Device Management | Enforces mobile policy / remote wipe | D4 | UEM (broader) |
| MFA | Multi-Factor Authentication | ≥2 distinct factor types | D1/D4 | 2SV (same factor twice) |
| MTBF | Mean Time Between Failures | Reliability of repairable systems | D3 | MTTF (non-repairable) |
| MTTD | Mean Time To Detect | Detection latency | D4 | MTTR |
| MTTR | Mean Time To Repair/Recover | Recovery latency | D3/D4 | MTTD |
| MTD | Maximum Tolerable Downtime | RTO must be ≤ MTD | D3 | RTO |
| NAC | Network Access Control | Posture-checks devices before access | D4 | 802.1X (mechanism) |
| NIDS | Network Intrusion Detection System | Detection on network traffic | D4 | HIDS |
| NIST | National Institute of Standards and Technology | CSF, 800-series guidance | D5 | ISO, CIS |
| OCSP | Online Certificate Status Protocol | Real-time cert status query | D1 | CRL (list/pull) |
| OT/ICS | Operational Technology / Industrial Control Systems | Plant/process control; availability-first | D3 | IT |
| PaaS | Platform as a Service | Cloud app platform/runtime | D3 | IaaS, SaaS |
| PAM | Privileged Access Management | Vaulting + JIT for admin accounts | D4 | IAM (broader) |
| PKI | Public Key Infrastructure | CAs, certs, trust chains | D1 | — |
| RA | Registration Authority | Vets requests before the CA issues | D1 | CA |
| RADIUS | Remote Authentication Dial-In User Service | AAA server for 802.1X/network auth | D4 | TACACS+ (device admin) |
| RBAC | Role-Based Access Control | Access by job role | D4 | ABAC, DAC, MAC |
| RPO | Recovery Point Objective | Max tolerable data loss | D3 | RTO |
| RTO | Recovery Time Objective | Max tolerable downtime | D3 | RPO |
| SaaS | Software as a Service | Fully-managed cloud application | D3 | IaaS, PaaS |
| SAE | Simultaneous Authentication of Equals | WPA3-Personal handshake (anti-offline-crack) | D4 | PSK (WPA2) |
| SAML | Security Assertion Markup Language | XML SSO/federation assertions | D4 | OAuth, OIDC |
| SAST/DAST | Static / Dynamic Application Security Testing | Source review vs running-app probing | D4 | — |
| SASE | Secure Access Service Edge | SD-WAN + cloud security converged | D3 | SSE |
| SBOM | Software Bill of Materials | Inventory of software components | D2/D5 | — |
| SCAP | Security Content Automation Protocol | Automated compliance/benchmark scanning | D4 | — |
| SIEM | Security Information and Event Management | Log aggregation/correlation/alerting | D4 | SOAR |
| SLA | Service Level Agreement | Contracted service commitment | D5 | MOU, SOW |
| SLE | Single Loss Expectancy | Asset Value × Exposure Factor | D5 | ALE, ARO |
| SOAR | Security Orchestration, Automation and Response | Automated response atop SIEM | D4 | SIEM, IaC |
| SPF | Sender Policy Framework | Authorised sending hosts for a domain | D4 | DKIM, DMARC |
| SSO | Single Sign-On | One auth → many services | D4 | federation |
| STIX | Structured Threat Information eXpression | Threat-intel data format | D2 | TAXII (transport) |
| TAXII | Trusted Automated eXchange of Indicator Information | Threat-intel transport protocol | D2 | STIX (format) |
| TACACS+ | Terminal Access Controller Access-Control System Plus | AAA for device administration | D4 | RADIUS (network access) |
| TEE | Trusted Execution Environment | Isolated secure processing area | D1/D3 | HSM, TPM |
| TPM | Trusted Platform Module | On-board key storage / attestation | D1 | HSM (standalone) |
| UEBA | User and Entity Behaviour Analytics | Anomaly detection on users/entities | D4 | SIEM |
| VLAN | Virtual LAN | Logical network segmentation | D3 | subnet |
| WAF | Web Application Firewall | Filters HTTP attacks (SQLi/XSS) | D3/D4 | NGFW |
| WPA2/WPA3 | Wi-Fi Protected Access 2/3 | Wireless security; WPA3 adds SAE | D4 | WEP (broken) |
| XDR | Extended Detection and Response | Cross-layer detection (endpoint+network+cloud) | D4 | EDR (endpoint only) |
| XSS | Cross-Site Scripting | Injects script; abuses browser trust in site | D2 | CSRF |

> Study tip: cover the right three columns and recall them from the acronym alone — then cover the
> acronym and produce it from the definition. The exam tests both directions. Pair with
> `STUDY_SCHEDULE.md` Week 6 (acronym + trap review).
