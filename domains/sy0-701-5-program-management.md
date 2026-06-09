# SY0-701 Domain 5 — Security Program Management & Oversight (20%)

Maps to classic notes in [5.0-risk-management.md](5.0-risk-management.md) with expanded
governance, compliance, and third-party coverage.

---

## 1. Risk management (deep)

### Risk fundamentals

**Risk = likelihood × impact** (of a threat exploiting a vulnerability against an asset)

**Risk treatment options:**
- **Mitigate / reduce:** apply controls to lower likelihood or impact.
- **Transfer / share:** insurance, outsourcing, contracts. Transfers financial consequences, not liability.
- **Avoid:** stop the risky activity entirely.
- **Accept:** formally acknowledge and document the risk within appetite. Requires explicit sign-off.

**Key risk terms:**
- **Inherent risk:** risk before any controls are applied.
- **Residual risk:** risk remaining after controls are applied.
- **Risk appetite:** how much risk an organisation is willing to accept in pursuit of objectives.
- **Risk tolerance:** the acceptable variance above/below the risk appetite threshold.
- **Risk register:** living document tracking all identified risks, their owners, scores, treatment
  status, and review dates.

### Quantitative risk assessment (know the formulas)

| Formula | Meaning |
|---------|---------|
| **SLE = AV × EF** | Single Loss Expectancy = Asset Value × Exposure Factor (% of asset lost per incident) |
| **ALE = SLE × ARO** | Annualised Loss Expectancy = SLE × Annualised Rate of Occurrence |
| **Control justification** | Annual cost of control < reduction in ALE it delivers |

**Example:** Asset value £100,000. EF = 0.40 (40% of asset destroyed per incident). ARO = 0.5 (occurs once every two years).
- SLE = £100,000 × 0.40 = £40,000
- ALE = £40,000 × 0.5 = £20,000
- A control costing £5,000/year that halves ALE (saves £10,000/year) is cost-justified.

**Qualitative:** likelihood and impact rated Low/Medium/High; plotted on a **risk matrix / heat map**.
Faster and cheaper than quantitative; more subjective; used when hard figures are unavailable.

> Portfolio link: [spectre](../../spectre) used OWASP qualitative likelihood × impact scoring
> for finding severity. The ALE formulas apply when assigning remediation budget priority.

---

## 2. Security frameworks

| Framework | Purpose | Key structure |
|-----------|---------|---------------|
| **NIST CSF** (v1.1/v2.0) | Voluntary cyber risk framework | **Identify → Protect → Detect → Respond → Recover** (five functions); high-yield exam |
| **NIST RMF** (SP 800-37) | Federal system risk management process | Categorize → Select → Implement → Assess → Authorize → Monitor |
| **NIST SP 800-53** | Control catalogue for federal systems | Families: AC, AU, CA, CM, IA, IR, MA, MP, PE, PL, RA, SA, SC, SI, SR |
| **ISO/IEC 27001** | ISMS certification standard | Annex A controls; PDCA improvement cycle |
| **ISO/IEC 27002** | Control implementation guidance for 27001 | 93 controls in 4 themes (Organisational, People, Physical, Technological) |
| **CIS Controls** (v8) | Prioritised 18 implementation groups | IG1 (essential), IG2 (intermediate), IG3 (advanced) |
| **COBIT** | IT governance and management | Focus on aligning IT with business objectives |
| **PCI DSS** | Payment card data security | 12 requirements; applies if you handle card data |
| **MITRE ATT&CK** | Adversary TTP knowledge base | Tactics, techniques, sub-techniques; use for threat modelling and detection rule development |
| **SOC 2** | Service-organisation trust reporting | Based on Trust Service Criteria (TSC) |

**Exam focus:** NIST CSF five functions are highest-yield. ISO 27001 vs 27002 distinction (standard vs guidance). CIS controls as a prioritised implementation guide.

> Portfolio link: [spectre](../../spectre) maps countermeasures to **ISO/IEC 27002:2022** and
> **CIS Apache 2.4 Benchmark** — a direct demonstration of framework-driven assessment.

---

## 3. Compliance and regulations

### Key regulations

**GDPR (General Data Protection Regulation):**
- EU and UK law governing personal data of EU/UK residents.
- Principles: lawfulness/fairness/transparency, purpose limitation, data minimisation, accuracy,
  storage limitation, integrity/confidentiality, accountability.
- Key rights: access (DSARs), rectification, erasure ("right to be forgotten"), portability, objection.
- **Breach notification:** within 72 hours to the supervisory authority; without undue delay to affected individuals if high risk.
- **DPO (Data Protection Officer):** required for certain organisations (large-scale processing, special category data, public authorities).
- **Data transfers outside EEA:** require adequacy decision, SCCs, or binding corporate rules.
- Penalties: up to €20M or 4% of global annual turnover (whichever is higher).

**Other regulations to recognise:**
- **HIPAA (US):** health information protection; covered entities + business associates.
- **PCI DSS:** card payment security; 12 requirements; fines for non-compliance.
- **SOX (Sarbanes-Oxley, US):** financial reporting integrity; IT controls for financial systems.
- **CCPA (California):** California consumer privacy; similar principles to GDPR.

**Data sovereignty:** data subject to the laws of the country where it is stored or processed.
**Data residency:** contractual or regulatory requirement that data stays within a specific geography.

---

## 4. Data governance and privacy roles

| Role | Responsibility |
|------|---------------|
| **Data owner** | Business decision-maker responsible for a dataset; decides classification, retention, sharing |
| **Data controller** | Decides the purpose and means of processing (GDPR concept) |
| **Data processor** | Processes data on the controller's behalf (cloud provider, payroll processor) |
| **Data custodian / steward** | Day-to-day handling, operational responsibility for data security |
| **DPO** | Independent advisory role; ensures GDPR compliance; not decision-maker |

**Data lifecycle:** classification → handling → storage → retention → secure disposal/sanitisation.

**Secure disposal / sanitisation:**
- **Deletion:** marks space as available but does not erase data (recovery possible).
- **Wiping / overwriting:** writes over data multiple times (DoD 5220.22-M pattern).
- **Crypto-erase:** destroys the encryption key; encrypted data becomes unrecoverable. Fast; used for FDE volumes.
- **Degaussing:** magnetic field destroys data on magnetic media. Does not work on SSDs/flash.
- **Physical destruction / shredding:** definitive; used for classified media or when other methods are insufficient.

---

## 5. Third-party and supply-chain risk

**Why third-party risk matters:** your security posture is only as strong as your weakest partner.
A breach at a supplier can expose your data (e.g. SolarWinds supply-chain attack).

**Due diligence process:**
1. Vendor questionnaire / security assessment
2. Review certifications (ISO 27001, SOC 2 Type II)
3. Contractual requirements (right to audit, minimum security standards, breach notification SLA)
4. Continuous monitoring (threat intel, public breach notifications)

**Agreement types:**

| Agreement | Purpose |
|-----------|---------|
| **SLA** (Service Level Agreement) | Defines service performance levels and remedies |
| **NDA** (Non-Disclosure Agreement) | Protects confidential information shared with third parties |
| **MOU/MOA** (Memorandum of Understanding/Agreement) | Informal; documents intent and shared understanding |
| **BPA** (Business Partnership Agreement) | Formal terms for a business relationship |
| **ISA** (Interconnection Security Agreement) | Governs security requirements for network interconnections |
| **DPA** (Data Processing Agreement) | GDPR requirement; governs how a processor handles personal data |

**Fourth-party risk:** your vendor's vendors. If your cloud provider relies on a software component
from a supplier you've never assessed, their breach is your exposure.

**EOL/EOSL risk:** software or hardware with no vendor support is unpatched by definition. Assess
and plan to replace before support ends.

**SBOM (Software Bill of Materials):** inventory of all components in a software product, including
open-source libraries. Essential for supply-chain risk management. Mandated in some US government contracts.

---

## 6. Audits, assessments, and reporting

### Audit vs assessment distinction

| | Audit | Assessment |
|---|-------|-----------|
| Goal | Checks conformance to a defined standard | Evaluates security posture and risk broadly |
| Outcome | Pass/fail against each control | Findings, recommendations, risk rating |
| Assurance | Typically higher if external/independent | Varies |
| Example | SOC 2 Type II audit | Vulnerability assessment, red team assessment |

**Internal vs external:** external/independent audits carry more weight (no conflict of interest).

**SOC 2 reports:**
- **Type I:** controls were suitably *designed* at a specific point in time.
- **Type II:** controls were *operating effectively* over a period (typically 6–12 months).
  Type II is much more valuable — it proves sustained control operation, not just design.

**Attestation:** formal third-party statement confirming compliance or effectiveness.
**Right to audit clause:** contractual right to audit a third party on demand.

### Security testing types

| Type | Description | Exam note |
|------|-------------|-----------|
| Vulnerability assessment | Identifies and categorises vulnerabilities | No exploitation |
| Penetration test (black/grey/white box) | Exploits to prove impact | Grey-box combines internal knowledge with external testing |
| Red team | Simulates full APT campaign over extended period | Tests detection + response, not just prevention |
| Blue team | Defenders operating the SIEM/SOC | Real-time detection and response |
| Purple team | Red and blue working together to improve controls | Fastest improvement cycle |
| Tabletop exercise | Discussion-based scenario walkthrough | No live systems; tests process and decision-making |
| Bug bounty | External researcher programme; reward for reported vulnerabilities | Continuous, crowd-sourced testing |

---

## 7. Security awareness and the human element

- **Phishing simulations:** send simulated phishing emails; track click rate; provide immediate
  teachable moment to users who click.
- **Role-based training:** different content for different roles (executives get CEO-fraud training;
  developers get secure-coding training).
- **Security culture metrics:** repeat clicker rate, report rate, completion rate of mandatory training.
- **Gamification:** leaderboards, badges — increases engagement with training.
- **Recognition of indicators:** teach users to recognise urgency/authority manipulation, suspicious
  sender addresses, unexpected attachments, out-of-band requests for payments or credentials.

> Portfolio link: [mirage](../../mirage) is the research evidence base for why awareness training
> must address causal mechanisms (urgency/authority/trust), not just surface symptoms like poor
> grammar. The research finding — models miss multi-hop causal chains — directly informs training
> programme design.

---

## 8. Metrics, KPIs, and risk reporting

| Metric | Description |
|--------|-------------|
| **MTTD** (Mean Time to Detect) | Average time from incident start to detection |
| **MTTR** (Mean Time to Respond/Recover) | Average time from detection to containment/resolution |
| **Dwell time** | Time attacker was present in the environment before detection (MTTD equivalent) |
| **Alert volume / FP rate** | Total alerts and proportion that are false positives |
| **Patch latency** | Days from vulnerability disclosure to patch deployment |
| **% assets at baseline** | Proportion meeting hardened configuration standard |
| **KRI** (Key Risk Indicator) | Leading indicator that a risk is rising (e.g. rising failed-login rate) |
| **KPI** (Key Performance Indicator) | Measures performance against a target (e.g. MTTD < 60 minutes) |

**KRI vs KPI:** KRI is a *leading* signal (it precedes an event); KPI is a *performance* measure
(it tells you how well you performed against a target). Track both.

**Reporting up:** security metrics must be translated into business risk language for the board
and executive team. "CVSS 9.8" means nothing to a CFO; "risk of £X loss within 12 months" does.

---

## 9. Policies and governance

| Policy | Purpose |
|--------|---------|
| **AUP** (Acceptable Use Policy) | Defines permitted and prohibited use of systems and data |
| **Information security policy** | Top-level governance document; delegates to sub-policies |
| **Clean desk / clear screen** | Physical and digital information control |
| **BYOD / MDM policy** | Governs personal device use for work |
| **Data classification policy** | How data is classified, handled, and retained |
| **Change management policy** | Controls changes to production systems (CAB, change windows, rollback plans) |
| **Incident response policy** | Mandates the IR process, roles, escalation |

---

### Quick self-test
- ALE formula end-to-end: AV × EF = SLE; SLE × ARO = ALE. Calculate for: AV=£200K, EF=0.30, ARO=0.25.
- NIST CSF five functions — name them in order.
- Audit vs assessment — which checks conformance, which evaluates posture?
- SOC 2 Type I vs Type II — what is the key difference?
- Data controller vs data processor under GDPR — who decides the purpose?
- GDPR breach notification — to whom and within what timeframe?
- KRI vs KPI — which is a leading indicator of rising risk?
- Why does an SBOM matter for supply-chain risk?
- Crypto-erase vs degaussing — which works on SSDs and why?
