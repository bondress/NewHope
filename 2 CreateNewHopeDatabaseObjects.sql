--Creating all Schemas and Tables for the NewHope Database
USE NewHope
GO

PRINT 'Creating Schemas...'
GO

CREATE SCHEMA Management
GO

CREATE SCHEMA HumanResources
GO

CREATE SCHEMA Facilities
GO

CREATE SCHEMA Patients
GO

PRINT 'Creating Tables...'
GO

BEGIN TRY
CREATE TABLE Facilities.WardDetails
(
	WardID int IDENTITY(1,1) CONSTRAINT pkWardID PRIMARY KEY,
	WardName varchar(15) CONSTRAINT chkWardName
	CHECK(WardName IN ('OPD','ICU','CCU','Spl_Ward', 'General_Ward', 'Emergency')) NOT NULL,
	Total_Beds smallint NOT NULL,
	Ward_Charge float NOT NULL,
	Avail_Beds smallint NOT NULL
)

CREATE TABLE HumanResources.DoctorDetails
(
	DoctorID int IDENTITY(1,1) CONSTRAINT pkDoctorID PRIMARY KEY,
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL,
	Address varchar(50)NOT NULL,
	Phone_Num char(19) NOT NULL,
	Employment_Type varchar(25) CONSTRAINT chkEmployment_Type 
	CHECK (Employment_Type IN ('Resident', 'Visiting')) NOT NULL,
	Ward_ID int CONSTRAINT fkDoctorDetailsWardID FOREIGN KEY
	REFERENCES Facilities.WardDetails,
	Specialization varchar(30)
)

CREATE TABLE Patients.PatientDetails
(
	PatientID INT IDENTITY(1,1) CONSTRAINT pkPatientID PRIMARY KEY,
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL,
	Address varchar(50) NOT NULL,
	Age tinyint CONSTRAINT chkPatientAge CHECK (Age > 0),
	Height decimal CONSTRAINT chkPatientHeight CHECK(Height > 0),
	Weight decimal CONSTRAINT chkPatientWeight CHECK(Weight > 0),
	Blood_Grp varchar(3) CONSTRAINT chkPatientBlood_Grp
	CHECK(Blood_Grp IN ('A', 'B', 'AB', 'O')),
	Admit_Date datetime CONSTRAINT chkAdmit_Date
	CHECK(Admit_Date >= getdate()),
	Discharge_Date datetime CONSTRAINT chkDischarge_Date
	CHECK(Discharge_Date >= getdate()),
	TreatmentType varchar(30) NOT NULL,
	DoctorID int CONSTRAINT fkPatientDetailsDoctorID FOREIGN KEY
	REFERENCES HumanResources.DoctorDetails,
	Ward_ID int CONSTRAINT fkPatientDetailsWardID FOREIGN KEY 
	REFERENCES Facilities.WardDetails,
	Phone_Num char(19) NOT NULL
)

CREATE TABLE Management.Payments
(
	PaymentID int IDENTITY(1,1) CONSTRAINT pkPaymentID PRIMARY KEY,
	PatientID int CONSTRAINT fkPaymentsPatientID FOREIGN KEY
	REFERENCES Patients.PatientDetails,
	PaymentDate datetime CONSTRAINT chkPaymentDate
	CHECK (PaymentDate >= getdate()),
	PaymentMethod varchar(12) CONSTRAINT chkPaymentMethod 
	CHECK (PaymentMethod IN('Cash', 'Check', 'Credit_Card')) NOT NULL,
	CC_Num char(16),
	CardHoldersName varchar(50),
	Check_Num smallint,
	AdvancePayment float,
	FinalPayment float,
	PaymentStatus varchar(10)
)

CREATE TABLE Patients.MedicalHistory
(
	RecordID int IDENTITY(1,1) CONSTRAINT pkRecordID PRIMARY KEY,
	PatientID int CONSTRAINT fkMedicalHistoryPatientID FOREIGN KEY
	REFERENCES Patients.PatientDetails,
	DoctorID int CONSTRAINT fkMedicalHistoryDoctorID FOREIGN KEY
	REFERENCES HumanResources.DoctorDetails,
	Disease varchar(50) NOT NULL,
	OriginalWard int CONSTRAINT fkOriginalWard FOREIGN KEY
	REFERENCES Facilities.WardDetails,
	DischargeWard int CONSTRAINT fkDischargeWardID FOREIGN KEY
	REFERENCES Facilities.WardDetails
)

PRINT 'NewHope tables created successfully!'
END TRY
BEGIN CATCH
PRINT 'An error occured!'
PRINT 'Error Message: '+ ERROR_MESSAGE()
PRINT 'Error Line: ' + CONVERT(VARCHAR,ERROR_LINE())
END CATCH
GO

CREATE VIEW vwPatientReport
AS
SELECT p.PatientID "Patient ID", p.FirstName + ' ' + p.LastName "Patient Name", p.Address, Age,
Blood_Grp "Blood Group", Height, Weight, Admit_Date "Date Admitted",
Discharge_Date "Date Discharged", Disease, OriginalWard "Original Ward",
DischargeWard "Discharge Ward", dd.FirstName + ' ' + dd.LastName "Doctor Name",
PaymentStatus "Payment Status" 
FROM Patients.PatientDetails p
JOIN Patients.MedicalHistory mh
ON p.PatientID = mh.PatientID
JOIN Facilities.WardDetails wd
ON p.Ward_ID = wd.WardID
JOIN HumanResources.DoctorDetails dd
ON p.DoctorID = dd.DoctorID
JOIN Management.Payments py
ON p.PatientID = py.PatientID
GO

PRINT 'Creating NewHope Rules...'
GO
CREATE RULE DoctorPhone_Num
AS
@Phone_Num LIKE '[0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]'
GO
CREATE RULE PatientPhone_Num
AS
@Phone_Num LIKE '[0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]'
GO

PRINT 'Binding NewHope Rules'
GO
sp_bindrule 'DoctorPhone_Num', 'HumanResources.DoctorDetails.Phone_Num'
GO
sp_bindrule 'PatientPhone_Num', 'Patients.PatientDetails.Phone_Num'
GO

PRINT 'NewHope Constraints created successfully!'
GO