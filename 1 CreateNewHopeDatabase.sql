--Creating NewHope Database
--ENSURE THAT NEWHOPE FOLDER IS CREATED IN C: DRIVE!!!
USE Master
GO
BEGIN TRY
PRINT 'Creating NewHope Database...'
CREATE DATABASE NewHope
ON PRIMARY
(	NAME='NewHope',
	FILENAME='C:\NewHope\NewHope.mdf',
	SIZE=30MB,
	MAXSIZE=50MB,
	FILEGROWTH=1MB
)
PRINT 'NewHope Database created successfully!'
END TRY
BEGIN CATCH
PRINT 'An error occured!'
PRINT 'Error Message: '+ ERROR_MESSAGE()
PRINT 'Error Line: ' + CONVERT(VARCHAR,ERROR_LINE())
END CATCH