


# Cybersecurity News and Reports


Now I have comprehensive cybersecurity news and reports. Let me compile this into a structured report with the most current and relevant information.


## Cybersecurity News and Reports


### Critical Patch Tuesday Vulnerabilities


**Microsoft November 2025 Security Update** represents a significant threat landscape with 63 vulnerabilities addressed, including one actively exploited zero-day in the wild. The release demonstrates the ongoing urgency of vulnerability management in enterprise environments. Among these vulnerabilities, five are rated as **Critical** severity, with the exploited zero-day being particularly noteworthy.[^1_1][^1_2][^1_3][^1_4]


The most critical vulnerability is **CVE-2025-62215** — a Windows Kernel race condition enabling elevation of privilege. This zero-day is actively being exploited in real-world attacks, requiring immediate patching across Windows 10, 11, and Server editions. Other critical issues include use-after-free bugs in Microsoft Office (CVE-2025-62199) leading to remote code execution, and heap-based buffer overflows in GDI+ (CVE-2025-60724) permitting network-based code execution.[^1_1]


Beyond Microsoft, the broader patch ecosystem includes critical vulnerabilities across multiple vendors. **Samsung mobile devices face critical risk** with CVE-2025-21042, a remote code execution zero-day exploited in the wild to distribute LANDFALL spyware on Galaxy devices in the Middle East. This vulnerability was actively exploited for months after Samsung's April 2025 patch, highlighting the lag between vulnerability disclosure and real-world security posture improvements.[^1_5][^1_6]



| Vulnerability | Impact | Status |
| :-- | :-- | :-- |
| CVE-2025-62215 | Windows Kernel EoP | Actively Exploited[^1_1] |
| CVE-2025-62199 | Office RCE | Critical[^1_1] |
| CVE-2025-60724 | GDI+ Buffer Overflow | Critical[^1_1] |
| CVE-2025-21042 | Samsung RCE | Actively Exploited[^1_5] |


### Ransomware Escalation and Major Incidents


**Qilin ransomware has emerged as the year's dominant threat**, claiming over 700 victims by late October 2025—already surpassing 2024's leading strain RansomHub which recorded 547 incidents. This 280% surge correlates with Qilin's ransomware-as-a-service (RaaS) business model attracting affiliates after RansomHub went dark in April 2025.[^1_7]


Qilin's targeting patterns reveal sophisticated sector prioritization: businesses account for 590 attacks (75 confirmed), government entities 40 attacks (22 confirmed), healthcare 45 attacks (14 confirmed), and education 26 attacks (7 confirmed). Year-over-year, education saw a 420% increase in Qilin activity, followed by government agencies at 344%. The group has stolen 116 terabytes of data overall, with 47 terabytes linked to confirmed incidents.[^1_7]


Major confirmed incidents include the **Habib Bank AG Zurich breach**, where Qilin claimed theft of 2.5 terabytes of data and nearly two million files including customer details, transaction records, and source code. Geographic concentration shows the United States leading with 375 attacks, followed by France (41), Canada (39), South Korea (33), and Spain (26).[^1_8][^1_7]


Additional significant ransomware activity includes **RansomHouse's attack on Japanese retailer Askul** in October 2025, exposing customer and supplier data after disrupting e-commerce operations, and the **Qantas data leak** affecting 5.7 million customers through a Salesforce platform compromise, with hackers publishing the data after a ransom deadline expired.[^1_8]


### Data Breaches and Supply Chain Compromises


**Software supply chain attacks reached unprecedented levels in October 2025**, with 41 incidents recorded—more than 30% higher than the previous April peak. This represents a fundamental shift in attack targeting, with threat actors focusing on weakest links in vendor ecosystems. Cyble data shows supply chain attacks have averaged over 28 per month since April 2025, more than double the 13 monthly average from early 2024 through March.[^1_9]


High-profile supply chain incidents include **Red Hat's breach by the Crimson Collective**, stealing approximately 570GB of compressed data from over 28,000 internal repositories, including 800 Customer Engagement Reports with infrastructure details and credentials tied to enterprise clients. Additionally, **Salesloft's GitHub compromise** led to the extraction of OAuth tokens subsequently exploited to access Salesforce instances, resulting in theft of 1.5 billion records from 760 organizations including Google, Zscaler, and Cloudflare.[^1_10][^1_8]


The **GhostAction supply chain attack** exfiltrated approximately 3,325 secrets including PyPI/npm tokens, GitHub credentials, Cloudflare and AWS keys, and database credentials, risking trojanized package releases and widespread credential compromise.[^1_10]


### AI-Driven Threats and Advanced Attacks


**AI-enabled supply chain attacks surged 156% as breaches grew harder to detect**, representing a critical emerging threat vector. Google researchers have identified at least five malware families using AI to reinvent themselves and evade defender detection. These AI-powered threats include FRUITSHELL, PROMPTSTEAL, QUIETVAULT, and PROMPTFLUX families that dynamically alter behavior mid-execution, complicating detection and response.[^1_11][^1_12][^1_13]


Nation-state actors are increasingly leveraging AI capabilities. The **Chinese state-sponsored APT group Silk Typhoon confirmed breaching the US Congressional Budget Office**, resulting in unauthorized access to sensitive communications and draft reports. Researchers have identified **Phantom Taurus**, a highly sophisticated Chinese nexus APT using custom, evasive malware to bypass traditional defenses and target high-value organizations.[^1_14][^1_12]


### Critical Infrastructure and Operational Technology Vulnerabilities


Critical infrastructure faces escalating risks with **power blackouts in Spain and Portugal in April 2025** demonstrating the real-world consequences of OT security gaps. The underlying challenge involves operational technology systems designed for efficiency rather than security, now increasingly interconnected yet often under-monitored, unpatched, and unsegmented.[^1_15]


The **UK National Crime Agency reported 429 cyber attacks between September 2024 and August 2025**, with 204 classified as "nationally significant"—more than double the previous year—and 18 ranked "highly significant" impacting government, essential services, or the economy. These trends underscore the need for continuous monitoring capabilities and zero-trust approaches to hardware security.[^1_16]


### Cloud Security and Identity Vulnerabilities


Cloud environments present expanding attack surfaces with **32% of cloud assets in neglected state** and an average of 115 vulnerabilities per cloud asset, according to the 2025 State of Cloud Security Report. Critically, **76% of organizations have at least one public-facing asset enabling lateral movement**, and 13% have at least one cloud asset supporting over 1,000 attack paths.[^1_17]


AI adoption has introduced new vulnerabilities, with **84% of organizations now using AI in the cloud**, yet 62% have at least one vulnerable AI package in their cloud environment. Cloud misconfigurations remain a fundamental threat, accounting for approximately 15% of cybersecurity breaches, with 82% of misconfigurations attributed to human error.[^1_18][^1_17]


### Manufacturing Sector Under Siege


Manufacturing has become the most targeted industry for the third consecutive year, accounting for **22% of the 4,853 cyberattacks where sector attribution was possible**, according to Bitsight's 2025 State of the Underground report. Between 2024 and Q1 2025, manufacturing saw a 71% surge in threat actor activity, with 29 distinct groups targeting the sector.[^1_19]


The sector faces a tripartite threat: supply chain attacks exploiting weaker vendors for footholds into larger manufacturers, phishing as the top entry point for 90% of incidents, and open-source software vulnerabilities in supply chains. Production disruption through ransomware or operational technology compromise can cost manufacturers millions, with unplanned downtime accounting for approximately 11% of annual revenue for Fortune 500 companies—roughly \$1.5 trillion worldwide.[^1_19]


### Emerging Threat Intelligence


The **ESET APT Activity Report Q2-Q3 2025** documents increasing use of adversary-in-the-middle techniques by China-aligned APT groups including PlushDaemon, SinisterEye, Evasive Panda, and TheWizards. Gamaredon remained the most active APT targeting Ukraine, with noticeable increases in operational intensity coinciding with rare cooperation between Russia-aligned groups.[^1_20]


**OWASP has released its 2025 Top 10 list featuring two new security categories**, reflecting the evolving threat landscape and emerging vulnerabilities not previously prioritized. Security researchers continue identifying critical flaws in established platforms—Check Point Research documented researchers warning of vulnerabilities allowing manipulation of Microsoft Teams messages, where hackers could forge identities and alter message content.[^1_21][^1_11]


### Recommendations for Security Teams


Organizations should prioritize immediate patching of Microsoft Patch Tuesday vulnerabilities, particularly CVE-2025-62215 on Windows systems and critical Office flaws. Supply chain security requires enhanced visibility through software supply chain security (SSCS) tools—60% of large enterprises are already deploying such solutions, with Gartner predicting adoption will reach 85% by 2028.[^1_22]


Cloud security demands continuous asset monitoring, regular configuration audits, and implementation of zero-trust principles given the expanding attack surface and prevalence of lateral movement risks. Manufacturing organizations should segment OT networks, implement real-time monitoring, and maintain robust incident response plans accounting for operational disruption costs.[^1_17]


Human security awareness remains critical, as phishing continues to enable 90% of incidents and social engineering attacks target high-value organizations. The convergence of nation-state capabilities with financially motivated ransomware groups indicates threat actors are adapting tactics rapidly, necessitating continuous adaptation of detection and response strategies.[^1_19]
<span style="display:none">[^1_23][^1_24][^1_25][^1_26][^1_27][^1_28][^1_29][^1_30][^1_31][^1_32][^1_33][^1_34][^1_35][^1_36][^1_37][^1_38][^1_39][^1_40][^1_41][^1_42][^1_43][^1_44][^1_45][^1_46][^1_47][^1_48][^1_49][^1_50][^1_51][^1_52][^1_53][^1_54][^1_55][^1_56][^1_57][^1_58][^1_59][^1_60][^1_61][^1_62][^1_63][^1_64][^1_65][^1_66][^1_67][^1_68][^1_69][^1_70][^1_71][^1_72][^1_73][^1_74][^1_75][^1_76][^1_77][^1_78][^1_79][^1_80][^1_81][^1_82][^1_83][^1_84][^1_85][^1_86][^1_87][^1_88][^1_89][^1_90][^1_91][^1_92]</span>


<div align="center">⁂</div>


[^1_1]: https://cybersecuritynews.com/microsoft-november-2025-patch-tuesday/


[^1_2]: https://www.tenable.com/blog/microsofts-november-2025-patch-tuesday-addresses-63-cves-cve-2025-62215


[^1_3]: https://www.bleepingcomputer.com/news/microsoft/microsoft-november-2025-patch-tuesday-fixes-1-zero-day-63-flaws/


[^1_4]: https://www.securityweek.com/microsoft-patches-actively-exploited-windows-kernel-zero-day/


[^1_5]: https://www.malwarebytes.com/blog/news/2025/11/patch-now-samsung-zero-day-lets-attackers-take-over-your-phone


[^1_6]: https://unit42.paloaltonetworks.com/landfall-is-new-commercial-grade-android-spyware/


[^1_7]: https://industrialcyber.co/ransomware/qilin-ransomware-escalates-rapidly-in-2025-targeting-critical-sectors-with-700-attacks-amid-ransomhub-shutdown/


[^1_8]: https://www.brightdefense.com/resources/recent-data-breaches/


[^1_9]: https://industrialcyber.co/reports/software-supply-chain-attacks-surge-as-ransomware-groups-escalate-and-industrial-sectors-face-more-exposure/


[^1_10]: https://www.cm-alliance.com/cybersecurity-blog/sept-2025-biggest-cyber-attacks-ransomware-attacks-and-data-breaches


[^1_11]: https://www.cybersecuritydive.com


[^1_12]: https://radar.offseq.com/threat/10th-november-threat-intelligence-report-2c72c1ab


[^1_13]: https://thehackernews.com/2025/11/cisos-expert-guide-to-ai-supply-chain.html


[^1_14]: https://unit42.paloaltonetworks.com


[^1_15]: https://www.weforum.org/stories/2025/10/dangerous-blindspot-in-infrastructure-cybersecurity/


[^1_16]: https://www.cm-alliance.com/cybersecurity-blog/october-2025-biggest-cyber-attacks-ransomware-attacks-data-breaches


[^1_17]: https://orca.security/lp/2025-state-of-cloud-security-report/


[^1_18]: https://www.ijsat.org/research-paper.php?id=7823


[^1_19]: https://www.bitsight.com/blog/inside-cyber-threats-in-manufacturing-2025


[^1_20]: https://www.welivesecurity.com/en/eset-research/eset-apt-activity-report-q2-2025-q3-2025/


[^1_21]: https://cyberpress.org/owasp-releases-2025-top-10-list/


[^1_22]: https://www.veracode.com/blog/software-supply-chain-attacks-in-2025/


[^1_23]: https://linkinghub.elsevier.com/retrieve/pii/S0266613825003377


[^1_24]: https://journals.sagepub.com/doi/10.1177/08903344251379849


[^1_25]: http://www.thieme-connect.de/DOI/DOI?10.1055/a-2653-3284


[^1_26]: https://linkinghub.elsevier.com/retrieve/pii/S027823912500727X


[^1_27]: https://ufn.ru/en/articles/2025/11/l/


[^1_28]: https://journals.lww.com/10.1097/JCE.0000000000000697


[^1_29]: https://www.semanticscholar.org/paper/5a1a1c3d93359df0f764733f2928ea98caf01327


[^1_30]: https://vestnik.ku.edu.kz/jour/article/view/2287


[^1_31]: https://www.jeh.neha.org/article/145240-neha-news


[^1_32]: https://journals.lib.sfu.ca/index.php/jicw/article/view/6858


[^1_33]: https://arxiv.org/html/2502.10281v2


[^1_34]: https://arxiv.org/pdf/2503.18255.pdf


[^1_35]: https://arxiv.org/html/2408.16515v1


[^1_36]: http://thesai.org/Downloads/Volume14No2/Paper_92-Predictions_of_Cybersecurity_Experts_on_Future_Cyber_Attacks.pdf


[^1_37]: http://arxiv.org/pdf/2412.06261.pdf


[^1_38]: https://peerj.com/articles/cs-1772


[^1_39]: https://arxiv.org/pdf/2404.05602.pdf


[^1_40]: https://arxiv.org/html/2410.09538v1


[^1_41]: https://www.helpnetsecurity.com/2025/11/11/cybersecurity-jobs-available-right-now-november-11-2025/


[^1_42]: https://cybersecuritynews.com/sap-security-patch-day-november-2025/


[^1_43]: https://strobes.co/blog/top-7-data-breaches-in-august-2025-that-made-headlines/


[^1_44]: https://www.netscout.com/ddos-attack-map


[^1_45]: https://thehackernews.com


[^1_46]: https://www.fortinet.com/resources/reports/threat-landscape-report


[^1_47]: https://www.digital.pitt.edu/news/alerts/20251111msalert


[^1_48]: https://linkinghub.elsevier.com/retrieve/pii/S0268401225000635


[^1_49]: https://ieeexplore.ieee.org/document/10945868/


[^1_50]: https://ieeexplore.ieee.org/document/11071567/


[^1_51]: https://jist.publikasiindonesia.id/index.php/jist/article/view/9069


[^1_52]: http://doi.fil.bg.ac.rs/volume.php?pt=journals\&issue=ijdrm-2025-7-1\&i=14


[^1_53]: https://www.ijlrp.com/research-paper.php?id=1683


[^1_54]: https://www.sciltp.com/journals/ijndi/2025/1/966


[^1_55]: https://www.sciltp.com/journals/tai/articles/2504000291


[^1_56]: https://latia.ageditor.uy/index.php/latia/article/view/333


[^1_57]: https://scijournals.onlinelibrary.wiley.com/doi/10.1002/ps.8622


[^1_58]: http://arxiv.org/pdf/2502.01221.pdf


[^1_59]: http://arxiv.org/pdf/2401.11238.pdf


[^1_60]: https://arxiv.org/pdf/2307.02855.pdf


[^1_61]: https://ccsenet.org/journal/index.php/cis/article/download/0/0/40191/41309


[^1_62]: https://www.mdpi.com/2076-3417/11/13/6070/pdf


[^1_63]: https://academic.oup.com/cybersecurity/article/doi/10.1093/cybsec/tyaa023/6047253


[^1_64]: https://www.igi-global.com/ViewTitle.aspx?TitleId=289219\&isxn=9781683180302


[^1_65]: https://www.zerodayinitiative.com/blog/2025/11/11/the-november-2025-security-update-review


[^1_66]: https://www.netsecurity.com/top-apts-and-ransomware-groups-to-watch-in-2025/


[^1_67]: https://cyberscoop.com/microsoft-patch-tuesday-november-2025/


[^1_68]: https://www.darkreading.com/vulnerabilities-threats/patch-now-microsoft-zero-day-critical-zero-click-bugs


[^1_69]: https://www.cyfirma.com/news/weekly-intelligence-report-07-november-2025/


[^1_70]: https://ieeexplore.ieee.org/document/11102411/


[^1_71]: https://networksecuritypub.com/index.php/journal/article/view/108


[^1_72]: https://ieeexplore.ieee.org/document/10940286/


[^1_73]: https://journaljerr.com/index.php/JERR/article/view/1416


[^1_74]: https://ieeexplore.ieee.org/document/11209180/


[^1_75]: https://ieeexplore.ieee.org/document/11211481/


[^1_76]: https://ieeexplore.ieee.org/document/11166929/


[^1_77]: https://ieeexplore.ieee.org/document/10933485/


[^1_78]: https://ieeexplore.ieee.org/document/11101291/


[^1_79]: https://wjaets.com/sites/default/files/WJAETS-2023-0304.pdf


[^1_80]: https://sands.edpsciences.org/articles/sands/pdf/forth/sands20240040.pdf


[^1_81]: http://arxiv.org/pdf/2405.11350.pdf


[^1_82]: http://thesai.org/Downloads/Volume4No1/Paper_6-An_Analysis_of_Security_Challenges_in_Cloud_Computing.pdf


[^1_83]: http://ijict.iaescore.com/index.php/IJICT/article/download/20251/12845


[^1_84]: http://arxiv.org/pdf/2311.01247.pdf


[^1_85]: http://thesai.org/Downloads/Volume6No3/Paper_16-A_survey_on_top_security_threats_in_cloud_computing.pdf


[^1_86]: https://www.ijfmr.com/papers/2024/6/31587.pdf


[^1_87]: https://www.tenable.com/cyber-exposure/tenable-cloud-security-risk-report-2025


[^1_88]: https://carnegieendowment.org/posts/2025/07/safeguarding-critical-infrastructure-key-challenges-in-global-cybersecurity?lang=en


[^1_89]: https://www.sentinelone.com/cybersecurity-101/cloud-security/security-risks-of-cloud-computing/


[^1_90]: https://openssf.org/blog/2025/01/23/predictions-for-open-source-security-in-2025-ai-state-actors-and-supply-chains/


[^1_91]: https://cyberinitiative.org/proposals/2025-calls/critical-infrastructure-cybersecurity.html


[^1_92]: https://www.wiz.io/academy/common-cloud-vulnerabilities

