CREATE TABLE Location(
	location_id DECIMAL(12) NOT NULL PRIMARY KEY,
	location_name VARCHAR(64) NOT NULL
);


CREATE TABLE Dig_site(
	dig_site_id DECIMAL(12) NOT NULL PRIMARY KEY,
	location_id DECIMAL(12) NOT NULL,
	dig_name VARCHAR(32) NOT NULL,
	dig_cost DECIMAL(8,2) NULL,
	FOREIGN KEY(location_id) REFERENCES Location(location_id)
);

CREATE TABLE Paleontologist(
	paleontologist_id DECIMAL(12) NOT NULL PRIMARY KEY,
	first_name VARCHAR(32) NOT NULL,
	last_name VARCHAR(32) NOT NULL
);

CREATE TABLE Dinosaur_discovery(
	dinosaur_discovery_id DECIMAL(12) NOT NULL PRIMARY KEY,
	dig_site_id DECIMAL(12) NOT NULL,
	Paleontologist_id DECIMAL(12) NOT NULL,
	common_name VARCHAR(64)NOT NULL,
	fossil_weight DECIMAL(6) NOT NULL,
	FOREIGN KEY(dig_site_id) REFERENCES Dig_site(dig_site_id),
	FOREIGN KEY(paleontologist_id) REFERENCES Paleontologist(paleontologist_id)
);


INSERT INTO Location(location_id,location_name)
VALUES(1,'Stonesfield');
INSERT INTO Location(location_id,location_name)
VALUES(2,'Utah');
INSERT INTO Location(location_id,location_name)
VALUES(3,'Arizona');
INSERT INTO Location(location_id,location_name)
VALUES(4,'New Mexico');

SELECT* FROM Location;

INSERT INTO Dig_site( dig_site_id,location_id,dig_name,dig_cost)
VALUES(1,1,'Great British Dig',8000);
INSERT INTO Dig_site( dig_site_id,location_id,dig_name,dig_cost)
VALUES(2,1,'Mission Jurassic Dig',Null);
INSERT INTO Dig_site( dig_site_id,location_id,dig_name,dig_cost)
VALUES(3,1,'Ancient Site Dig',5500);
INSERT INTO Dig_site( dig_site_id,location_id,dig_name,dig_cost)
VALUES(4,2,'Parowan Dinosaur Tracks',10000);
INSERT INTO Dig_site( dig_site_id,location_id,dig_name,dig_cost)
VALUES(5,3,'Dynamic Desert Dig',3500);
INSERT INTO Dig_site( dig_site_id,location_id,dig_name,dig_cost)
VALUES(6,4,'Mexican Dig',12000);

select* from dig_Site;

INSERT INTO Paleontologist(Paleontologist_id,first_name,last_name)
VALUES(1,'William','Buckland');
INSERT INTO Paleontologist(Paleontologist_id,first_name,last_name)
VALUES(2,'John','Ostrom');
INSERT INTO Paleontologist(Paleontologist_id,first_name,last_name)
VALUES(3,'Henry','Osborn');
INSERT INTO Paleontologist(Paleontologist_id,first_name,last_name)
VALUES(4,'Jim','Kirkland');

SELECT* FROM Paleontologist;

INSERT INTO Dinosaur_discovery(dinosaur_discovery_id,dig_site_id,Paleontologist_id,common_name,fossil_weight)
VALUES(1,1,1,'megalosaurus',3000);
INSERT INTO Dinosaur_discovery(dinosaur_discovery_id,dig_site_id,Paleontologist_id,common_name,fossil_weight)
VALUES(2,1,1,'Apatosaurus',4000);
INSERT INTO Dinosaur_discovery(dinosaur_discovery_id,dig_site_id,Paleontologist_id,common_name,fossil_weight)
VALUES(3,1,1,'Triceratops',4500);
INSERT INTO Dinosaur_discovery(dinosaur_discovery_id,dig_site_id,Paleontologist_id,common_name,fossil_weight)
VALUES(4,1,1,'Stegosaurus',3500);
INSERT INTO Dinosaur_discovery(dinosaur_discovery_id,dig_site_id,Paleontologist_id,common_name,fossil_weight)
VALUES(6,4,2,'Parasaurolophus',6000);
INSERT INTO Dinosaur_discovery(dinosaur_discovery_id,dig_site_id,Paleontologist_id,common_name,fossil_weight)
VALUES(7,4,2,'Tyrannosaurus Rex',5000);
INSERT INTO Dinosaur_discovery(dinosaur_discovery_id,dig_site_id,Paleontologist_id,common_name,fossil_weight)
VALUES(8,4,2,'Velociraptor',7000);
INSERT INTO Dinosaur_discovery(dinosaur_discovery_id,dig_site_id,Paleontologist_id,common_name,fossil_weight)
VALUES(9,5,2,'Tyrannosaurus Rex',6000);
INSERT INTO Dinosaur_discovery(dinosaur_discovery_id,dig_site_id,Paleontologist_id,common_name,fossil_weight)
VALUES(10,2,3,'Spinosaurus',8000);
INSERT INTO Dinosaur_discovery(dinosaur_discovery_id,dig_site_id,Paleontologist_id,common_name,fossil_weight)
VALUES(11,2,3,'Diplodocus',9000);
INSERT INTO Dinosaur_discovery(dinosaur_discovery_id,dig_site_id,Paleontologist_id,common_name,fossil_weight)
VALUES(12,3,3,'Tyrannosaurus Rex',7500);
INSERT INTO Dinosaur_discovery(dinosaur_discovery_id,dig_site_id,Paleontologist_id,common_name,fossil_weight)
VALUES(13,6,4,'Northronychus',6000);

select* from Dinosaur_discovery;




select l.location_name,d.dig_name,d.dig_cost, c.common_name,c.fossil_weight,p.first_name||' '||p.last_name as Paleontologist
from location l
full join Dig_site d 
on d.location_id = l.location_id

full join dinosaur_discovery c
on d.dig_site_id=c.dig_site_id

full join paleontologist p
on c.paleontologist_id = p.paleontologist_id


SELECT COUNT(*)
FROM Dinosaur_discovery
WHERE fossil_weight>4200;



SELECT  MAX(to_char(dig_cost,'$99999.99')) as most_expensive,MIN(to_char(dig_cost,'$99999.99')) as leaset_expensive
FROM dig_site;

commit;









































