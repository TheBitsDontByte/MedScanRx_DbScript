USE MedScanRx
GO

--Cleanup before rerunning the script
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'PrescriptionAlert' AND TABLE_SCHEMA = 'dbo')
	DROP TABLE dbo.PrescriptionAlert
	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'Prescription' AND TABLE_SCHEMA = 'dbo')
	DROP TABLE dbo.Prescription
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'Patient' AND TABLE_SCHEMA = 'dbo')
	DROP TABLE dbo.Patient;

--Table Creation
CREATE TABLE Patient (
	PatientId INT IDENTITY(100000, 3) PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth Date NOT NULL,
	Gender VARCHAR(1) NOT NULL,
	Phone1 NVARCHAR(10) NOT NULL,
	Phone2 NVARCHAR(10) NULL,
	Email NVARCHAR(100) NOT NULL,
	EmergencyContactName NVARCHAR(100) NULL,
	EmergencyContactRelation NVARCHAR(25) NULL,
	EmergencyContactPhone NVARCHAR(10) NULL,
	PreferredHospital NVARCHAR(50) NULL,
	PreferredPhysician NVARCHAR(100) NULL,
	IsActive BIT NOT NULL,
	EnteredBy NVARCHAR(50) NOT NULL,
	EnteredDate DATETIME2 NOT NULL,
	ModifiedBy NVARCHAR(50) NOT NULL,
	ModifiedDate DATETIME2 NOT NULL
);

CREATE TABLE Prescription (
	PrescriptionId INT IDENTITY(1, 1) PRIMARY KEY,
	Ndc NVARCHAR(20) NOT NULL,
	BrandName NVARCHAR(255) NOT NULL,
	GenericName NVARCHAR(255) NOT NULL,
	PatientId INT FOREIGN KEY REFERENCES Patient(PatientId),
	Barcode NVARCHAR(25) NOT NULL,
	Color NVARCHAR(50) NOT NULL,
	Dosage NVARCHAR(100) NOT NULL,
	Identifier NVARCHAR(100) NOT NULL,
	Shape NVARCHAR(50) NOT NULL,
	DoctorNote NVARCHAR(500) NULL,
	Warning NVARCHAR(500) NULL,
	OriginalNumberOfDoses INT NOT NULL,
	CurrentNumberOfDoses INT NOT NULL,
	OriginalNumberOfRefills INT NOT NULL,
	CurrentNumberOfRefills INT NOT NULL,
	IsActive BIT NOT NULL,
	EnteredBy NVARCHAR(50) NOT NULL,
	EnteredDate DATETIME2 NOT NULL,
	ModifiedBy NVARCHAR(50) NOT NULL,
	ModifiedDate DATETIME2 NOT NULL
);

CREATE TABLE PrescriptionAlert (
	PrescriptionAlertId INT IDENTITY(1, 1) PRIMARY KEY,
	PrescriptionId INT FOREIGN KEY REFERENCES Prescription(PrescriptionId),
	AlertDateTime DATETIME2 NOT NULL,
	TakenDateTime DATETIME2 NULL,
	WasTaken BIT NULL,
)

--Mock/Test Data
INSERT INTO Patient (FirstName, LastName, DateOfBirth, Gender, Phone1, Phone2, Email, EmergencyContactName, EmergencyContactRelation, EmergencyContactPhone, 
					 PreferredHospital, PreferredPhysician, IsActive, EnteredBy, EnteredDate, ModifiedBy, ModifiedDate) 
	VALUES('Chris', 'Andrews', '1983-05-31', 'M', '1234567890', '1231232134', 'Chris@Chris.Com', 'Susan Andrews', 'Mom', '1235467890',
			'Da Hospital', 'Da Doctah', 1, 'User1', GetDate(), 'User1', GetDate()), 
		  ('John', 'Smith', '1995-12-21', 'M', '1234567890', '1231232134', 'John@John.Com', 'Susan Smith', 'Mom', '1235467890',
			'Da Hospital', 'Da Doctah', 1, 'User1', GetDate(), 'User1', GetDate()), 	
		  ('Blake', 'McPerson', '1930-01-01', 'F', '1234567890', '1231232134', 'Blake@Blake.Com', 'Susan McPerson', 'Mom', '1235467890',
			'Yaboi Hospital', 'Mai Doctah', 0, 'User2', GetDate(), 'User2', GetDate());	

-- Will want NDC to actually be working before I do this. 
--INSERT INTO Prescription (PatientId, Barcode, Color, Dosage, Identifier, Shape, DoctorNote, Warning, OriginalNumberOfDoses, CurrentNumberOfDoses,
--						  OriginalNumberOfRefills, CurrentNumberOfRefills, IsActive, EnteredBy, EnteredDate, ModifiedBy, ModifiedDate)
--	VALUES(100000, '1234567890', 'Blue', '2mg 3 times a day', 'MK123 Imprint', 'Round', 'Take with food', '', 23, 23, 1, 1, 1, 'User1', GetDate(), 'User1', GetDate() ),
--		  (100000, '938457', 'Yellow', '3 milliliter each time', 'Liquid, XYZ bottle', 'Liquid', '', 'Will cause drowsiness, dont operate heavy machines', 15, 15, 0, 0, 1, 'User1', GetDate(), 'User1', GetDate() ),
--		  (100000, '654721657', 'Green', '10mg pill twice daily', 'Line on back, 123 on front', 'Oblong', '', '', 23, 23, 1, 1, 1, 'User1', GetDate(), 'User1', GetDate() ),
--		  (100003, '1234567890', 'Blue', '2mg 3 times a day', 'MK123 Imprint', 'Round', 'Take with food', '', 23, 23, 1, 1, 1, 'User1', GetDate(), 'User1', GetDate() )  	


select * from dbo.Patient;