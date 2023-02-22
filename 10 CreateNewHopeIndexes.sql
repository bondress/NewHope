--Creating NewHope Indexes
USE NewHope
GO

PRINT 'Creating NewHope Indexes'
GO

CREATE NONCLUSTERED INDEX IDX_AdmitDate
on Patients.PatientDetails (Admit_Date)

CREATE NONCLUSTERED INDEX IDX_DischargeDate
on Patients.PatientDetails (Discharge_Date)

CREATE NONCLUSTERED INDEX IDX_PaymentStatus
on Management.Payments (PaymentStatus)

CREATE NONCLUSTERED INDEX IDX_AvailableBeds
on Facilities.WardDetails (Avail_Beds)

PRINT 'NewHope Indexes created successfully!'
GO