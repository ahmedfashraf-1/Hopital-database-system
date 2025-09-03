-- ===========================
CREATE DATABASE HospitalSystem;
USE HospitalSystem;

SET FOREIGN_KEY_CHECKS = 0;
-- ===========================
-- 1. Patient Management
-- ===========================
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    medical_record_number VARCHAR(50) UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    sex CHAR(1),
    marital_status VARCHAR(20),
    phone VARCHAR(20),
    email VARCHAR(100),
    status VARCHAR(20)
);

CREATE TABLE Contact (
    contact_id INT PRIMARY KEY,
    patient_id INT,
    name VARCHAR(50),
    relation VARCHAR(50),
    phone VARCHAR(20),
    type VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

CREATE TABLE Allergy (
    allergy_id INT PRIMARY KEY,
    patient_id INT,
    substance VARCHAR(50),
    reaction VARCHAR(100),
    severity VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

INSERT INTO Patient VALUES 
(1,'MR001','Ahmed','Ashraf','1990-05-10','M','Single','01012345678','ahmed@test.com','Active'),
(2,'MR002','Sara','Ali','1985-08-20','F','Married','01023456789','sara@test.com','Active'),
(3,'MR003','Omar','Hassan','1978-11-05','M','Married','01034567890','omar@test.com','Active'),
(4,'MR004','Laila','Mohamed','1992-01-15','F','Single','01045678901','laila@test.com','Active'),
(5,'MR005','Khaled','Youssef','1988-07-25','M','Single','01056789012','khaled@test.com','Active'),
(6,'MR006','Mona','Ahmed','1995-03-30','F','Single','01067890123','mona@test.com','Active'),
(7,'MR007','Tamer','Ibrahim','1982-06-10','M','Married','01078901234','tamer@test.com','Active'),
(8,'MR008','Dina','Salah','1991-09-12','F','Married','01089012345','dina@test.com','Active'),
(9,'MR009','Hany','Khalifa','1975-12-01','M','Married','01090123456','hany@test.com','Active'),
(10,'MR010','Yasmine','Fahmy','1989-04-18','F','Single','01001234567','yasmine@test.com','Active');

INSERT INTO Contact VALUES
(1,1,'Mohamed Ashraf','Father','01011112222','Emergency'),
(2,2,'Ali Ali','Husband','01022223333','Emergency'),
(3,3,'Hassan Omar','Brother','01033334444','Emergency'),
(4,4,'Mohamed Laila','Father','01044445555','Emergency'),
(5,5,'Youssef Khaled','Brother','01055556666','Emergency'),
(6,6,'Ahmed Mona','Father','01066667777','Emergency'),
(7,7,'Ibrahim Tamer','Brother','01077778888','Emergency'),
(8,8,'Salah Dina','Husband','01088889999','Emergency'),
(9,9,'Khalifa Hany','Brother','01099990000','Emergency'),
(10,10,'Fahmy Yasmine','Father','01000001111','Emergency');

INSERT INTO Allergy VALUES
(1,1,'Peanuts','Hives','High'),
(2,2,'Penicillin','Rash','Medium'),
(3,3,'Seafood','Anaphylaxis','High'),
(4,4,'Dust','Sneezing','Low'),
(5,5,'Latex','Skin Irritation','Medium'),
(6,6,'Pollen','Sneezing','Low'),
(7,7,'Bee Sting','Swelling','High'),
(8,8,'Gluten','Digestive Issue','Medium'),
(9,9,'Milk','Hives','Low'),
(10,10,'Eggs','Rash','Medium');

-- ===========================
-- 2. Scheduling and Appointments
-- ===========================
CREATE TABLE Provider (
    provider_id INT PRIMARY KEY,
    name VARCHAR(50),
    specialty VARCHAR(50),
    license_number VARCHAR(50),
    status VARCHAR(20)
);

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    department_type VARCHAR(50)
);

CREATE TABLE Room (
    room_id INT PRIMARY KEY,
    room_number VARCHAR(20),
    type VARCHAR(50)
);

CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    provider_id INT,
    department_id INT,
    room_id INT,
    start_time DATETIME,
    end_time DATETIME,
    reason VARCHAR(100),
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (provider_id) REFERENCES Provider(provider_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

INSERT INTO Provider VALUES 
(1,'Dr. Ali','Cardiology','LIC123','Active'),
(2,'Dr. Sara','Neurology','LIC124','Active'),
(3,'Dr. Omar','Orthopedics','LIC125','Active'),
(4,'Dr. Laila','Dermatology','LIC126','Active'),
(5,'Dr. Khaled','Oncology','LIC127','Active'),
(6,'Dr. Mona','Pediatrics','LIC128','Active'),
(7,'Dr. Tamer','ENT','LIC129','Active'),
(8,'Dr. Dina','Gynecology','LIC130','Active'),
(9,'Dr. Hany','Urology','LIC131','Active'),
(10,'Dr. Yasmine','Ophthalmology','LIC132','Active');

INSERT INTO Department VALUES
(1,'Cardiology','Medical'),
(2,'Neurology','Medical'),
(3,'Orthopedics','Surgical'),
(4,'Dermatology','Medical'),
(5,'Oncology','Medical'),
(6,'Pediatrics','Medical'),
(7,'ENT','Surgical'),
(8,'Gynecology','Medical'),
(9,'Urology','Surgical'),
(10,'Ophthalmology','Medical');

INSERT INTO Room VALUES
(1,'OR-101','Operation'),
(2,'RM-102','Consultation'),
(3,'OR-103','Operation'),
(4,'RM-104','Consultation'),
(5,'OR-105','Operation'),
(6,'RM-106','Consultation'),
(7,'OR-107','Operation'),
(8,'RM-108','Consultation'),
(9,'OR-109','Operation'),
(10,'RM-110','Consultation');

INSERT INTO Appointment VALUES
(1,1,1,1,1,'2024-09-02 09:00:00','2024-09-02 09:30:00','Checkup','Scheduled'),
(2,2,2,2,2,'2024-09-02 10:00:00','2024-09-02 10:30:00','Consultation','Scheduled'),
(3,3,3,3,3,'2024-09-03 11:00:00','2024-09-03 11:30:00','Follow-up','Scheduled'),
(4,4,4,4,4,'2024-09-03 12:00:00','2024-09-03 12:30:00','Checkup','Scheduled'),
(5,5,5,5,5,'2024-09-04 09:00:00','2024-09-04 09:30:00','Consultation','Scheduled'),
(6,6,6,6,6,'2024-09-04 10:00:00','2024-09-04 10:30:00','Follow-up','Scheduled'),
(7,7,7,7,7,'2024-09-05 09:00:00','2024-09-05 09:30:00','Checkup','Scheduled'),
(8,8,8,8,8,'2024-09-05 10:00:00','2024-09-05 10:30:00','Consultation','Scheduled'),
(9,9,9,9,9,'2024-09-06 11:00:00','2024-09-06 11:30:00','Follow-up','Scheduled'),
(10,10,10,10,10,'2024-09-06 12:00:00','2024-09-06 12:30:00','Checkup','Scheduled');
-- ===========================
-- 3. Encounters
-- ===========================
CREATE TABLE Encounter (
    encounter_id INT PRIMARY KEY,
    patient_id INT,
    department_id INT,
    type VARCHAR(50),
    start_time DATETIME,
    end_time DATETIME,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE Admission (
    admission_id INT PRIMARY KEY,
    encounter_id INT,
    admit_date DATETIME,
    discharge_date DATETIME,
    attending_provider_id INT,
    FOREIGN KEY (encounter_id) REFERENCES Encounter(encounter_id),
    FOREIGN KEY (attending_provider_id) REFERENCES Provider(provider_id)
);

CREATE TABLE BedAssignment (
    assignment_id INT PRIMARY KEY,
    encounter_id INT,
    bed_id INT,
    start_date DATETIME,
    end_date DATETIME,
    FOREIGN KEY (encounter_id) REFERENCES Encounter(encounter_id)
);

INSERT INTO Encounter VALUES
(1,1,1,'Outpatient','2024-09-02 09:00:00','2024-09-02 09:30:00','Completed'),
(2,2,2,'Inpatient','2024-09-03 10:00:00','2024-09-05 14:00:00','Completed'),
(3,3,3,'Emergency','2024-09-04 11:00:00','2024-09-04 13:00:00','Completed'),
(4,4,4,'Outpatient','2024-09-05 09:30:00','2024-09-05 10:00:00','Completed'),
(5,5,5,'Inpatient','2024-09-06 08:00:00','2024-09-08 12:00:00','Completed'),
(6,6,6,'Outpatient','2024-09-07 09:15:00','2024-09-07 09:45:00','Completed'),
(7,7,7,'Emergency','2024-09-08 10:00:00','2024-09-08 12:30:00','Completed'),
(8,8,8,'Outpatient','2024-09-09 11:00:00','2024-09-09 11:30:00','Completed'),
(9,9,9,'Inpatient','2024-09-10 07:00:00','2024-09-12 15:00:00','Completed'),
(10,10,10,'Outpatient','2024-09-11 10:30:00','2024-09-11 11:00:00','Completed');

INSERT INTO Admission VALUES
(1,1,'2024-09-02 09:00:00','2024-09-02 15:00:00',1),
(2,2,'2024-09-03 10:00:00','2024-09-05 14:00:00',2),
(3,3,'2024-09-04 11:00:00','2024-09-04 13:00:00',3),
(4,4,'2024-09-05 09:30:00','2024-09-05 10:30:00',4),
(5,5,'2024-09-06 08:00:00','2024-09-08 12:00:00',5),
(6,6,'2024-09-07 09:15:00','2024-09-07 09:45:00',6),
(7,7,'2024-09-08 10:00:00','2024-09-08 12:30:00',7),
(8,8,'2024-09-09 11:00:00','2024-09-09 11:30:00',8),
(9,9,'2024-09-10 07:00:00','2024-09-12 15:00:00',9),
(10,10,'2024-09-11 10:30:00','2024-09-11 11:00:00',10);

INSERT INTO BedAssignment VALUES
(1,2,201,'2024-09-03 10:00:00','2024-09-05 14:00:00'),
(2,5,202,'2024-09-06 08:00:00','2024-09-08 12:00:00'),
(3,9,203,'2024-09-10 07:00:00','2024-09-12 15:00:00'),
(4,1,204,'2024-09-02 09:00:00','2024-09-02 15:00:00'),
(5,3,205,'2024-09-04 11:00:00','2024-09-04 13:00:00'),
(6,4,206,'2024-09-05 09:30:00','2024-09-05 10:30:00'),
(7,6,207,'2024-09-07 09:15:00','2024-09-07 09:45:00'),
(8,7,208,'2024-09-08 10:00:00','2024-09-08 12:30:00'),
(9,8,209,'2024-09-09 11:00:00','2024-09-09 11:30:00'),
(10,10,210,'2024-09-11 10:30:00','2024-09-11 11:00:00');

-- ===========================
-- 4. Orders and Results
-- ===========================
CREATE TABLE Service (
    service_id INT PRIMARY KEY,
    code VARCHAR(50),
    description VARCHAR(100),
    price DECIMAL(10,2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE `Order` (
    order_id INT PRIMARY KEY,
    encounter_id INT,
    type VARCHAR(50),
    priority VARCHAR(20),
    ordered_by INT,
    status VARCHAR(20),
    FOREIGN KEY (encounter_id) REFERENCES Encounter(encounter_id),
    FOREIGN KEY (ordered_by) REFERENCES Provider(provider_id)
);

CREATE TABLE OrderItem (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    quantity INT,
    notes VARCHAR(100),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id)
);

CREATE TABLE Result (
    result_id INT PRIMARY KEY,
    order_item_id INT,
    value VARCHAR(50),
    units VARCHAR(20),
    abnormal_flag VARCHAR(10),
    timestamp DATETIME,
    FOREIGN KEY (order_item_id) REFERENCES OrderItem(order_item_id)
);

INSERT INTO Service VALUES
(1,'SVC001','Blood Test',50.0,1),
(2,'SVC002','X-Ray',100.0,3),
(3,'SVC003','MRI',500.0,2),
(4,'SVC004','Ultrasound',150.0,4),
(5,'SVC005','ECG',80.0,1),
(6,'SVC006','Vaccination',30.0,6),
(7,'SVC007','Surgery',1000.0,5),
(8,'SVC008','Consultation',50.0,2),
(9,'SVC009','Physiotherapy',70.0,3),
(10,'SVC010','Dental',60.0,8);

INSERT INTO `Order` VALUES
(1,1,'Lab','High',1,'Ordered'),
(2,2,'Imaging','Medium',2,'Ordered'),
(3,3,'Lab','Low',3,'Ordered'),
(4,4,'Consultation','High',4,'Ordered'),
(5,5,'Surgery','High',5,'Ordered'),
(6,6,'Lab','Medium',6,'Ordered'),
(7,7,'Imaging','Low',7,'Ordered'),
(8,8,'Consultation','Medium',8,'Ordered'),
(9,9,'Therapy','Low',9,'Ordered'),
(10,10,'Lab','High',10,'Ordered');

INSERT INTO OrderItem VALUES
(1,1,1,'Routine check'),
(2,2,2,'Chest scan'),
(3,3,3,'Brain scan'),
(4,4,4,'Follow-up'),
(5,5,5,'Pre-surgery test'),
(6,6,6,'Vaccination'),
(7,7,7,'Pre-op imaging'),
(8,8,8,'Consultation notes'),
(9,9,9,'Physio session'),
(10,10,10,'Blood analysis');

INSERT INTO Result VALUES
(1,1,'5.2','mg/dL','Normal','2024-09-02 10:00:00'),
(2,2,'Normal','N/A','Normal','2024-09-03 11:00:00'),
(3,3,'Positive','N/A','Abnormal','2024-09-04 12:00:00'),
(4,4,'Normal','N/A','Normal','2024-09-05 13:00:00'),
(5,5,'120','bpm','Normal','2024-09-06 09:00:00'),
(6,6,'Negative','N/A','Normal','2024-09-07 10:30:00'),
(7,7,'Clear','N/A','Normal','2024-09-08 11:00:00'),
(8,8,'Normal','N/A','Normal','2024-09-09 12:15:00'),
(9,9,'15','sessions','Normal','2024-09-10 13:30:00'),
(10,10,'4.5','mg/dL','Normal','2024-09-11 14:00:00');
-- ===========================
-- 5. Pharmacy and Medications
-- ===========================
CREATE TABLE Drug (
    drug_id INT PRIMARY KEY,
    name VARCHAR(50),
    strength VARCHAR(20),
    form VARCHAR(20),
    atc_code VARCHAR(20)
);

CREATE TABLE Prescription (
    prescription_id INT PRIMARY KEY,
    encounter_id INT,
    prescriber_id INT,
    status VARCHAR(20),
    FOREIGN KEY (encounter_id) REFERENCES Encounter(encounter_id),
    FOREIGN KEY (prescriber_id) REFERENCES Provider(provider_id)
);

CREATE TABLE PrescriptionLine (
    line_id INT PRIMARY KEY,
    prescription_id INT,
    drug_id INT,
    dose VARCHAR(20),
    route VARCHAR(20),
    frequency VARCHAR(20),
    duration VARCHAR(20),
    notes VARCHAR(100),
    FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id),
    FOREIGN KEY (drug_id) REFERENCES Drug(drug_id)
);

CREATE TABLE DispenseRecord (
    dispense_id INT PRIMARY KEY,
    line_id INT,
    quantity INT,
    lot_number VARCHAR(50),
    expiry_date DATE,
    timestamp DATETIME,
    FOREIGN KEY (line_id) REFERENCES PrescriptionLine(line_id)
);

INSERT INTO Drug VALUES
(1,'Paracetamol','500mg','Tablet','N02BE01'),
(2,'Ibuprofen','200mg','Tablet','M01AE01'),
(3,'Amoxicillin','250mg','Capsule','J01CA04'),
(4,'Metformin','500mg','Tablet','A10BA02'),
(5,'Omeprazole','20mg','Capsule','A02BC01'),
(6,'Aspirin','100mg','Tablet','B01AC06'),
(7,'Cefalexin','500mg','Capsule','J01DB01'),
(8,'Lisinopril','10mg','Tablet','C09AA03'),
(9,'Atorvastatin','20mg','Tablet','C10AA05'),
(10,'Salbutamol','100mcg','Inhaler','R03AC02');

INSERT INTO Prescription VALUES
(1,1,1,'Active'),
(2,2,2,'Active'),
(3,3,3,'Completed'),
(4,4,4,'Active'),
(5,5,5,'Completed'),
(6,6,6,'Active'),
(7,7,7,'Completed'),
(8,8,8,'Active'),
(9,9,9,'Completed'),
(10,10,10,'Active');

INSERT INTO PrescriptionLine VALUES
(1,1,1,'1 Tablet','Oral','3/day','5 days','After meals'),
(2,2,2,'2 Tablets','Oral','2/day','7 days','Before sleep'),
(3,3,3,'1 Capsule','Oral','3/day','10 days','With water'),
(4,4,4,'1 Tablet','Oral','1/day','30 days','Morning'),
(5,5,5,'1 Capsule','Oral','2/day','14 days','After meals'),
(6,6,6,'1 Tablet','Oral','1/day','7 days','Morning'),
(7,7,7,'1 Capsule','Oral','3/day','5 days','With water'),
(8,8,8,'1 Tablet','Oral','1/day','30 days','Evening'),
(9,9,9,'1 Tablet','Oral','1/day','30 days','Morning'),
(10,10,10,'2 Inhaler','Inhalation','As needed','10 days','During attacks');

INSERT INTO DispenseRecord VALUES
(1,1,15,'LOT123','2025-01-01','2024-09-02 10:30:00'),
(2,2,14,'LOT124','2025-02-01','2024-09-03 11:00:00'),
(3,3,20,'LOT125','2025-03-01','2024-09-04 12:00:00'),
(4,4,30,'LOT126','2025-04-01','2024-09-05 09:00:00'),
(5,5,28,'LOT127','2025-05-01','2024-09-06 10:00:00'),
(6,6,10,'LOT128','2025-06-01','2024-09-07 11:00:00'),
(7,7,25,'LOT129','2025-07-01','2024-09-08 12:00:00'),
(8,8,12,'LOT130','2025-08-01','2024-09-09 09:30:00'),
(9,9,20,'LOT131','2025-09-01','2024-09-10 10:30:00'),
(10,10,18,'LOT132','2025-10-01','2024-09-11 11:30:00');

-- ===========================
-- 6. Clinical Documentation
-- ===========================
CREATE TABLE Note (
    note_id INT PRIMARY KEY,
    patient_id INT,
    author VARCHAR(50),
    type VARCHAR(20),
    text TEXT,
    timestamp DATETIME,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

CREATE TABLE Vital (
    vital_id INT PRIMARY KEY,
    patient_id INT,
    type VARCHAR(50),
    value VARCHAR(50),
    units VARCHAR(20),
    measurement_time DATETIME,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

CREATE TABLE Diagnosis (
    diagnosis_id INT PRIMARY KEY,
    patient_id INT,
    code VARCHAR(20),
    description VARCHAR(100),
    type VARCHAR(20),
    onset_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

INSERT INTO Note VALUES
(1,1,'Dr. Ali','Progress','Patient stable','2024-09-02 09:15:00'),
(2,2,'Dr. Sara','Admission','Admitted for surgery','2024-09-03 10:30:00'),
(3,3,'Dr. Omar','Progress','Recovered from emergency','2024-09-04 11:45:00'),
(4,4,'Dr. Hany','Progress','Routine check','2024-09-05 09:30:00'),
(5,5,'Dr. Rania','Admission','Scheduled for operation','2024-09-06 08:00:00'),
(6,6,'Dr. Ahmed','Progress','Blood pressure stable','2024-09-07 09:15:00'),
(7,7,'Dr. Mona','Progress','Patient stable','2024-09-08 10:00:00'),
(8,8,'Dr. Khaled','Progress','Routine follow-up','2024-09-09 11:00:00'),
(9,9,'Dr. Nadia','Progress','Recovering well','2024-09-10 07:30:00'),
(10,10,'Dr. Tamer','Progress','Healthy','2024-09-11 10:45:00');

INSERT INTO Vital VALUES
(1,1,'BP','120/80','mmHg','2024-09-02 09:10:00'),
(2,2,'Temp','37','C','2024-09-03 10:45:00'),
(3,3,'Pulse','78','bpm','2024-09-04 11:30:00'),
(4,4,'BP','115/75','mmHg','2024-09-05 09:35:00'),
(5,5,'Temp','36.8','C','2024-09-06 08:10:00'),
(6,6,'Pulse','80','bpm','2024-09-07 09:20:00'),
(7,7,'BP','118/78','mmHg','2024-09-08 10:10:00'),
(8,8,'Temp','37.2','C','2024-09-09 11:05:00'),
(9,9,'Pulse','76','bpm','2024-09-10 07:40:00'),
(10,10,'BP','122/80','mmHg','2024-09-11 10:50:00');

INSERT INTO Diagnosis VALUES
(1,1,'I10','Hypertension','Chronic','2020-01-01'),
(2,2,'E11','Diabetes','Chronic','2021-02-15'),
(3,3,'J20','Bronchitis','Acute','2022-03-10'),
(4,4,'K21','GERD','Chronic','2021-04-20'),
(5,5,'I25','Heart Disease','Chronic','2020-05-05'),
(6,6,'M54','Back Pain','Chronic','2021-06-12'),
(7,7,'N39','UTI','Acute','2022-07-22'),
(8,8,'L40','Psoriasis','Chronic','2020-08-18'),
(9,9,'J45','Asthma','Chronic','2019-09-25'),
(10,10,'I50','Heart Failure','Chronic','2021-10-30');
-- ===========================
-- 7. Billing and Insurance
-- ===========================
CREATE TABLE Payer (
    payer_id INT PRIMARY KEY,
    name VARCHAR(50),
    type VARCHAR(50),
    contact_info VARCHAR(100)
);

CREATE TABLE Invoice (
    invoice_id INT PRIMARY KEY,
    patient_id INT,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    patient_responsibility DECIMAL(10,2),
    payer_responsibility DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

CREATE TABLE Charge (
    charge_id INT PRIMARY KEY,
    invoice_id INT,
    service_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    amount DECIMAL(10,2),
    FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    invoice_id INT,
    amount DECIMAL(10,2),
    method VARCHAR(50),
    date DATETIME,
    receipt_number VARCHAR(50),
    FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id)
);

CREATE TABLE Claim (
    claim_id INT PRIMARY KEY,
    invoice_id INT,
    payer_id INT,
    status VARCHAR(20),
    submitted_date DATE,
    reference_number VARCHAR(50),
    FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),
    FOREIGN KEY (payer_id) REFERENCES Payer(payer_id)
);

INSERT INTO Payer VALUES
(1,'Health Insurance Co.','Insurance','contact1@insurance.com'),
(2,'MediCare','Insurance','contact2@insurance.com'),
(3,'LifeCare','Insurance','contact3@insurance.com'),
(4,'Alpha Health','Insurance','contact4@insurance.com'),
(5,'Beta Insurance','Insurance','contact5@insurance.com'),
(6,'Gamma Insurance','Insurance','contact6@insurance.com'),
(7,'Delta Health','Insurance','contact7@insurance.com'),
(8,'Omega Insurance','Insurance','contact8@insurance.com'),
(9,'Sunrise Health','Insurance','contact9@insurance.com'),
(10,'Eclipse Insurance','Insurance','contact10@insurance.com');

INSERT INTO Invoice VALUES
(1,1,200.0,'Pending',50.0,150.0),
(2,2,300.0,'Paid',100.0,200.0),
(3,3,150.0,'Pending',30.0,120.0),
(4,4,400.0,'Paid',100.0,300.0),
(5,5,250.0,'Pending',50.0,200.0),
(6,6,180.0,'Paid',30.0,150.0),
(7,7,220.0,'Pending',70.0,150.0),
(8,8,350.0,'Paid',100.0,250.0),
(9,9,275.0,'Pending',75.0,200.0),
(10,10,310.0,'Paid',110.0,200.0);

INSERT INTO Charge VALUES
(1,1,1,1,50.0,50.0),
(2,2,2,2,75.0,150.0),
(3,3,3,1,120.0,120.0),
(4,4,4,2,200.0,400.0),
(5,5,5,1,200.0,200.0),
(6,6,1,1,50.0,50.0),
(7,7,2,1,150.0,150.0),
(8,8,3,2,125.0,250.0),
(9,9,4,1,150.0,150.0),
(10,10,5,1,200.0,200.0);

INSERT INTO Payment VALUES
(1,1,50.0,'Cash','2024-09-02 12:00:00','RCPT001'),
(2,2,300.0,'Card','2024-09-03 13:00:00','RCPT002'),
(3,3,30.0,'Cash','2024-09-04 14:00:00','RCPT003'),
(4,4,400.0,'Card','2024-09-05 15:00:00','RCPT004'),
(5,5,50.0,'Cash','2024-09-06 12:30:00','RCPT005'),
(6,6,180.0,'Card','2024-09-07 13:45:00','RCPT006'),
(7,7,70.0,'Cash','2024-09-08 14:15:00','RCPT007'),
(8,8,350.0,'Card','2024-09-09 15:20:00','RCPT008'),
(9,9,75.0,'Cash','2024-09-10 12:10:00','RCPT009'),
(10,10,310.0,'Card','2024-09-11 13:30:00','RCPT010');

INSERT INTO Claim VALUES
(1,1,1,'Submitted','2024-09-02','CLM001'),
(2,2,2,'Approved','2024-09-03','CLM002'),
(3,3,3,'Rejected','2024-09-04','CLM003'),
(4,4,4,'Submitted','2024-09-05','CLM004'),
(5,5,5,'Approved','2024-09-06','CLM005'),
(6,6,6,'Rejected','2024-09-07','CLM006'),
(7,7,7,'Submitted','2024-09-08','CLM007'),
(8,8,8,'Approved','2024-09-09','CLM008'),
(9,9,9,'Rejected','2024-09-10','CLM009'),
(10,10,10,'Submitted','2024-09-11','CLM010');

-- ===========================
-- 8. Inventory and Procurement
-- ===========================
CREATE TABLE InventoryItem (
    item_id INT PRIMARY KEY,
    sku VARCHAR(50),
    name VARCHAR(50),
    type VARCHAR(50),
    unit_of_measure VARCHAR(20),
    minimum_level INT,
    reorder_level INT
);

CREATE TABLE StockLot (
    lot_id INT PRIMARY KEY,
    item_id INT,
    lot_number VARCHAR(50),
    expiry_date DATE,
    quantity_on_hand INT,
    FOREIGN KEY (item_id) REFERENCES InventoryItem(item_id)
);

CREATE TABLE StockTransaction (
    transaction_id INT PRIMARY KEY,
    lot_id INT,
    type VARCHAR(20),
    quantity INT,
    date DATETIME,
    reference_info VARCHAR(100),
    FOREIGN KEY (lot_id) REFERENCES StockLot(lot_id)
);

CREATE TABLE Supplier (
    supplier_id INT PRIMARY KEY,
    name VARCHAR(50),
    contact_details VARCHAR(100)
);

CREATE TABLE PurchaseOrder (
    purchase_order_id INT PRIMARY KEY,
    supplier_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

CREATE TABLE PurchaseOrderLine (
    line_id INT PRIMARY KEY,
    purchase_order_id INT,
    item_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (purchase_order_id) REFERENCES PurchaseOrder(purchase_order_id),
    FOREIGN KEY (item_id) REFERENCES InventoryItem(item_id)
);

INSERT INTO InventoryItem VALUES
(1,'SKU001','Gloves','Consumable','Box',10,50),
(2,'SKU002','Syringe','Consumable','Piece',20,100),
(3,'SKU003','Face Mask','Consumable','Box',5,30),
(4,'SKU004','IV Set','Consumable','Piece',10,50),
(5,'SKU005','Bandage','Consumable','Roll',15,60),
(6,'SKU006','Scalpel','Equipment','Piece',2,10),
(7,'SKU007','Thermometer','Equipment','Piece',1,5),
(8,'SKU008','Stethoscope','Equipment','Piece',1,5),
(9,'SKU009','Bed Sheet','Consumable','Piece',5,20),
(10,'SKU010','Wheelchair','Equipment','Piece',1,2);

INSERT INTO StockLot VALUES
(1,1,'LOT001','2025-01-01',100),
(2,2,'LOT002','2025-02-01',200),
(3,3,'LOT003','2025-03-01',150),
(4,4,'LOT004','2025-04-01',120),
(5,5,'LOT005','2025-05-01',180),
(6,6,'LOT006','2025-06-01',50),
(7,7,'LOT007','2025-07-01',30),
(8,8,'LOT008','2025-08-01',20),
(9,9,'LOT009','2025-09-01',60),
(10,10,'LOT010','2025-10-01',10);

INSERT INTO StockTransaction VALUES
(1,1,'IN',50,'2024-09-01 09:00:00','Initial stock'),
(2,2,'IN',100,'2024-09-02 09:30:00','Initial stock'),
(3,3,'IN',80,'2024-09-03 10:00:00','Initial stock'),
(4,4,'IN',60,'2024-09-04 10:30:00','Initial stock'),
(5,5,'IN',90,'2024-09-05 11:00:00','Initial stock'),
(6,6,'IN',20,'2024-09-06 11:30:00','Initial stock'),
(7,7,'IN',10,'2024-09-07 12:00:00','Initial stock'),
(8,8,'IN',5,'2024-09-08 12:30:00','Initial stock'),
(9,9,'IN',30,'2024-09-09 13:00:00','Initial stock'),
(10,10,'IN',2,'2024-09-10 13:30:00','Initial stock');

INSERT INTO Supplier VALUES
(1,'Med Supply Co.','supplier1@med.com'),
(2,'Health Equip Ltd.','supplier2@med.com'),
(3,'PharmaPlus','supplier3@med.com'),
(4,'Global Med','supplier4@med.com'),
(5,'Alpha Med','supplier5@med.com'),
(6,'Beta Equip','supplier6@med.com'),
(7,'Gamma Pharma','supplier7@med.com'),
(8,'Delta Med','supplier8@med.com'),
(9,'Epsilon Equip','supplier9@med.com'),
(10,'Zeta Pharma','supplier10@med.com');

INSERT INTO PurchaseOrder VALUES
(1,1,'2024-09-01','Pending'),
(2,2,'2024-09-02','Completed'),
(3,3,'2024-09-03','Pending'),
(4,4,'2024-09-04','Completed'),
(5,5,'2024-09-05','Pending'),
(6,6,'2024-09-06','Completed'),
(7,7,'2024-09-07','Pending'),
(8,8,'2024-09-08','Completed'),
(9,9,'2024-09-09','Pending'),
(10,10,'2024-09-10','Completed');

INSERT INTO PurchaseOrderLine VALUES
(1,1,1,20,100.0),
(2,2,2,50,200.0),
(3,3,3,30,150.0),
(4,4,4,25,125.0),
(5,5,5,40,180.0),
(6,6,6,10,50.0),
(7,7,7,5,25.0),
(8,8,8,2,200.0),
(9,9,9,15,60.0),
(10,10,10,1,500.0);
-- ===========================
-- 9. Operating Theatre / Procedures
-- ===========================
CREATE TABLE OperatingRoomSchedule (
    or_schedule_id INT PRIMARY KEY,
    patient_id INT,
    provider_id INT,
    date DATE,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (provider_id) REFERENCES Provider(provider_id)
);

CREATE TABLE ORConsumableUsed (
    record_id INT PRIMARY KEY,
    or_schedule_id INT,
    item_id INT,
    quantity_used INT,
    FOREIGN KEY (or_schedule_id) REFERENCES OperatingRoomSchedule(or_schedule_id),
    FOREIGN KEY (item_id) REFERENCES InventoryItem(item_id)
);

INSERT INTO OperatingRoomSchedule VALUES
(1,1,1,'2024-09-01','Scheduled'),
(2,2,2,'2024-09-02','Completed'),
(3,3,3,'2024-09-03','Cancelled'),
(4,4,4,'2024-09-04','Completed'),
(5,5,5,'2024-09-05','Scheduled'),
(6,6,6,'2024-09-06','Completed'),
(7,7,7,'2024-09-07','Scheduled'),
(8,8,8,'2024-09-08','Completed'),
(9,9,9,'2024-09-09','Cancelled'),
(10,10,10,'2024-09-10','Scheduled');

INSERT INTO ORConsumableUsed VALUES
(1,1,1,5),
(2,2,2,10),
(3,3,3,3),
(4,4,4,8),
(5,5,5,6),
(6,6,6,2),
(7,7,7,4),
(8,8,8,1),
(9,9,9,7),
(10,10,10,3);

-- ===========================
-- 10. Document Management
-- ===========================
CREATE TABLE Document (
    document_id INT PRIMARY KEY,
    encounter_id INT,
    document_type VARCHAR(50),
    uri VARCHAR(200),
    creation_timestamp DATETIME,
    FOREIGN KEY (encounter_id) REFERENCES Encounter(encounter_id)
);


INSERT INTO Document (document_id, encounter_id, document_type, uri, creation_timestamp) VALUES
(1, 1, 'Consent', '/docs/consent1.pdf','2024-09-01 08:00:00'),
(2, 2, 'Consent', '/docs/consent2.pdf','2024-09-02 08:15:00'),
(3, 3, 'Consent', '/docs/consent3.pdf','2024-09-03 08:30:00'),
(4, 4, 'Consent', '/docs/consent4.pdf','2024-09-04 08:45:00'),
(5, 5, 'Consent', '/docs/consent5.pdf','2024-09-05 09:00:00'),
(6, 6, 'Consent', '/docs/consent6.pdf','2024-09-06 09:15:00'),
(7, 7, 'Consent', '/docs/consent7.pdf','2024-09-07 09:30:00'),
(8, 8, 'Consent', '/docs/consent8.pdf','2024-09-08 09:45:00'),
(9, 9, 'Consent', '/docs/consent9.pdf','2024-09-09 10:00:00'),
(10, 10, 'Consent', '/docs/consent10.pdf','2024-09-10 10:15:00');

-- ===========================
-- 11. Administration and Security
-- ===========================
CREATE TABLE User (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    password_hash VARCHAR(100),
    provider_id INT,
    email VARCHAR(100),
    status VARCHAR(20),
    FOREIGN KEY (provider_id) REFERENCES Provider(provider_id)
);

CREATE TABLE Role (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(50)
);

CREATE TABLE UserRoleEntry (
    user_id INT,
    role_id INT,
    PRIMARY KEY(user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

CREATE TABLE AuditEvent (
    audit_id INT PRIMARY KEY,
    user_id INT,
    action VARCHAR(50),
    entity_type VARCHAR(50),
    entity_id INT,
    timestamp DATETIME,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

INSERT INTO User VALUES
(1,'user1','hash1',1,'user1@hospital.com','Active'),
(2,'user2','hash2',2,'user2@hospital.com','Active'),
(3,'user3','hash3',3,'user3@hospital.com','Active'),
(4,'user4','hash4',4,'user4@hospital.com','Active'),
(5,'user5','hash5',5,'user5@hospital.com','Active'),
(6,'user6','hash6',6,'user6@hospital.com','Active'),
(7,'user7','hash7',7,'user7@hospital.com','Active'),
(8,'user8','hash8',8,'user8@hospital.com','Active'),
(9,'user9','hash9',9,'user9@hospital.com','Active'),
(10,'user10','hash10',10,'user10@hospital.com','Active');

INSERT INTO Role VALUES
(1,'Admin'),
(2,'Doctor'),
(3,'Nurse'),
(4,'Receptionist'),
(5,'Pharmacist'),
(6,'Lab Technician'),
(7,'Billing'),
(8,'Inventory Manager'),
(9,'Security'),
(10,'IT Support');

INSERT INTO UserRoleEntry VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

INSERT INTO AuditEvent VALUES
(1,1,'Login','Patient',1,'2024-09-01 08:00:00'),
(2,2,'Update','Appointment',2,'2024-09-02 09:00:00'),
(3,3,'Delete','Order',3,'2024-09-03 10:00:00'),
(4,4,'Create','Invoice',4,'2024-09-04 11:00:00'),
(5,5,'Login','Encounter',5,'2024-09-05 12:00:00'),
(6,6,'Update','Prescription',6,'2024-09-06 13:00:00'),
(7,7,'Delete','Patient',7,'2024-09-07 14:00:00'),
(8,8,'Create','Claim',8,'2024-09-08 15:00:00'),
(9,9,'Login','Document',9,'2024-09-09 16:00:00'),
(10,10,'Update','StockTransaction',10,'2024-09-10 17:00:00');
SET FOREIGN_KEY_CHECKS = 1;