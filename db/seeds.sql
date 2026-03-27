-- 1. Insert Account Types
INSERT INTO account_types (id, type_name) VALUES 
(1, 'Admin'), 
(2, 'Consultant');

-- 2. Insert Professional Roles (Updated from your friend's research!)
INSERT INTO roles (id, title, description) VALUES 
(1, 'Business Analyst', 'Bridging the gap between IT and the business using data.'),
(2, 'Project Manager', 'Ensuring projects are delivered on time and within budget.'),
(3, 'Data Engineer', 'Building and maintaining data pipelines and architectures.'),
(4, 'Delivery Operations Manager', 'Overseeing the delivery of services and operational performance.'),
(5, 'DevOps / Platform Engineer', 'Bridging development and operations for infrastructure and deployment.'),
(6, 'IT Support Helpdesk', 'Providing technical support and troubleshooting.'),
(7, 'Software Engineer', 'Designing, developing, and maintaining software applications.'),
(8, 'Test Analyst', 'Testing software to ensure quality and functional requirements.');

-- 3. Insert Master Skills List (We kept the core ones!)
INSERT INTO skills (name, category) VALUES 
('SQL', 'Technical'),
('Python', 'Technical'),
('Requirements Gathering', 'Business'),
('Stakeholder Management', 'Soft Skills'),
('Agile Methodology', 'Process'),
('Cloud Computing (AWS/Azure/GCP)', 'Technical');

-- 4. Insert Industry Certifications (The Motherload!)
INSERT INTO certifications (name, issuing_body, learning_url) VALUES 
('BCS: International Diploma in Business Analysis', 'BCS', 'https://www.bcs.org/qualifications-and-certifications/'),
('IIBA: CBAP (Certified Business Analysis Professional)', 'IIBA', 'https://www.iiba.org/business-analysis-certifications/'),
('Foundation Certificate in Data Protection', 'BCS', 'https://www.bcs.org/qualifications-and-certifications/'),
('IAPP: CIPP/E', 'IAPP', 'https://iapp.org/certify/'),
('Certificate in Business Data Analytics (CBDA)', 'IIBA', 'https://www.iiba.org/business-analysis-certifications/'),
('Professional Scrum Master (PSM I/II)', 'Scrum.org', 'https://www.scrum.org/certifications'),
('BCS Foundation/Practitioner Certificate in Data Protection', 'BCS', 'https://www.bcs.org/qualifications-and-certifications/'),
('AWS Certified Data Engineer (Associate)', 'AWS', 'https://aws.amazon.com/certification/certified-data-engineer-associate/'),
('DP-203: Microsoft Certified: Azure Data Engineer Associate', 'Microsoft', 'https://learn.microsoft.com/en-us/credentials/certifications/'),
('Google Professional Data Engineer', 'Google Cloud', 'https://cloud.google.com/learn/certification/'),
('dbt Analytics Engineering Certification', 'dbt Labs', 'https://www.getdbt.com/certifications/'),
('Astronomer Certification for Apache Airflow', 'Astronomer', 'https://www.astronomer.io/certification/'),
('Professional Scrum Product Owner (PSPO)', 'Scrum.org', 'https://www.scrum.org/certifications'),
('Certified SAFe® Release Train Engineer (RTE)', 'Scaled Agile', 'https://scaledagile.com/training/'),
('Kanban Management Professional (KMP)', 'Kanban Univ.', 'https://kanban.university/'),
('ITIL 4: ITIL 4 Specialist', 'PeopleCert', 'https://www.peoplecert.org/'),
('Google Professional Cloud DevOps Engineer', 'Google Cloud', 'https://cloud.google.com/learn/certification/'),
('AWS Certified DevOps Engineer – Professional', 'AWS', 'https://aws.amazon.com/certification/'),
('AZ-400: Designing and Implementing Microsoft DevOps Solutions', 'Microsoft', 'https://learn.microsoft.com/en-us/credentials/certifications/'),
('CKA (Certified Kubernetes Administrator)', 'CNCF/LF', 'https://training.linuxfoundation.org/certification/'),
('CKAD (Certified Kubernetes Application Developer)', 'CNCF/LF', 'https://training.linuxfoundation.org/certification/'),
('Terraform Associate (003)', 'HashiCorp', 'https://www.hashicorp.com/certification/'),
('CompTIA: A+ (Core 1 & 2)', 'CompTIA', 'https://www.comptia.org/certifications/'),
('CompTIA: Tech+ (formerly IT Fundamentals+)', 'CompTIA', 'https://www.comptia.org/certifications/'),
('Google: IT Support Professional Certificate', 'Google Cloud', 'https://grow.google/certificates/'),
('Microsoft: MS-900 (Microsoft 365 Fundamentals)', 'Microsoft', 'https://learn.microsoft.com/en-us/credentials/certifications/'),
('Microsoft: MD-102 (Endpoint Administrator)', 'Microsoft', 'https://learn.microsoft.com/en-us/credentials/certifications/'),
('CCT (Cisco Certified Technician)', 'Cisco', 'https://www.cisco.com/c/en/us/training-events/training-certifications/'),
('Oracle: Certified Professional: Java SE Developer', 'Oracle', 'https://education.oracle.com/certification/'),
('Front-End/Back-End Developer Professional Certificates', 'Meta/IBM', 'https://www.coursera.org/'),
('PCPP (Certified Professional in Python Programming)', 'OpenEDG', 'https://pythoninstitute.org/certification/'),
('AWS: Certified Developer – Associate (DVA-C02)', 'AWS', 'https://aws.amazon.com/certification/'),
('Azure: AZ-204: Developing Solutions for Microsoft Azure', 'Microsoft', 'https://learn.microsoft.com/en-us/credentials/certifications/'),
('GCP: Professional Cloud Developer', 'Google Cloud', 'https://cloud.google.com/learn/certification/'),
('BCS Practitioner Certificate in Enterprise and Solutions Architecture', 'BCS', 'https://www.bcs.org/qualifications-and-certifications/'),
('ISTQB: Certified Tester Foundation Level (v4.0)', 'ISTQB', 'https://www.istqb.org/certifications/'),
('ISTQB: Agile Tester Extension', 'ISTQB', 'https://www.istqb.org/certifications/'),
('BCS: Foundation Certificate in Software Testing', 'BCS', 'https://www.bcs.org/qualifications-and-certifications/'),
('ISTQB: AI Testing (CT-AI)', 'ISTQB', 'https://www.istqb.org/certifications/');