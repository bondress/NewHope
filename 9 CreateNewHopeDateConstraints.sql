--Creating New Hope Constraints
USE NewHope
GO

PRINT 'Creating New Hope Date Constraints...'
GO 

ALTER TABLE Management.Payments
ADD
CONSTRAINT chkPaymentDate
CHECK (PaymentDate >= getdate())
GO

ALTER TABLE Patients.PatientDetails
ADD
CONSTRAINT chkAdmit_Date
CHECK(Admit_Date >= getdate())
GO