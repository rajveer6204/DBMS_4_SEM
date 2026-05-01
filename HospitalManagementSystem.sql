-- || NAME : Badal Prasad ||
-- || ROLL NO. : 2501351020 ||
-- || COURSE  : DBMS ||

-- ================================
-- CREATE DATABASE
-- ================================
CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

-- ================================
-- TABLE: Doctors
-- ================================
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    specialization VARCHAR(50)
);

INSERT INTO Doctors (name, specialization) VALUES
('Rajveer Singh', 'Cardiologist'),
('Badal Prasad', 'Neurologist'),
('Shruti Singh', 'Pediatrician'),
('Shiv', 'Orthopedic'),
('Aditya', 'General Physician');

-- ================================
-- TABLE: Patients
-- ================================
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    contact VARCHAR(15)
);

INSERT INTO Patients (name, age, gender, contact) VALUES
('Aryan Goyal', 22, 'Male', '9000000001'),
('Vansh Goel', 23, 'Male', '9000000002'),
('Rashi Yadav', 21, 'Female', '9000000003'),
('Saumya Barthwal', 24, 'Female', '9000000004'),
('Abhay Mundepi', 25, 'Male', '9000000005'),
('Sanjeev Sangwan', 30, 'Male', '9000000006'),
('Harsh Panchal', 26, 'Male', '9000000007'),
('Yuvraj', 20, 'Male', '9000000008'),
('Krish', 19, 'Male', '9000000009'),
('Devansh Thakur', 27, 'Male', '9000000010'),
('Shailjanand', 28, 'Male', '9000000011'),
('Manju', 35, 'Female', '9000000012'),
('Tarun Yadav', 29, 'Male', '9000000013'),
('Adit Ghosh', 23, 'Male', '9000000014'),
('Vipul', 31, 'Male', '9000000015'),
('Subhrajeet Dash', 32, 'Male', '9000000016');

-- ================================
-- TABLE: Medical_History
-- ================================
CREATE TABLE Medical_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    disease VARCHAR(100),
    treatment VARCHAR(100),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

INSERT INTO Medical_History (patient_id, disease, treatment) VALUES
(1, 'Fever', 'Paracetamol'),
(2, 'Migraine', 'Painkillers'),
(3, 'Diabetes', 'Insulin'),
(4, 'Asthma', 'Inhaler'),
(5, 'Fracture', 'Surgery'),
(6, 'Hypertension', 'Medication'),
(7, 'Cold', 'Antibiotics'),
(8, 'Allergy', 'Antihistamine'),
(9, 'Flu', 'Rest and Fluids'),
(10, 'Infection', 'Antibiotics');

-- ================================
-- TABLE: Appointments
-- ================================
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2026-05-03', 'Scheduled'),
(2, 2, '2026-05-04', 'Completed'),
(3, 3, '2026-05-05', 'Scheduled'),
(4, 4, '2026-05-06', 'Completed'),
(5, 5, '2026-05-07', 'Scheduled'),
(6, 1, '2026-05-08', 'Completed'),
(7, 2, '2026-05-09', 'Scheduled'),
(8, 3, '2026-05-10', 'Completed'),
(9, 4, '2026-05-11', 'Scheduled'),
(10, 5, '2026-05-12', 'Completed');

-- ================================
-- TABLE: Departments
-- ================================
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50)
);

INSERT INTO Departments (dept_name) VALUES
('Cardiology'),
('Neurology'),
('Pediatrics'),
('Orthopedics'),
('General Medicine'),
('Dermatology'),
('Oncology'),
('Radiology'),
('ENT'),
('Gastroenterology');

-- ================================
-- TABLE: Admissions
-- ================================
CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    dept_id INT,
    admission_date DATE,
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

INSERT INTO Admissions (patient_id, dept_id, admission_date, discharge_date) VALUES
(1, 1, '2026-05-01', NULL),
(2, 2, '2026-05-02', '2026-05-05'),
(3, 3, '2026-05-03', NULL),
(4, 4, '2026-05-04', '2026-05-06'),
(5, 5, '2026-05-05', NULL),
(6, 6, '2026-05-06', NULL),
(7, 7, '2026-05-07', '2026-05-10'),
(8, 8, '2026-05-08', NULL),
(9, 9, '2026-05-09', '2026-05-12'),
(10, 10, '2026-05-10', NULL);

-- ================================
-- QUERIES
-- ================================

-- Track Patient Admissions
SELECT p.name, d.dept_name, a.admission_date
FROM Admissions a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Departments d ON a.dept_id = d.dept_id;

-- Track Discharges
SELECT p.name, a.discharge_date
FROM Admissions a
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.discharge_date IS NOT NULL;

-- Track Transfers
SELECT p.name, d.dept_name
FROM Admissions a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Departments d ON a.dept_id = d.dept_id
ORDER BY p.name;

-- Surgery Scheduling
SELECT p.name, d.name AS doctor, a.appointment_date
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE a.status = 'Scheduled';

-- Department-wise Patient Count
SELECT d.dept_name, COUNT(a.patient_id) AS total_patients
FROM Admissions a
JOIN Departments d ON a.dept_id = d.dept_id
GROUP BY d.dept_name;

-- Patients Without Discharge
SELECT p.name, a.admission_date
FROM Admissions a
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.discharge_date IS NULL;

-- Doctor-wise Appointments
SELECT d.name AS doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.name;