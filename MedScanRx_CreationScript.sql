USE MedScanRx_Develop --MedScanRx for local
GO

--Cleanup before rerunning the script
DROP TABLE IF EXISTS dbo.PatientAccount;
DROP TABLE IF EXISTS dbo.AdminAccount
DROP TABLE IF EXISTS dbo.PrescriptionAlert;
DROP TABLE IF EXISTS dbo.Prescription;
DROP TABLE IF EXISTS dbo.Patient;

--Table Creation
CREATE TABLE Patient (
	PatientId INT IDENTITY(100000, 3) PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth Date NOT NULL,
	Gender VARCHAR(1) NOT NULL,
	Phone1 NVARCHAR(12) NOT NULL,
	Phone2 NVARCHAR(12) NULL,
	Email NVARCHAR(100) NOT NULL,
	EmergencyContactName NVARCHAR(100) NULL,
	EmergencyContactRelation NVARCHAR(25) NULL,
	EmergencyContactPhone NVARCHAR(12) NULL,
	PreferredHospital NVARCHAR(50) NULL,
	PreferredPhysician NVARCHAR(100) NULL,
	IsActive BIT NOT NULL,
	EnteredBy NVARCHAR(50) NOT NULL,
	EnteredDate DATETIME2 NOT NULL,
	ModifiedBy NVARCHAR(50) NOT NULL,
	ModifiedDate DATETIME2 NOT NULL 
);

CREATE TABLE PatientAccount (
	PatientId INT PRIMARY KEY FOREIGN KEY REFERENCES Patient (PatientId) ,
	UserName  NVARCHAR(100) UNIQUE NOT NULL,
	PW NVARCHAR(500) NOT NULL,
	Salt NVARCHAR(500) NULL,
)

CREATE TABLE AdminAccount (
	AdminId INT IDENTITY(1, 1) PRIMARY KEY,
	UserName NVARCHAR(50) UNIQUE NOT NULL,
	PW NVARCHAR(500) NOT NULL,
	Salt NVARCHAR(500) NULL,
	CreatedDate DateTime2(0) NOT NULL,
	CreatedBy NVARCHAR(50) NOT NULL
)

CREATE TABLE Prescription (
	PrescriptionId INT IDENTITY(1, 1) PRIMARY KEY,
	Ndc NVARCHAR(20) NOT NULL,
	PrescriptionName NVARCHAR(255) NOT NULL,
	PatientId INT FOREIGN KEY REFERENCES Patient(PatientId),
	Color NVARCHAR(50) NOT NULL,
	Dosage NVARCHAR(100) NOT NULL,
	Identifier NVARCHAR(100) NOT NULL,
	Shape NVARCHAR(50) NOT NULL,
	Rxcui NVARCHAR(25) NULL,
	ImageUrl NVARCHAR(255) NULL,
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
	IsActive BIT NOT NULL,
)



--Mock/Test Data
INSERT INTO Patient (FirstName, LastName, DateOfBirth, Gender, Phone1, Phone2, Email, EmergencyContactName, EmergencyContactRelation, EmergencyContactPhone, 
					 PreferredHospital, PreferredPhysician, IsActive, EnteredBy, EnteredDate, ModifiedBy, ModifiedDate) 
	VALUES('Chris', 'Andrews', '1983-05-31', 'M', '123-456-7890', '123-123-2134', 'Chris@Chris.Com', 'Susan Andrews', 'Mom', '123-123-2134',
			'Hospital 1', 'Dr. John', 1, 'User1', GetDate(), 'User1', GetDate()), 
		  ('John', 'Smith', '1995-12-21', 'M', '123-123-2134', '123-123-2134', 'John@John.Com', 'Jill Smith', 'Mom', '123-123-2134',
			'Hospital 2', 'Dr. Miller', 1, 'User1', GetDate(), 'User1', GetDate()), 	
		  ('Blake', 'McPearson', '1930-01-01', 'F', '123-123-2134', '123-123-2134', 'Blake@Blake.Com', 'Andrew McPearson', 'Brother', '123-123-2134',
			NULL, NULL, 0, 'User2', GetDate(), 'User2', GetDate());	

INSERT INTO AdminAccount (UserName, PW, Salt, CreatedDate, CreatedBy) 
	VALUES ('MedScanRxAdmin', 'newpasswordwhothis', 'some salt I dont konw ?', GETUTCDATE(), 'Admin DB Script')

-- Will want NDC to actually be working before I do this. 
--INSERT INTO Prescription (PatientId, Barcode, Color, Dosage, Identifier, Shape, DoctorNote, Warning, OriginalNumberOfDoses, CurrentNumberOfDoses,
--						  OriginalNumberOfRefills, CurrentNumberOfRefills, IsActive, EnteredBy, EnteredDate, ModifiedBy, ModifiedDate)
--	VALUES(100000, '1234567890', 'Blue', '2mg 3 times a day', 'MK123 Imprint', 'Round', 'Take with food', '', 23, 23, 1, 1, 1, 'User1', GetDate(), 'User1', GetDate() ),
--		  (100000, '938457', 'Yellow', '3 milliliter each time', 'Liquid, XYZ bottle', 'Liquid', '', 'Will cause drowsiness, dont operate heavy machines', 15, 15, 0, 0, 1, 'User1', GetDate(), 'User1', GetDate() ),
--		  (100000, '654721657', 'Green', '10mg pill twice daily', 'Line on back, 123 on front', 'Oblong', '', '', 23, 23, 1, 1, 1, 'User1', GetDate(), 'User1', GetDate() ),
--		  (100003, '1234567890', 'Blue', '2mg 3 times a day', 'MK123 Imprint', 'Round', 'Take with food', '', 23, 23, 1, 1, 1, 'User1', GetDate(), 'User1', GetDate() )  	


 