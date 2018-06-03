USE MedScanRx
GO

CREATE TABLE Patient (
	PatientId INT IDENTITY(100000, 3) PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	DateOfBirth DateTime2 NOT NULL,
	Gender VARCHAR(1) NOT NULL,
	Phone1 NVARCHAR(10) NOT NULL,
	Phone2 NVARCHAR(10) NULL,
	Email NVARCHAR(100) NOT NULL,
	EmergencyContactName NVARCHAR(100) NULL,
	EmergencyContactRelation NVARCHAR(25) NULL,
	EmergencyContactPhone NVARCHAR(10) NULL,
	PreferredHospital NVARCHAR(50) NULL,
	PreferredPhysician NVARCHAR(100) NULL,
	EnteredBy NVARCHAR(50) NOT NULL,
	EnteredDate DATETIME2 NOT NULL,
	ModifiedBy NVARCHAR(50) NOT NULL,
	ModifiedDate DATETIME2 NOT NULL
);

CREATE TABLE Prescription (
	PrescriptionId INT IDENTITY(1, 1) PRIMARY KEY,
	PatientId INT FOREIGN KEY REFERENCES Patient(PatientId),
	Barcode BIGINT NOT NULL,
	Color NVARCHAR(25) NOT NULL,
	Dosage NVARCHAR(50) NOT NULL,
	Identifier NVARCHAR(50) NOT NULL,
	Shape NVARCHAR(50) NOT NULL,
	DoctorNote NVARCHAR(255) NULL,
	Warning NVARCHAR(255) NULL,
	OriginalNumberOfDoses INT NOT NULL,
	CurrentNumberOfDoses INT NOT NULL,
	OriginalNumberOfRefills INT NOT NULL,
	CurrentNumberOfRefills INT NOT NULL,
	EnteredBy NVARCHAR(50) NOT NULL,
	EnteredDate DATETIME2 NOT NULL,
	ModifiedBy NVARCHAR(50) NOT NULL,
	ModifiedDate DATETIME2 NOT NULL
);

CREATE TABLE PrescriptionAlert (
	PrescriptionAlertId INT IDENTITY(1, 1) PRIMARY KEY,
	PrescriptionId INT FOREIGN KEY REFERENCES Prescription(PrescriptionId),
	AlertDateTime DATETIME2 NOT NULL,
	TakenDateTIme DATETIME2 NULL,
	WasTaken BIT NULL,
)
