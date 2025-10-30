
IF OBJECT_ID('tbl_Team', 'U') IS NOT NULL 
	DROP TABLE tbl_Team
GO

CREATE TABLE tbl_Team
(
	TeamId				INT				NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TeamName			VARCHAR(100)	NOT NULL,
	IsActive 			BIT 			NOT NULL DEFAULT 1,
	IsDeleted 			BIT 			NOT NULL DEFAULT 0,
	CreateTimeStamp 	DATETIME 		NOT NULL DEFAULT GETDATE(),
	UpdateTimeStamp 	DATETIME,
	CreatedById 		INT,
	UpdatedById 		INT
)
GO

IF OBJECT_ID('tbl_Member', 'U') IS NOT NULL 
	DROP TABLE tbl_Member
GO

CREATE TABLE tbl_Member
(
	MemberId			INT				NOT NULL IDENTITY(1,1) PRIMARY KEY,
	MemberName			VARCHAR(100)	NOT NULL,
	EmailId				VARCHAR(100)	NULL,
	ContactNo			VARCHAR(100)	NULL,
	IsActive 			BIT 			NOT NULL DEFAULT 1,
	IsDeleted 			BIT 			NOT NULL DEFAULT 0,
	CreateTimeStamp 	DATETIME 		NOT NULL DEFAULT GETDATE(),
	UpdateTimeStamp 	DATETIME,
	CreatedById 		INT,
	UpdatedById 		INT
)
GO

IF OBJECT_ID('tbl_TeamMember', 'U') IS NOT NULL 
	DROP TABLE tbl_TeamMember
GO

CREATE TABLE tbl_TeamMember
(
	TeamId				INT				NOT NULL REFERENCES tbl_Team(TeamId),
	MemberId			INT				NOT NULL REFERENCES tbl_Member(MemberId),
	IsActive 			BIT 			NOT NULL DEFAULT 1,
	IsDeleted 			BIT 			NOT NULL DEFAULT 0,
	CreateTimeStamp 	DATETIME 		NOT NULL DEFAULT GETDATE(),
	UpdateTimeStamp 	DATETIME,
	CreatedById 		INT,
	UpdatedById 		INT,
	CONSTRAINT con_teammember_pk PRIMARY KEY(TeamId, MemberId)
)
GO

IF OBJECT_ID('tbl_TaskCategory', 'U') IS NOT NULL 
	DROP TABLE tbl_TaskCategory
GO

CREATE TABLE tbl_TaskCategory
(
	CategoryId			INT				NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CategoryName		VARCHAR(100)	NOT NULL,
	IsActive 			BIT 			NOT NULL DEFAULT 1,
	IsDeleted 			BIT 			NOT NULL DEFAULT 0,
	CreateTimeStamp 	DATETIME 		NOT NULL DEFAULT GETDATE(),
	UpdateTimeStamp 	DATETIME,
	CreatedById 		INT,
	UpdatedById 		INT
)
GO

IF OBJECT_ID('tbl_RoutineTask', 'U') IS NOT NULL 
	DROP TABLE tbl_RoutineTask
GO

CREATE TABLE tbl_RoutineTask
(
	RoutineTaskId		INT				NOT NULL IDENTITY(1,1) PRIMARY KEY,
	RoutineTaskName		VARCHAR(100)	NOT NULL,
	RoutineTaskDetails	VARCHAR(2000)	NULL,
	CategoryId			INT				NOT NULL REFERENCES tbl_TaskCategory(CategoryId),
	Frequency			VARCHAR(50)		NOT NULL,
	IsActive 			BIT 			NOT NULL DEFAULT 1,
	IsDeleted 			BIT 			NOT NULL DEFAULT 0,
	CreateTimeStamp 	DATETIME 		NOT NULL DEFAULT GETDATE(),
	UpdateTimeStamp 	DATETIME,
	CreatedById 		INT,
	UpdatedById 		INT
)
GO

IF OBJECT_ID('tbl_MemberRoutine', 'U') IS NOT NULL 
	DROP TABLE tbl_MemberRoutine
GO

CREATE TABLE tbl_MemberRoutine
(
	MemberId			INT				NOT NULL REFERENCES tbl_Member(MemberId),
	RoutineTaskId		INT				NOT NULL REFERENCES tbl_RoutineTask(RoutineTaskId),
	Responsibility		VARCHAR(10)		NOT NULL DEFAULT 'Primary' CHECK(Responsibility IN ('Primary', 'Secondary')),
	IsActive 			BIT 			NOT NULL DEFAULT 1,
	IsDeleted 			BIT 			NOT NULL DEFAULT 0,
	CreateTimeStamp 	DATETIME 		NOT NULL DEFAULT GETDATE(),
	UpdateTimeStamp 	DATETIME,
	CreatedById 		INT,
	UpdatedById 		INT,
	Constraint con_memberroutine_pk PRIMARY KEY(MemberId, RoutineTaskId)
)
GO

IF OBJECT_ID('tbl_Task', 'U') IS NOT NULL 
	DROP TABLE tbl_Task
GO

CREATE TABLE tbl_Task
(
	TaskId				INT				NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TaskName			VARCHAR(100)	NOT NULL,
	TaskDetails			VARCHAR(2000),
	CategoryId			INT				NOT NULL REFERENCES tbl_TaskCategory(CategoryId),
	AssignedTo			INT				NULL REFERENCES tbl_Member(MemberId),
	StartDate			DATE			NULL,
	DueDate				DATE			NULL,
	EndDate				DATE			NULL,
	TaskStatus			VARCHAR(18)		NOT NULL DEFAULT 'Not Assigned'	CHECK(TaskStatus IN ('Not Assigned', 'In Process', 'Closed', 'Deffered')),
	Remark				VARCHAR(100)	NULL,
	IsActive 			BIT 			NOT NULL DEFAULT 1,
	IsDeleted 			BIT 			NOT NULL DEFAULT 0,
	CreateTimeStamp 	DATETIME 		NOT NULL DEFAULT GETDATE(),
	UpdateTimeStamp 	DATETIME,
	CreatedById 		INT,
	UpdatedById 		INT	
)
GO
