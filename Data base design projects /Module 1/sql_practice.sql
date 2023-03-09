CREATE TABLE Apartments(
	ApartmentNum DECIMAL PRIMARY KEY,
	ApartmentName VARCHAR(64) NOT NULL,
	Description VARCHAR(64) NULL,
	CleanedDate DATE NOT NULL,
	AvailableDate DATE NOT NULL
);

INSERT INTO Apartments(ApartmentNum,ApartmentName,Description,CleanedDate,AvailableDate)
VALUES(498,'Deer Creek Crossing','Great view of Riverwalk',CAST('19-APR-2022' AS DATE),
	   CAST('25-APR-2022'AS DATE));

INSERT INTO Apartments(ApartmentNum,ApartmentName,Description,CleanedDate,AvailableDate)
VALUES(128,'Town Place Apartments','Convenient walk to Parking',CAST('20-MAY-2022' AS DATE),
	   CAST('25-MAY-2022'AS DATE));
	   
INSERT INTO Apartments(ApartmentNum,ApartmentName,Description,CleanedDate,AvailableDate)
VALUES(316,'Paradise Palms',NULL,CAST('02-JUN-2021' AS DATE),
	   CAST('08-JUN-2022'AS DATE));
	   

INSERT INTO Apartments(ApartmentNum,ApartmentName,Description,CleanedDate,AvailableDate)
VALUES(252,'The Glenn','Close to Downtown shops',CAST('17-JUl-2020' AS DATE),
	   CAST('13-JUl-2020'AS DATE));
	   
	   
	   
SELECT ApartmentName,Description
FROM Apartments
Where ApartmentNum = 498
	   

