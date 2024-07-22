# Medical Database SQL Script

This SQL script creates and populates a database for managing a medical facility's information, including patients, doctors, appointments, diagnoses, medications, test results, and billing. The script also provides several queries to extract and analyze data from the database.

## Table of Contents

1. [Tables Creation](#tables-creation)
   - Patient
   - Doctor
   - Appointment
   - Diagnosis
   - Medication
   - TestResult
   - Billing
2. [Data Insertion](#data-insertion)
3. [Sample Queries](#sample-queries)
4. [Usage](#usage)

## Tables Creation

### Patient Table
This table stores patient information.

```sql
DROP TABLE IF EXISTS Patient;
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    ContactNumber VARCHAR(15),
    Address VARCHAR(100)
);
```

### Doctor Table
This table stores doctor information.

```sql
DROP TABLE IF EXISTS Doctor;
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialization VARCHAR(50),
    ContactNumber VARCHAR(15),
    Email VARCHAR(50)
);
```

### Appointment Table
This table stores appointment information.

```sql
DROP TABLE IF EXISTS Appointment;
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
```

### Diagnosis Table
This table stores diagnosis information.

```sql
DROP TABLE IF EXISTS Diagnosis;
CREATE TABLE Diagnosis (
    DiagnosisID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    DiagnosisDate DATETIME,
    Description VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);
```

### Medication Table
This table stores medication information.

```sql
DROP TABLE IF EXISTS Medication;
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
```

### TestResult Table
This table stores test result information.

```sql
DROP TABLE IF EXISTS TestResult;
CREATE TABLE TestResult (
    TestResultID INT PRIMARY KEY,
    PatientID INT,
    TestDate DATETIME,
    TestName VARCHAR(50),
    Result VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
```

### Billing Table
This table stores billing information.

```sql
DROP TABLE IF EXISTS Billing;
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
```

## Data Insertion

Insert sample data into the tables.

```sql
-- Insert data into Patient table
INSERT INTO Patient (PatientID, FirstName, LastName, DateOfBirth, Gender, ContactNumber, Address)
VALUES
(1, 'Muaaz', 'Hussan', '1990-05-15', 'Male', '123-456-7890', '123 Main St'),
(2, 'Mehwish', 'Nasir', '1985-08-20', 'Female', '987-654-3210', '456 Mr St'),
(3, 'Aatiqa', 'Sadiq', '1992-02-10', 'Female', '555-123-4567', '789 Jr St');

-- Insert data into Doctor table
INSERT INTO Doctor (DoctorID, FirstName, LastName, Specialization, ContactNumber, Email)
VALUES
(1, 'Dr. Ali', 'Hussan', 'Cardiologist', '555-888-7777', 'ali@example.com'),
(2, 'Dr. Abdul', 'Ahad', 'Orthopedic Surgeon', '555-999-6666', 'ahad@example.com'),
(3, 'Dr. Dua', 'Nasir', 'Pediatrician', '555-777-8888', 'dua@example.com');

-- Insert data into Appointment table
INSERT INTO Appointment (AppointmentID, PatientID, DoctorID, AppointmentDate, Reason, Status)
VALUES
(101, 1, 1, '2023-01-15 10:00:00', 'Regular Checkup', 'Scheduled'),
(102, 2, 2, '2023-02-20 14:30:00', 'Knee Pain', 'Completed'),
(103, 3, 3, '2023-03-05 09:45:00', 'Child Vaccination', 'Scheduled');

-- Insert data into Diagnosis table
INSERT INTO Diagnosis (DiagnosisID, PatientID, DoctorID, DiagnosisDate, Description)
VALUES
(201, 1, 1, '2023-01-20', 'Healthy'),
(202, 2, 2, '2023-02-25', 'Strained Ligament'),
(203, 3, 3, '2023-03-10', 'Normal');

-- Insert data into Medication table
INSERT INTO Medication (MedicationID, PatientID, DoctorID, MedicationName, Dosage, Frequency, StartDate, EndDate)
VALUES
(301, 1, 1, 'Aspirin', '1 tablet', 'Once a day', '2023-01-20', '2023-01-27'),
(302, 2, 2, 'Ibuprofen', '1 tablet', 'Twice a day', '2023-02-25', '2023-03-10'),
(303, 3, 3, 'Multivitamin', '1 tablet', 'Once a day', '2023-03-10', '2023-03-17');

-- Insert data into TestResult table
INSERT INTO TestResult (TestResultID, PatientID, TestDate, TestName, Result)
VALUES
(401, 1, '2023-01-25', 'Blood Pressure', '120/80'),
(402, 2, '2023-03-01', 'X-Ray', 'Normal'),
(403, 3, '2023-03-15', 'Blood Test', 'Healthy');

-- Insert data into Billing table
INSERT INTO Billing (BillingID, PatientID, DoctorID, AppointmentID, BillingDate, TotalAmount, PaymentStatus)
VALUES
(501, 1, 1, 101, '2023-01-15', 150.00, 'Paid'),
(502, 2, 2, 102, '2023-02-20', 200.00, 'Paid'),
(503, 3, 3, 103, '2023-03-05', 100.00, 'Unpaid');
```

## Sample Queries

### 1. Count the number of completed appointments

```sql
SELECT COUNT(*) AS NumberOfCompletedAppointments
FROM Appointment
WHERE Status = 'Completed';
```

### 2. Show doctors and their respective specializations

```sql
SELECT FirstName, LastName, Specialization
FROM Doctor;
```

### 3. Retrieve patient details for a specific appointment

```sql
SELECT Patient.*, Appointment.AppointmentDate, Appointment.Reason, Appointment.Status
FROM Patient
JOIN Appointment ON Patient.PatientID = Appointment.PatientID
WHERE Appointment.AppointmentID = 101;
```

### 4. List all appointments along with corresponding doctor details

```sql
SELECT Appointment.*, Doctor.FirstName AS DoctorFirstName, Doctor.LastName AS DoctorLastName, Doctor.Specialization
FROM Appointment
JOIN Doctor ON Appointment.DoctorID = Doctor.DoctorID;
```

### 5. Find patients with their diagnosis details

```sql
SELECT Patient.*, Diagnosis.DiagnosisDate, Diagnosis.Description
FROM Patient
LEFT JOIN Diagnosis ON Patient.PatientID = Diagnosis.PatientID;
```

### 6. Retrieve medication details for a specific patient

```sql
SELECT Medication.*, Doctor.FirstName AS DoctorFirstName, Doctor.LastName AS DoctorLastName
FROM Medication
JOIN Doctor ON Medication.DoctorID = Doctor.DoctorID
WHERE Medication.PatientID = 1;
```

### 7. List test results along with patient names

```sql
SELECT TestResult.*, Patient.FirstName AS PatientFirstName, Patient.LastName AS PatientLastName
FROM TestResult
JOIN Patient ON TestResult.PatientID = Patient.PatientID;
```

### 8. Show billing details for a specific patient

```sql
SELECT Billing.*, Patient.FirstName AS PatientFirstName, Patient.LastName AS PatientLastName
FROM Billing
JOIN Patient ON Billing.PatientID = Patient.PatientID
WHERE Billing.PatientID = 1;
```

### 9. Show billing details for appointments that are unpaid

```sql
SELECT Billing.*, Patient.FirstName AS PatientFirstName, Patient.LastName AS PatientLastName
FROM Billing
JOIN Patient ON Billing.PatientID = Patient.PatientID
WHERE Billing.PaymentStatus = 'Unpaid';
```

### 10. Find

 patients with a specific diagnosis

```sql
SELECT Patient.*, Diagnosis.DiagnosisDate, Diagnosis.Description
FROM Patient
JOIN Diagnosis ON Patient.PatientID = Diagnosis.PatientID
WHERE Diagnosis.Description = 'Strained Ligament';
```

### 11. Show billing details for appointments that are unpaid

```sql
SELECT Billing.*, Patient.FirstName AS PatientFirstName, Patient.LastName AS PatientLastName
FROM Billing
JOIN Patient ON Billing.PatientID = Patient.PatientID
WHERE Billing.PaymentStatus = 'Unpaid';
```

### 12. List all medications prescribed by a specific doctor

```sql
SELECT Medication.*, Patient.FirstName AS PatientFirstName, Patient.LastName AS PatientLastName
FROM Medication
JOIN Patient ON Medication.PatientID = Patient.PatientID
WHERE Medication.DoctorID = 1;
```

### 13. Find patients with a specific diagnosis

```sql
SELECT Patient.*, Diagnosis.DiagnosisDate, Diagnosis.Description
FROM Patient
JOIN Diagnosis ON Patient.PatientID = Diagnosis.PatientID
WHERE Diagnosis.Description = 'Strained Ligament';
```

## Usage

1. **Create Tables**: Execute the `CREATE TABLE` statements to create the necessary tables.
2. **Insert Data**: Execute the `INSERT INTO` statements to populate the tables with sample data.
3. **Run Queries**: Execute the provided sample queries to extract and analyze data from the database.

This script can be used as a foundation for a more comprehensive medical database system, and the queries can be adapted to suit specific reporting and data retrieval needs.
