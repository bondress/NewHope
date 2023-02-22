--Creating NewHope Functions and Triggers
USE NewHope
GO

PRINT 'Creating NewHope Functions and Triggers...'
GO

--User-Defined Function to compute Doctor's Rate based on Doctor's ID
CREATE FUNCTION HumanResources.DoctorEmploymentRate(@DoctorID int)
RETURNS float
AS
BEGIN
DECLARE @Employment_Type varchar(10)
SELECT @Employment_Type = Employment_Type FROM HumanResources.DoctorDetails
WHERE DoctorID = @DoctorID
IF(@Employment_Type = 'Visiting')
BEGIN
RETURN 500.55
END
--If Employment_Type = Resident
RETURN 350.25
END
GO

--User-Defined Function to compute number of days admitted for each patient
CREATE FUNCTION Patients.NumberOfDaysAdmitted(@PatientID int)
RETURNS int
AS
BEGIN
DECLARE @Admit_Date datetime
DECLARE @Discharge_Date datetime
DECLARE @TreatmentType varchar(30)
DECLARE @NumberOfDaysAdmitted int
SELECT @Admit_Date = Admit_Date 
FROM Patients.PatientDetails
WHERE PatientID = @PatientID
SELECT @Discharge_Date = Discharge_Date
FROM Patients.PatientDetails
WHERE PatientID = @PatientID
SELECT @TreatmentType = TreatmentType 
FROM Patients.PatientDetails
WHERE PatientID = @PatientID
SELECT @NumberOfDaysAdmitted = DATEDIFF(dd, @Admit_Date, @Discharge_Date)
FROM Patients.PatientDetails
RETURN @NumberOfDaysAdmitted
END
GO

/*User-Defined Function to compute fee of Doctor assigned 
to a particular patient
*/
CREATE FUNCTION HumanResources.ComputeDoctorFee(@PatientID int)
RETURNS float
AS
BEGIN
DECLARE @DoctorID int
DECLARE @DoctorEmploymentRate float
DECLARE @Admit_Date datetime
DECLARE @Discharge_Date datetime
DECLARE @TreatmentType varchar(30)
DECLARE @NumberOfDaysAdmitted int
DECLARE @Employment_Type varchar(10)
DECLARE @Specialization varchar (30)
DECLARE @SpecializationFee float
DECLARE @TotalDoctorFee float
SELECT @DoctorID = DoctorID 
FROM Patients.PatientDetails
WHERE PatientID = @PatientID
SELECT @TreatmentType = TreatmentType 
FROM Patients.PatientDetails
WHERE PatientID = @PatientID
SELECT @NumberOfDaysAdmitted = Patients.NumberOfDaysAdmitted(@PatientID)
SELECT @Employment_Type = Employment_Type FROM HumanResources.DoctorDetails
WHERE DoctorID = @DoctorID
SELECT @Specialization = Specialization FROM HumanResources.DoctorDetails
WHERE DoctorID = @DoctorID
SET @DoctorEmploymentRate = HumanResources.DoctorEmploymentRate(@DoctorID)

IF(@Specialization = 'Allergist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 824.66)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 824.66
	END
END
ELSE IF(@Specialization = 'Anesthesiologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1011.91)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 1011.91
	END
END
ELSE IF(@Specialization = 'Cardiac surgeon')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1506.85)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 1506.85
	END
END
ELSE IF(@Specialization = 'Cardiologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1117.80)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 1117.80
	END
END
ELSE IF(@Specialization = 'Dermatologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1073.97)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 1073.97
	END
END
ELSE IF(@Specialization = 'Endocrinologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1011.91)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 1011.91
	END
END
ELSE IF(@Specialization = 'Family Medicine')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 600)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 600
	END
END
ELSE IF(@Specialization = 'Gastroenterologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1147.95)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 1147.95
	END
END
ELSE IF(@Specialization = 'General Medicine')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 558.91)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 558.91
	END
END
ELSE IF(@Specialization = 'General Surgeon')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 805.98)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 805.98
	END
END
ELSE IF(@Specialization = 'Geriatric Medicine')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 521.71)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 521.71
	END
END
ELSE IF(@Specialization = 'Gynecologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 569.86)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 569.86
	END
END
ELSE IF(@Specialization = 'Infectious Disease')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 673.97)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 673.97
	END
END
ELSE IF(@Specialization = 'Intensivist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 805.98)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 805.98
	END
END
ELSE IF(@Specialization = 'Internal Medicine')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 630.13)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 630.13
	END
END
ELSE IF(@Specialization = 'Nephrologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 762.25)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 762.25
	END
END
ELSE IF(@Specialization = 'Neurologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 767.12)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 767.12
	END
END
ELSE IF(@Specialization = 'Obstetrician')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 569.86)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 569.86
	END
END
ELSE IF(@Specialization = 'Oncologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1098.63)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 1098.63
	END
END
ELSE IF(@Specialization = 'Opthamologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1035.62)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 1035.62
	END
END
ELSE IF(@Specialization = 'Orthopedic surgeon')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1361.64)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 1361.64
	END
END
ELSE IF(@Specialization = 'Otolaryngologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1245.58)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = (1245.58)
	END
END
ELSE IF(@Specialization = 'Pediatrician')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 580.82)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 580.82
	END
END
ELSE IF(@Specialization = 'Psychiatrist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 734.25)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 734.25
	END
END
ELSE IF(@Specialization = 'Pulmonologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1117.67)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 1117.67
	END
END
ELSE IF(@Specialization = 'Researcher')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1500.25)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 1500.25
	END
END
ELSE IF(@Specialization = 'Rheumatologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 717.81)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 717.81
	END
END
ELSE IF(@Specialization = 'Urologist')
BEGIN
	IF(@TreatmentType = 'Inpatient')
	BEGIN
	SET @SpecializationFee = (@NumberOfDaysAdmitted * 1142.47)
	END
	ELSE
	BEGIN
	SET @SpecializationFee = 1142.47
	END
END
SET @TotalDoctorFee = @SpecializationFee + @DoctorEmploymentRate
RETURN @TotalDoctorFee
END
GO

--User-Defined Function to compute total ward charges for each patient
CREATE FUNCTION Facilities.ComputeTotalWardCharges(@PatientID int)
RETURNS float
AS 
BEGIN
DECLARE @WardID int
DECLARE @Ward_Charge float
DECLARE @TotalWardCharge float
DECLARE @NumberOfDaysAdmitted smallint
SELECT @WardID = Ward_ID 
FROM Patients.PatientDetails
WHERE PatientID = @PatientID
SELECT @Ward_Charge = Ward_Charge
FROM Facilities.WardDetails
WHERE WardID = @WardID
SET @NumberofDaysAdmitted = Patients.NumberOfDaysAdmitted(@PatientID)
SET @TotalWardCharge = (@Ward_Charge * @NumberOfDaysAdmitted)
RETURN @TotalWardCharge
END
GO

/*User-Defined Function to compute final payment for patients
who were admitted for treatment
*/
CREATE FUNCTION Patients.ComputeFinalPayment(@PatientID int)
RETURNS float
AS
BEGIN
DECLARE @WardCharges float
DECLARE @DoctorFee float
DECLARE @TreatmentFee float
DECLARE @AdvancePayment float
DECLARE @TotalBill float
DECLARE @FinalPayment float
SET @WardCharges = Facilities.ComputeTotalWardCharges(@PatientID)
SET @DoctorFee = HumanResources.ComputeDoctorFee(@PatientID)
--Treatment fee only applies to admitted patients for tests
SET @TreatmentFee = 500.75
SELECT @AdvancePayment = AdvancePayment
FROM Management.Payments
WHERE PatientID = @PatientID
SET @TotalBill = (@WardCharges + @DoctorFee + @TreatmentFee)
SET @FinalPayment = (@TotalBill - @AdvancePayment)
RETURN @FinalPayment
END
GO

/*
INSERT and UPDATE Trigger on Management.Payments Table
to validate columns during update and insert
*/
CREATE TRIGGER Management.trgInsertPayment
ON Management.Payments
FOR INSERT, UPDATE
AS
	DECLARE @PatientID int
	DECLARE @PaymentMethod varchar(12)
	DECLARE @CC_Num char(16)
	DECLARE @CardHoldersName varchar(50)
	DECLARE @Check_Num smallint
	DECLARE @DoctorID int
	DECLARE @DoctorFee float
	DECLARE @TreatmentFee float
	DECLARE @FinalPayment float
	DECLARE @TreatmentType varchar(10)
	DECLARE @AdvancePayment float
	DECLARE @AdmitDate datetime
	DECLARE @DischargeDate datetime
	SELECT @PatientID = PatientID FROM Inserted
	SELECT @AdmitDate = Admit_Date FROM Patients.PatientDetails
	WHERE PatientID = @PatientID
	SELECT @AdvancePayment = AdvancePayment FROM Management.Payments
	WHERE PatientID = @PatientID
	SELECT @DischargeDate = Discharge_Date FROM Patients.PatientDetails
	WHERE PatientID = @PatientID
	SELECT @TreatmentType = TreatmentType FROM Patients.PatientDetails
	WHERE PatientID = @PatientID
	SELECT @DoctorID = DoctorID FROM Patients.PatientDetails
	WHERE PatientID = @PatientID
	SELECT @PaymentMethod = PaymentMethod FROM Inserted
	SELECT @CC_Num = CC_Num FROM Inserted
	SELECT @CardHoldersName = CardHoldersName FROM Inserted
	SELECT @Check_Num = Check_Num FROM Inserted
	IF (@PaymentMethod = 'Cash')
	BEGIN
		IF (@CC_Num IS NOT NULL OR @CardHoldersName IS NOT NULL 
		OR @Check_Num IS NOT NULL)
		BEGIN
			PRINT 'Credit Card and Check details are not required for Cash payments!'
			ROLLBACK TRANSACTION
		END
	END
	ELSE IF (@PaymentMethod = 'Credit_Card')
	BEGIN
		IF (@CC_Num IS NULL OR @CardHoldersName IS NULL)
		BEGIN
			PRINT 'Credit Card Number and CardHolders name are required for
			Credit Payment!'
			ROLLBACK TRANSACTION
		END
		ELSE IF (@Check_Num IS NOT NULL)
		BEGIN
			PRINT 'Check details are not required for Credit payments!'
			ROLLBACK TRANSACTION
		END
	END
	ELSE IF (@PaymentMethod = 'Check')
	BEGIN
		IF(@Check_Num IS NULL)
		BEGIN
			PRINT 'Check Number is required for Check Payment!'
			ROLLBACK TRANSACTION
		END
		ELSE IF (@CC_Num IS NOT NULL OR @CardHoldersName IS NOT NULL)
		BEGIN
			PRINT 'Credit Card details are not required for Check payments!'
			ROLLBACK TRANSACTION
		END
	END
	IF (@TreatmentType = 'Outpatient')
	BEGIN
	SET @DoctorFee = HumanResources.ComputeDoctorFee(@PatientID)
	--This fee is for tests done on outpatient patients
	SET @TreatmentFee = 250.45
	SET @FinalPayment = @DoctorFee + @TreatmentFee
	UPDATE Management.Payments
	SET FinalPayment = @FinalPayment
	WHERE PatientID = @PatientID
	UPDATE Management.Payments
	SET PaymentStatus = 'Paid'
	WHERE PatientID = @PatientID
	END
	ELSE IF (@TreatmentType = 'Inpatient')
	BEGIN
	IF (@DischargeDate IS NULL)
	BEGIN
		IF(@AdvancePayment IS NULL)
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'All admitted patients must make Advance Payment!'
		END
		ELSE
		BEGIN
		UPDATE Management.Payments
		SET PaymentStatus = 'Pending'
		WHERE PatientID = @PatientID
		END		
	END
	ELSE IF(@DischargeDate IS NOT NULL)
	BEGIN
		IF(@AdmitDate IS NOT NULL)
		BEGIN
			IF(@AdvancePayment IS NOT NULL)
			BEGIN
				SET @FinalPayment = Patients.ComputeFinalPayment(@PatientID)
				UPDATE Management.Payments
				SET FinalPayment = @FinalPayment
				WHERE PatientID = @PatientID
				UPDATE Management.Payments
				SET PaymentStatus = 'Paid'
				WHERE PatientID = @PatientID
			END
			ELSE
			BEGIN
				ROLLBACK TRANSACTION
				PRINT 'All admitted patients must make Advance Payment!'
			END
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION
			PRINT 'There can be no Discharge Date without Admit Date!'
		END
	END
	END
RETURN
GO

/*
UPDATE Trigger on Management.Payments Table
to validate columns in the Patients.PatientDetails Table
and other tables in the NewHope Database during update
*/
CREATE TRIGGER Patients.trgUpdatePatientDetails
ON Patients.PatientDetails
FOR UPDATE
AS
	DECLARE @PatientID int
	DECLARE @WardID int
	DECLARE @AdmitDate datetime
	DECLARE @DischargeDate datetime
	DECLARE @Avail_Beds smallint
	DECLARE @OriginalWard tinyint
	DECLARE @DischargeWard tinyint
	DECLARE @FinalPayment float
	DECLARE @CurrentWard int
	DECLARE @NewWard tinyint
	DECLARE @WardCharge float
	DECLARE @NumberOfDaysAdmitted int
	DECLARE @WardChangeFee float
	DECLARE @AdvancePayment float
	SELECT @WardID = Ward_ID FROM Inserted
	SELECT @PatientID = PatientID FROM Inserted
	SELECT @AdvancePayment = AdvancePayment FROM Management.Payments
	WHERE PatientID = @PatientID
	SELECT @AdmitDate = Admit_Date FROM Patients.PatientDetails
	WHERE PatientID = @PatientID
	SELECT @DischargeWard = Ward_ID FROM Patients.PatientDetails
	WHERE PatientID = @PatientID
	SET @FinalPayment = Patients.ComputeFinalPayment(@PatientID)
	SELECT @Avail_Beds = Avail_Beds from Facilities.WardDetails
	WHERE WardID = @WardID
IF UPDATE(Discharge_Date)
BEGIN
	SELECT @DischargeDate = Discharge_Date FROM Inserted
	SELECT @WardID = Ward_ID FROM Patients.PatientDetails
	IF (@DischargeDate < @AdmitDate)
	BEGIN
	ROLLBACK TRANSACTION
	PRINT 'Discharge Date must be greater than Admit Date!'
	END
	ELSE
	BEGIN
	UPDATE Management.Payments
	SET FinalPayment = @FinalPayment
	WHERE PatientID = @PatientID

	UPDATE Management.Payments
	SET PaymentDate = @DischargeDate
	WHERE PatientID = @PatientID

	UPDATE Management.Payments
	SET PaymentStatus = 'Paid'
	WHERE PatientID = @PatientID

	UPDATE Patients.MedicalHistory
	SET DischargeWard = @DischargeWard
	WHERE PatientID = @PatientID
	
	UPDATE Facilities.WardDetails
	SET Avail_Beds = (@Avail_Beds + 1)
	WHERE WardID = @DischargeWard
	END
END
ELSE IF UPDATE(Ward_ID)
BEGIN
	DECLARE @CurrentAvail_Beds int
	SELECT @CurrentWard = Ward_ID FROM Deleted
	SELECT @WardCharge = Ward_Charge FROM Facilities.WardDetails
	WHERE WardID = @CurrentWard
	SELECT @NumberOfDaysAdmitted = DATEDIFF(dd, @AdmitDate, GETDATE())
	SET @WardChangeFee = (@WardCharge * @NumberOfDaysAdmitted)
	SELECT @CurrentAvail_Beds = Avail_Beds FROM Facilities.WardDetails
	WHERE WardID = @CurrentWard
	
	IF(@WardID != 1)
	BEGIN
		UPDATE Facilities.WardDetails
		SET Avail_Beds = (@CurrentAvail_Beds + 1)
		WHERE WardID = @CurrentWard

		UPDATE Facilities.WardDetails
		SET Avail_Beds = (@Avail_Beds - 1)
		WHERE WardID = @WardID

		UPDATE Management.Payments
		SET AdvancePayment = (@AdvancePayment - @WardChangeFee)
		WHERE PatientID = @PatientID
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION
		PRINT 'Patients do not get admitted into Outpatient Ward!'
	END
END
RETURN
GO

/*
INSERT Trigger on Patients.PatientDetails Table
to validate columns in Patients.PatientDetails Table
and other tables as required during insert
*/
CREATE TRIGGER Patients.trgInsertPatientDetails
ON Patients.PatientDetails
FOR INSERT
AS
	DECLARE @PatientID int
	DECLARE @WardID int
	DECLARE @Avail_Beds smallint
	DECLARE @Admit_Date datetime
	DECLARE @Discharge_Date datetime
	SELECT @PatientID = PatientID FROM Inserted
	SELECT @WardID = Ward_ID FROM Inserted
	SELECT @Avail_Beds = Avail_Beds 
	FROM Facilities.WardDetails
	WHERE WardID = @WardID
	SELECT @Admit_Date = Admit_Date FROM Inserted
	SELECT @Discharge_Date = Discharge_Date FROM Inserted

	IF(@Admit_Date IS NOT NULL OR @Discharge_Date IS NOT NULL)
	BEGIN
		IF(@Admit_Date IS NOT NULL AND @Discharge_Date IS NOT NULL)
		BEGIN
			IF(@WardID = 1)
			BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Dates are not required for Outpatient Treatment!'
			END
			IF (@Discharge_Date < @Admit_Date)
			BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Discharge Date must be greater than Admit Date!'
			END	
		END
	END
	IF(@Discharge_Date IS NULL AND @WardID !=1)
	BEGIN
		IF(@Avail_Beds > 0)
		BEGIN
			UPDATE Facilities.WardDetails
			SET Avail_Beds = (@Avail_Beds - 1)
			WHERE WardID = @WardID
		END
		ELSE
		BEGIN
			PRINT 'Beds are no longer available in this Ward!'
			ROLLBACK TRANSACTION
		END
	END
RETURN
GO

/*
INSERT Trigger on Patients.MedicalHistory Table
to validate columns during insert
*/
CREATE TRIGGER Patients.trgInsertMedicalHistory
ON Patients.MedicalHistory
FOR INSERT
AS
	DECLARE @PatientID int
	DECLARE @Discharge_Date datetime
	DECLARE @DischargeWard int
	SELECT @PatientID = PatientID FROM Inserted
	SELECT @Discharge_Date = Discharge_Date FROM Patients.PatientDetails
	WHERE PatientID = @PatientID
	SELECT @DischargeWard = Ward_ID FROM Patients.PatientDetails
	WHERE PatientID = @PatientID

	IF (@Discharge_Date IS NOT NULL)
	BEGIN
	UPDATE Patients.MedicalHistory
	SET DischargeWard = @DischargeWard
	WHERE PatientID = @PatientID
	END
RETURN
GO

PRINT 'NewHope Functions and Triggers created successfully!'
GO