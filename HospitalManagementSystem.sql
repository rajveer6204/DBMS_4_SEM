                  -- create database  
CREATE DATABASE HospitalDB;
USE HospitalDB;
                      -- Create Tables Patients
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15),
    address TEXT
);
                                      -- create table Departments
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100)
);
									  -- create table Doctors
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    specialization VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

                                             -- create table Appointments
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    status VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

                                -- create table Medical_History
CREATE TABLE Medical_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    diagnosis TEXT,
    allergies TEXT,
    past_treatments TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);
                                                    -- create table Treatments 
CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    treatment_details TEXT,
    treatment_date DATETIME,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);
                                                     -- create table Admissions
CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    department_id INT,
    admission_date DATETIME,
    discharge_date DATETIME,
    status VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
                                                      -- create table Transfers    
 CREATE TABLE Transfers (
    transfer_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    from_department INT,
    to_department INT,
    transfer_date DATETIME,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (from_department) REFERENCES Departments(department_id),
    FOREIGN KEY (to_department) REFERENCES Departments(department_id)
);
                                                            -- || Insert Data ||
                                                            
									  -- Departments
INSERT INTO Departments (department_name) VALUES
('Cardiology'),
('Neurology'),
('Orthopedics'),
('General Medicine'),
('Emergency');
									-- Patients
INSERT INTO Patients (name, age, gender, phone, address) VALUES
('Amit Sharma', 45, 'Male', '9876543210', 'Delhi'),
('Neha Verma', 30, 'Female', '9123456780', 'Noida'),
('Rahul Singh', 55, 'Male', '9988776655', 'Ghaziabad'),
('Priya Mehta', 25, 'Female', '9090909090', 'Delhi'),
('Karan Patel', 40, 'Male', '8888888888', 'Gurgaon');
 
                                      -- Doctors
INSERT INTO Doctors (name, specialization, department_id) VALUES
('Dr. Rajeer Kumar', 'Cardiologist', 1),
('Dr. Badal ', 'Neurologist', 2),
('Dr. Vivek Singh', 'Orthopedic', 3),
('Dr. Meera Nair', 'Physician', 4),
('Dr. Arjun Kapoor', 'Emergency Specialist', 5);

                                           --  Appointments
                                           
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2026-04-20 10:00:00', 'Completed'),
(2, 2, '2026-04-21 11:00:00', 'Completed'),
(3, 3, '2026-04-22 09:30:00', 'Scheduled'),
(4, 4, '2026-04-23 12:00:00', 'Completed'),
(5, 5, '2026-04-24 14:00:00', 'Scheduled');

                                            --  Medical_History
  INSERT INTO Medical_History (patient_id, diagnosis, allergies, past_treatments) VALUES
(1, 'Hypertension', 'None', 'Medication'),
(2, 'Migraine', 'Dust', 'Painkillers'),
(3, 'Fracture (Leg)', 'None', 'Surgery'),
(4, 'Fever', 'Pollen', 'Antibiotics'),
(5, 'Chest Pain', 'None', 'Observation');

											-- Treatments
INSERT INTO Treatments (patient_id, doctor_id, treatment_details, treatment_date) VALUES
(1, 1, 'Blood pressure control medication', '2026-04-20'),
(2, 2, 'Migraine therapy', '2026-04-21'),
(3, 3, 'Leg fracture surgery', '2026-04-22'),
(4, 4, 'Fever treatment', '2026-04-23'),
(5, 5, 'Emergency chest pain care', '2026-04-24');

                                             -- Admissions
INSERT INTO Admissions (patient_id, department_id, admission_date, discharge_date, status) VALUES
(1, 1, '2026-04-18', '2026-04-22', 'Discharged'),
(2, 2, '2026-04-19', NULL, 'Admitted'),
(3, 3, '2026-04-20', NULL, 'Admitted'),
(4, 4, '2026-04-21', '2026-04-23', 'Discharged'),
(5, 5, '2026-04-24', NULL, 'Admitted');

                                         -- Transfers
INSERT INTO Transfers (patient_id, from_department, to_department, transfer_date) VALUES
(2, 2, 4, '2026-04-22'),
(3, 3, 5, '2026-04-23'),
(5, 5, 1, '2026-04-25');


                                                           -- ||Queries ||
                                 -- Admissions
SELECT p.name, d.department_name, a.admission_date, a.status
FROM Admissions a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Departments d ON a.department_id = d.department_id;

                                 -- Discharges
SELECT p.name, a.discharge_date
FROM Admissions a
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.status = 'Discharged';

                                     -- Current Patients
SELECT p.name, d.department_name
FROM Admissions a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Departments d ON a.department_id = d.department_id
WHERE a.status = 'Admitted';

                                       -- Transfers
SELECT 
    p.name,
    d1.department_name AS from_department,
    d2.department_name AS to_department,
    t.transfer_date
FROM Transfers t
JOIN Patients p ON t.patient_id = p.patient_id
JOIN Departments d1 ON t.from_department = d1.department_id
JOIN Departments d2 ON t.to_department = d2.department_id;