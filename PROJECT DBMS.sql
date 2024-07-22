-- Create Patient table
DROP TABLE Patient;
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    ContactNumber VARCHAR(15),
    Address VARCHAR(100)
);

-- Insert data into Patient table
INSERT INTO Patient (PatientID, FirstName, LastName, DateOfBirth, Gender, ContactNumber, Address)
VALUES
(1, 'Muaaz', 'Hussan', '1990-05-15', 'Male', '123-456-7890', '123 Main St'),
(2, 'Mehwish', 'Nasir', '1985-08-20', 'Female', '987-654-3210', '456 Mr St'),
(3, 'Aatiqa', 'Sadiq', '1992-02-10', 'Female', '555-123-4567', '789 Jr St');


-- Create Doctor table
DROP TABLE Doctor;
CREATE TABLE Doctor (
 DoctorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialization VARCHAR(50),
    ContactNumber VARCHAR(15),
    Email VARCHAR(50)
);

INSERT INTO Doctor (DoctorID, FirstName, LastName, Specialization, ContactNumber, Email)
VALUES
(1, 'Dr. Ali', 'Hussan', 'Cardiologist', '555-888-7777', 'ali@example.com'),
(2, 'Dr. Abdul', 'Ahad', 'Orthopedic Surgeon', '555-999-6666', 'ahad@example.com'),
(3, 'Dr. Dua', 'Nasir', 'Pediatrician', '555-777-8888', 'dua@example.com');

-- Create Appointment table
DROP TABLE Appointment
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME,
    Reason VARCHAR(255),
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

-- Insert data into Appointment table
INSERT INTO Appointment (AppointmentID, PatientID, DoctorID, AppointmentDate, Reason, Status)
VALUES
(101, 1, 1, '2023-01-15 10:00:00', 'Regular Checkup', 'Scheduled'),
(102, 2, 2, '2023-02-20 14:30:00', 'Knee Pain', 'Completed'),
(103, 3, 3, '2023-03-05 09:45:00', 'Child Vaccination', 'Scheduled');

-- Create Diagnosis table
DROP TABLE Diagnosis;
CREATE TABLE Diagnosis (
    DiagnosisID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    DiagnosisDate DATETIME,
    Description VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

INSERT INTO Diagnosis (DiagnosisID, PatientID, DoctorID, DiagnosisDate, Description)
VALUES
(201, 1, 1, '2023-01-20', 'Healthy'),
(202, 2, 2, '2023-02-25', 'Strained Ligament'),
(203, 3, 3, '2023-03-10', 'Normal');


-- Create Medication table
DROP TABLE Medication;
CREATE TABLE Medication (
    MedicationID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    MedicationName VARCHAR(50),
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

INSERT INTO Medication (MedicationID, PatientID, DoctorID, MedicationName, Dosage, Frequency, StartDate, EndDate)
VALUES
(301, 1, 1, 'Aspirin', '1 tablet', 'Once a day', '2023-01-20', '2023-01-27'),
(302, 2, 2, 'Ibuprofen', '1 tablet', 'Twice a day', '2023-02-25', '2023-03-10'),
(303, 3, 3, 'Multivitamin', '1 tablet', 'Once a day', '2023-03-10', '2023-03-17');


-- Create TestResult table
DROP TABLE TestResult;
CREATE TABLE TestResult (
    TestResultID INT PRIMARY KEY,
    PatientID INT,
    TestDate DATETIME,
    TestName VARCHAR(50),
    Result VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

INSERT INTO TestResult (TestResultID, PatientID, TestDate, TestName, Result)
VALUES
(401, 1, '2023-01-25', 'Blood Pressure', '120/80'),
(402, 2, '2023-03-01', 'X-Ray', 'Normal'),
(403, 3, '2023-03-15', 'Blood Test', 'Healthy');

-- Create Billing table
DROP TABLE Billing;
CREATE TABLE Billing (
    BillingID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentID INT,
    BillingDate DATETIME,
    TotalAmount DECIMAL(10, 2),
    PaymentStatus VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

-- Insert data into Billing table
INSERT INTO Billing (BillingID, PatientID, DoctorID, AppointmentID, BillingDate, TotalAmount, PaymentStatus)
VALUES
(501, 1, 1, 101, '2023-01-15', 150.00, 'Paid'),
(502, 2, 2, 102, '2023-02-20', 200.00, 'Paid'),
(503, 3, 3, 103, '2023-03-05', 100.00, 'Unpaid');

SELECT * FROM Patient;
SELECT * FROM Doctor;
SELECT * FROM Appointment;
SELECT * FROM Diagnosis;
SELECT * FROM Medication;
SELECT * FROM TestResult;
SELECT * FROM Billing;

--1.Count the number of completed appointments
SELECT COUNT(*) AS NumberOfReturns
FROM Appointment
WHERE Status = 'Completed';

--2.Show doctors and their respective specializations:
SELECT Doctor.FirstName, Doctor.LastName, Doctor.Specialization
FROM Doctor;

--3.Retrieve patient details for a specific appointment:
SELECT patient.*, a.AppointmentDate, a.Reason,a.Status
FROM Patient 
JOIN Appointment a ON patient.PatientID = a.PatientID
WHERE a.AppointmentID = 101;

--4.List all appointments along with corresponding doctor details:
SELECT Appointment.*, Doctor.FirstName AS DoctorFirstName, Doctor.LastName AS DoctorLastName, Doctor.Specialization
FROM Appointment
JOIN Doctor  ON Appointment.DoctorID = Doctor.DoctorID;

--5.Find patients with their diagnosis details:
SELECT Patient.*, Diagnosis.DiagnosisDate, Diagnosis.Description
FROM Patient
LEFT JOIN Diagnosis ON Patient.PatientID = Diagnosis.PatientID;

--6.Retrieve medication details for a specific patient:
SELECT Medication.*, Doctor.FirstName AS DoctorFirstName, Doctor.LastName AS DoctorLastName
FROM Medication
JOIN Doctor ON Medication.DoctorID = Doctor.DoctorID
WHERE Medication.PatientID = 1;

--7.List test results along with patient names:
SELECT TestResult.*, Patient.FirstName AS PatientFirstName, Patient.LastName AS PatientLastName
FROM TestResult
JOIN Patient ON TestResult.PatientID = Patient.PatientID;

--8.Show billing details for a specific patient:
SELECT Billing.*, Patient.FirstName AS PatientFirstName, Patient.LastName AS PatientLastName
FROM Billing
JOIN Patient ON Billing.PatientID = Patient.PatientID
WHERE Billing.PatientID = 1;

--9.Show billing details for appointments that are unpaid:
SELECT Billing.*, Patient.FirstName AS PatientFirstName, Patient.LastName AS PatientLastName
FROM Billing
JOIN Patient ON Billing.PatientID = Patient.PatientID
WHERE Billing.PaymentStatus = 'Unpaid';

--10.Find patients with a specific diagnosis:
SELECT Patient.*, Diagnosis.DiagnosisDate, Diagnosis.Description
FROM Patient
JOIN Diagnosis ON Patient.PatientID = Diagnosis.PatientID
WHERE Diagnosis.Description = 'Strained Ligament';

-- 11.Show billing details for appointments that are unpaid:
SELECT Billing.*, Patient.FirstName AS PatientFirstName, Patient.LastName AS PatientLastName
FROM Billing
JOIN Patient ON Billing.PatientID = Patient.PatientID
WHERE Billing.PaymentStatus = 'Unpaid';

--12.List all medications prescribed by a specific doctor:
SELECT Medication.*, Patient.FirstName AS PatientFirstName, Patient.LastName AS PatientLastName
FROM Medication
JOIN Patient ON Medication.PatientID = Patient.PatientID
WHERE Medication.DoctorID = 1;

--13.Find patients with a specific diagnosis:
SELECT Patient.*, Diagnosis.DiagnosisDate, Diagnosis.Description
FROM Patient
JOIN Diagnosis ON Patient.PatientID = Diagnosis.PatientID
WHERE Diagnosis.Description = 'Strained Ligament';











