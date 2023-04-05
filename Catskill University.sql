/* Start of Code */

/* Create BUILDING table */

CREATE TABLE BUILDING (
BuildingCode CHAR (2) NOT NULL,
BuildingName CHAR (25) NOT NULL,
BuildingAddress VARCHAR (200) NOT NULL,
CONSTRAINT BuildingPK PRIMARY KEY (BuildingCode)
);

/*Insert records into BUILDING*/

INSERT INTO BUILDING (BuildingCode, BuildingName, BuildingAddress)
	VALUES ('EbuildingH', 'Einstein Hall', '703 Ridge Ln');
INSERT INTO BUILDING (BuildingCode, BuildingName, BuildingAddress)
	VALUES ('CH', 'Cremer Hall', '780 Corn Dr');
INSERT INTO BUILDING (BuildingCode, BuildingName, BuildingAddress)
   VALUES ('FH', 'Faraday Hall', '110 Ritter Ave');
INSERT INTO BUILDING (BuildingCode, BuildingName, BuildingAddress)
	VALUES ('SU','Student Union', '35 Jefferson Ave');
INSERT INTO BUILDING (BuildingCode, BuildingName, BuildingAddress)
   VALUES ('MH','Mauer Hall', '455 Carlton St');

/* Create ROOM table */building

CREATE TABLE ROOM (
RoomCode CHAR (4) NOT NULL,
RoomCapacity INT	NOT NULL,
BuildingCode CHAR (2) NOT NULL,
CONSTRAINT RoomPK PRIMARY KEY(RoomCode),
CONSTRAINT RoomFK FOREIGN KEY (BuildingCode) REFERENCES BUILDING (BuildingCode)
                          	                  ON UPDATE CASCADE
 	                                          ON DELETE NO ACTION
);

/*Insert records into ROOM*/

INSERT INTO ROOM  (RoomCode, RoomCapacity, BuildingCode) 
	VALUES ('1000', 60, 'CH');
INSERT INTO ROOM  (RoomCode, RoomCapacity, BuildingCode) 
   VALUES ('1001', 150, 'MH');
INSERT INTO ROOM  (RoomCode, RoomCapacity, BuildingCode) 
   VALUES ('1002', 55, 'CH');
INSERT INTO ROOM  (RoomCode, RoomCapacity, BuildingCode) 
   VALUES('1003', 15, 'EH');
INSERT INTO ROOM  (RoomCode, RoomCapacity, BuildingCode) 
   VALUES('1004', 100, 'CH');
INSERT INTO ROOM  (RoomCode, RoomCapacity, BuildingCode) 
   VALUES('1005', 90, 'EH');

/* Create SCHOOL table */

CREATE TABLE SCHOOL (
SchoolCode CHAR (3) NOT NULL,
SchoolName VARCHAR (25)	NOT NULL,
SchoolAddress VARCHAR (100) NOT NULL,
CONSTRAINT SchoolPK PRIMARY KEY (SchoolCode)
);

/*Insert records into SCHOOL*/

INSERT INTO SCHOOL (SchoolCode, SchoolName, SchoolAddress)
	VALUES ('COB', 'College of Business', 'Campus Box 112');  
INSERT INTO SCHOOL (SchoolCode, SchoolName, SchoolAddress)
	VALUES ('COE', 'College of Engineering', 'Campus Box 109'); 
INSERT INTO SCHOOL (SchoolCode, SchoolName, SchoolAddress)
	VALUES ('COS', 'College of Science', 'Campus Box 212');  
INSERT INTO SCHOOL (SchoolCode, SchoolName, SchoolAddress)
	VALUES ('SOA', 'School of Arts', 'Campus Box 507'); 
INSERT INTO SCHOOL (SchoolCode, SchoolName, SchoolAddress)
	VALUES ('SOE', 'School of Education', 'Campus Box 340'); 

/* Create the intersection SCHL_BLDG table */

CREATE TABLE SCHL_BLDG (
SchoolBldgID CHAR (3) NOT NULL,
BuildingCode CHAR (2) NOT NULL,
SchoolCode CHAR (3) NOT NULL,
SizeSqFeet	INT NOT NULL,
CONSTRAINT Schl_BldgPK	PRIMARY KEY (SchoolBldgID),
CONSTRAINT Schl_BldgFK1 FOREIGN KEY (BuildingCode) REFERENCES BUILDING (BuildingCode)
                                                   ON UPDATE CASCADE
                                                   ON DELETE NO ACTION,
CONSTRAINT Schl_BldgFK2 FOREIGN KEY (SchoolCode) REFERENCES SCHOOL (SchoolCode)
                                                 ON UPDATE CASCADE
                                                 ON DELETE NO ACTION
);

/*Insert records into SCHL_BLDG*/

INSERT INTO SCHL_BLDG (SchoolBldgID, BuildingCode, SchoolCode, SizeSqFeet) 
	VALUES ('200', 'CH', 'COB', 15000);
INSERT INTO SCHL_BLDG (SchoolBldgID, BuildingCode, SchoolCode, SizeSqFeet) 
	VALUES ('201', 'CH', 'COS', 20000);
INSERT INTO SCHL_BLDG (SchoolBldgID, BuildingCode, SchoolCode, SizeSqFeet) 
	VALUES ('202', 'CH', 'SOE', 10000);
INSERT INTO SCHL_BLDG (SchoolBldgID, BuildingCode, SchoolCode, SizeSqFeet) 
	VALUES ('203', 'MH', 'COB', 25000);
INSERT INTO SCHL_BLDG (SchoolBldgID, BuildingCode, SchoolCode, SizeSqFeet) 
	VALUES('204', 'MH', 'COS', 13000);
INSERT INTO SCHL_BLDG (SchoolBldgID, BuildingCode, SchoolCode, SizeSqFeet) 
	VALUES ('205', 'FH', 'COB', 5000);

/* Create the DEPARTMENT table */

CREATE TABLE DEPARTMENT (
DeptCode	VARCHAR (4) NOT NULL, 
DeptName	VARCHAR (50) NOT NULL,
DeptAddress	VARCHAR (200) NULL,
SchoolCode	CHAR (3) NOT NULL,
CONSTRAINT DepartmentPK	PRIMARY KEY (DeptCode),
CONSTRAINT DepartmentFK	FOREIGN KEY (SchoolCode) REFERENCES SCHOOL (SchoolCode)
								ON UPDATE CASCADE
								ON DELETE NO ACTION 
);

/*Insert records into DEPARTMENT*/

INSERT INTO DEPARTMENT (DeptCode, DeptName, DeptAddress, SchoolCode)
			VALUES ('ACCT', 'Accounting', 'Campus Box 112A', 'COB'); 
INSERT INTO DEPARTMENT (DeptCode, DeptName, DeptAddress, SchoolCode)
			VALUES ('MKTG', 'Marketing', 'Campus Box 112C', 'COB');
INSERT INTO DEPARTMENT (DeptCode, DeptName, DeptAddress, SchoolCode)
			VALUES ('MGT', 'Management', 'Campus Box 112F', 'COB'); 
INSERT INTO DEPARTMENT (DeptCode, DeptName, DeptAddress, SchoolCode)
			VALUES ('EE', 'Electrical Engg', 'Campus Box 109D', 'COE');  
INSERT INTO DEPARTMENT (DeptCode, DeptName, DeptAddress, SchoolCode)
			VALUES ('ME', 'Mechanical Engg', 'Campus Box 109K', 'COE');
INSERT INTO DEPARTMENT (DeptCode, DeptName, DeptAddress, SchoolCode)
			VALUES ('CHEM', 'Chemistry', 'Campus Box 212C', 'COS');

/*Adding a range constraint for the RoomCapacity column in ROOM*/

ALTER TABLE ROOM 
ADD CONSTRAINT ValidRoomCapacity CHECK (RoomCapacity > 0 AND RoomCapacity <= 1000);

/* Create the PROFESSOR table */

CREATE TABLE PROFESSOR (
ProfID	CHAR (3) NOT NULL, 
ProfName	VARCHAR (100) NOT NULL,
ProfAddr	VARCHAR (150) NULL,
ProfRank	VARCHAR (20) NULL,
ProfDegree	VARCHAR (20) NULL,
ProfEmail	VARCHAR (50) NOT NULL,
DeptCode	VARCHAR (4) NOT NULL,
CONSTRAINT ProfessorPK	PRIMARY KEY (ProfID),
CONSTRAINT ProfessorFK	FOREIGN KEY (DeptCode) REFERENCES DEPARTMENT (DeptCode)
								ON UPDATE CASCADE
								ON DELETE NO ACTION 
);

/*Insert records into PROFESSOR*/

INSERT INTO PROFESSOR (ProfID, ProfName, ProfAddr, ProfRank, ProfDegree, ProfEmail, DeptCode)
			VALUES ('101', 'John Doe', 'Campus Box 112F1', 'Prof', 'PhD', 'jd@cat.edu', 'MGT');
INSERT INTO PROFESSOR (ProfID, ProfName, ProfAddr, ProfRank, ProfDegree, ProfEmail, DeptCode)
			VALUES ('102', 'Emily Reese', 'Campus Box 112F7', 'Asst Prof', 'PhD', 'er@cat.edu', 'MGT');
INSERT INTO PROFESSOR (ProfID, ProfName, ProfAddr, ProfRank, ProfDegree, ProfEmail, DeptCode)
			VALUES ('103', 'Jill Maher', 'Campus Box 109D1', 'Asst Prof', 'Masters', 'jm@cat.edu', 'EE');
INSERT INTO PROFESSOR (ProfID, ProfName, ProfAddr, ProfRank, ProfDegree, ProfEmail, DeptCode)
			VALUES ('104', 'Alice Baker', 'Campus Box 112F9', 'Assoc Prof', 'PhD', 'ab@cat.edu', 'MGT');
INSERT INTO PROFESSOR (ProfID, ProfName, ProfAddr, ProfRank, ProfDegree, ProfEmail, DeptCode)
			VALUES ('105', 'Nick Berger', 'Campus Box 112A3', 'Asst Prof', 'Masters', 'nb@cat.edu', 'ACCT');
INSERT INTO PROFESSOR (ProfID, ProfName, ProfAddr, ProfRank, ProfDegree, ProfEmail, DeptCode)
			VALUES ('106', 'Gloria Feld', 'Campus Box 112A9', 'Prof', 'PhD', 'gf@cat.edu', 'ACCT');

/* Create the STUDENT table */

CREATE TABLE STUDENT (
StuID	CHAR (5) NOT NULL, 
StuName	VARCHAR (100) NOT NULL,
StuAddr	VARCHAR (150) NULL,
StuMajor	VARCHAR (15) NULL,
StuGPA	DECIMAL (3,2) NULL CHECK (StuGPA>=0.00 AND StuGPA<=4.00),
DeptCode	VARCHAR (4) NOT NULL,
CONSTRAINT StudentPK	PRIMARY KEY (StuID),
CONSTRAINT StudentFK	FOREIGN KEY (DeptCode) REFERENCES DEPARTMENT (DeptCode)
								ON UPDATE CASCADE
								ON DELETE NO ACTION 
);

/*Insert records into PROFESSOR*/

INSERT INTO STUDENT (StuID, StuName, StuAddr, StuMajor, StuGPA, DeptCode)
			VALUES ('10001', 'Evan Niese', '202 Rockfall Ave', 'Accounting', '3.6', 'ACCT');
INSERT INTO STUDENT (StuID, StuName, StuAddr, StuMajor, StuGPA, DeptCode)
			VALUES ('10002', 'Joe Bram', '133 System Dr', 'Marketing', '3.2', 'MKTG');
INSERT INTO STUDENT (StuID, StuName, StuAddr, StuMajor, StuGPA, DeptCode)
			VALUES ('10003', 'Jane Doe', '200 Lake View', 'Auditing', '3.2', 'ACCT');
INSERT INTO STUDENT (StuID, StuName, StuAddr, StuMajor, StuGPA, DeptCode)
			VALUES ('10004', 'Tiffany John', '390 Rockfall Ave', 'Supply Chain', '3.5', 'MGT');
INSERT INTO STUDENT (StuID, StuName, StuAddr, StuMajor, StuGPA, DeptCode)
			VALUES ('10005', 'Nick Shine', '560 Lake Dr', 'Chemistry', '3.7', 'CHEM');
INSERT INTO STUDENT (StuID, StuName, StuAddr, StuMajor, StuGPA, DeptCode)
			VALUES ('10006', 'Mary Tate', '600 Castle Ln', 'Accounting', '4.0', 'ACCT');

/* Create the COURSE table */

CREATE TABLE COURSE (
CourseCode	VARCHAR (10) NOT NULL, 
CourseTitle	VARCHAR (100) NOT NULL,
CourseDesc	VARCHAR (100) NULL,
CourseCredits	INT NULL CHECK (CourseCredits>=0 AND CourseCredits<=6),
DeptCode	VARCHAR (4) NOT NULL,
CONSTRAINT CoursePK	PRIMARY KEY (CourseCode),
CONSTRAINT CourseFK	FOREIGN KEY (DeptCode) REFERENCES DEPARTMENT (DeptCode)
								ON UPDATE CASCADE
								ON DELETE NO ACTION 
);

/*Insert records into COURSE*/

INSERT INTO COURSE (CourseCode, CourseTitle, CourseDesc, CourseCredits, DeptCode)
			VALUES ('MKTG 3400', 'Advanced Marketing', 'Marketing Theory', '3', 'MKTG');
INSERT INTO COURSE (CourseCode, CourseTitle, CourseDesc, CourseCredits, DeptCode)
			VALUES ('ACCT 2000', 'Principles of Accounting', 'Intro to Accounting', '3', 'ACCT');
INSERT INTO COURSE (CourseCode, CourseTitle, CourseDesc, CourseCredits, DeptCode)
			VALUES ('EE 2000', 'Principles of Electrical Engg.', 'Intro to Elec. Engg.', '3', 'EE');
INSERT INTO COURSE (CourseCode, CourseTitle, CourseDesc, CourseCredits, DeptCode)
			VALUES ('MGT 2000', 'Principles of Mgmt.', 'Intro to Mgmt.', '3', 'MGT');
INSERT INTO COURSE (CourseCode, CourseTitle, CourseDesc, CourseCredits, DeptCode)
			VALUES ('ME 4500', 'Advanced Thermodynamics', 'Thermo Modeling', '3', 'ME');
INSERT INTO COURSE (CourseCode, CourseTitle, CourseDesc, CourseCredits, DeptCode)
			VALUES ('ACCT 4710', 'Accounting Information Systems', 'Developing Systems', '3', 'ACCT');

/* Create the CLSECT table */

CREATE TABLE CLSECT (
ClassCode	VARCHAR (12) NOT NULL, 
ClassTime	VARCHAR (15) NOT NULL,
ClassRoom	CHAR (4) NULL,
ProfID	CHAR (3) NOT NULL,
CourseCode	VARCHAR (10) NOT NULL,
CONSTRAINT ClsectPK	PRIMARY KEY (ClassCode),
CONSTRAINT ClsectFK1	FOREIGN KEY (ProfID) REFERENCES PROFESSOR (ProfID),
CONSTRAINT ClsectFK2	FOREIGN KEY (CourseCode) REFERENCES COURSE (CourseCode)
								ON UPDATE CASCADE
								ON DELETE NO ACTION 
);

/*Insert records into CLSECT*/

INSERT INTO CLSECT (ClassCode, ClassTime, ClassRoom, ProfID, CourseCode)
			VALUES ('ACCT 2000A', 'MWF 9-10', '1004', '105', 'ACCT 2000');
INSERT INTO CLSECT (ClassCode, ClassTime, ClassRoom, ProfID, CourseCode)
			VALUES ('ACCT 2000B', 'MWF 10-11', '1004', '105', 'ACCT 2000');
INSERT INTO CLSECT (ClassCode, ClassTime, ClassRoom, ProfID, CourseCode)
			VALUES ('ACCT 2000C', 'MWF 11-12', '1004', '105', 'ACCT 2000');
INSERT INTO CLSECT (ClassCode, ClassTime, ClassRoom, ProfID, CourseCode)
			VALUES ('EE 2000A', 'TuTh 2-3', '1005', '103', 'EE 2000');
INSERT INTO CLSECT (ClassCode, ClassTime, ClassRoom, ProfID, CourseCode)
			VALUES ('EE 2000B', 'MWF 9-10', '1005', '103', 'EE 2000');
INSERT INTO CLSECT (ClassCode, ClassTime, ClassRoom, ProfID, CourseCode)
			VALUES ('MGT 2000A', 'TuTh 4-5', '1004', '101', 'MGT 2000');

/* Create the ENROLL table */

CREATE TABLE ENROLL (
EnrollID	CHAR (5) NOT NULL, 
StuID	CHAR (5) NOT NULL,
ClassCode	VARCHAR (12) NOT NULL,
EnrollDate	CHAR (8) NOT NULL,
EnrollGrade	CHAR (1) NULL CHECK (EnrollGrade IN ('A', 'B', 'C', 'F', 'I')),
CONSTRAINT EnrollPK	PRIMARY KEY (EnrollID),
CONSTRAINT EnrollFK1	FOREIGN KEY (StuID) REFERENCES STUDENT (StuID),
CONSTRAINT EnrollFK2	FOREIGN KEY (ClassCode) REFERENCES CLSECT (ClassCode)
								ON UPDATE CASCADE
								ON DELETE NO ACTION 
);

/*Insert records into ENROLL*/

INSERT INTO ENROLL (EnrollID, StuID, ClassCode, EnrollDate, EnrollGrade)
			VALUES ('20001', '10002', 'ACCT 2000A', '4/12/20', NULL);
INSERT INTO ENROLL (EnrollID, StuID, ClassCode, EnrollDate, EnrollGrade)
			VALUES ('20002', '10002', 'MGT 2000A', '4/13/20', NULL);
INSERT INTO ENROLL (EnrollID, StuID, ClassCode, EnrollDate, EnrollGrade)
			VALUES ('20003', '10002', 'EE 2000B', '4/10/20', NULL);
INSERT INTO ENROLL (EnrollID, StuID, ClassCode, EnrollDate, EnrollGrade)
			VALUES ('20004', '10006', 'ACCT 2000C', '4/07/20', NULL);
INSERT INTO ENROLL (EnrollID, StuID, ClassCode, EnrollDate, EnrollGrade)
			VALUES ('20005', '10006', 'EE 2000B', '4/10/20', NULL);
INSERT INTO ENROLL (EnrollID, StuID, ClassCode, EnrollDate, EnrollGrade)
			VALUES ('20006', '10006', 'ACCT 2000A', '4/14/20', NULL);