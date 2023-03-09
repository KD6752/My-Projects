--Drop table Scripts
DROP TABLE V_type;
DROP TABLE Make;
DROP TABLE Model;
DROP TABLE Color;
DROP TABLE Dealership;
DROP TABLE Vender ;
DROP TABLE Vender_Dealership;
DROP TABLE Department;
DROP TABLE Address;
DROP TABLE Employee;
DROP TABLE Mechanic;
DROP TABLE Sale_person;
DROP TABLE Car_sale;
DROP TABLE Customer;
DROP TABLE Payment;
DROP TABLE Payment_type;
DROP TABLE Vehicle;
--Drop Sequence Scripts
DROP SEQUENCE V_type_seq;
DROP SEQUENCE Make_seq;
DROP SEQUENCE Model_seq;
DROP SEQUENCE Color_seq;
DROP SEQUENCE Vender_seq;
DROP SEQUENCE Dealership_seq;
DROP SEQUENCE Vender_Dealership_seq;
DROP SEQUENCE Department_seq;
DROP SEQUENCE Address_seq;
DROP SEQUENCE Employee_seq;
DROP SEQUENCE Mechanic_seq;
DROP SEQUENCE Sale_person_seq;
DROP SEQUENCE Car_sale_seq;
DROP SEQUENCE Customer_seq;
DROP SEQUENCE Payment_Seq;
DROP SEQUENCE Payment_type_seq;
DROP SEQUENCE Vehicle_seq;

--Create Sequence Scripts
CREATE SEQUENCE V_type_seq;
CREATE SEQUENCE Make_seq;
CREATE SEQUENCE Model_seq;
CREATE SEQUENCE Color_seq;
CREATE SEQUENCE Vender_seq;
CREATE SEQUENCE Dealership_seq;
CREATE SEQUENCE Vender_Dealership_seq;
CREATE SEQUENCE Department_seq;
CREATE SEQUENCE Address_seq;
CREATE SEQUENCE Employee_seq;
CREATE SEQUENCE Mechanic_seq;
CREATE SEQUENCE Sale_person_seq;
CREATE SEQUENCE Car_sale_seq;
CREATE SEQUENCE Customer_seq;
CREATE SEQUENCE Payment_Seq;
CREATE SEQUENCE Payment_type_seq;
CREATE SEQUENCE Vehicle_seq;

--Creating Tables
CREATE TABLE V_type(
	type_id DECIMAL(12) PRIMARY KEY,
	v_type VARCHAR(75)
);

CREATE TABLE Make(
	make_id DECIMAL(12)PRIMARY KEY,
	make VARCHAR(75)
);

CREATE TABLE Model(
	model_id DECIMAL(12) PRIMARY KEY,
	model VARCHAR(75)
);

CREATE TABLE Color(
	color_id DECIMAL(12) PRIMARY KEY,
	v_color VARCHAR(75)
);

CREATE TABLE Address(
	address_id DECIMAL PRIMARY KEY,
	street_num DECIMAL(7),
	street_name VARCHAR(128),
	appartment_num VARCHAR(10),
	city VARCHAR(128),
	a_state VARCHAR(128),
	country VARCHAR(128),
	postal_code VARCHAR(128)						
);


CREATE TABLE Vender(
	vender_id DECIMAL(12) PRIMARY KEY,
	vender_name VARCHAR(128),
	v_location  VARCHAR
	
);

CREATE TABLE Dealership(
	dealership_id DECIMAL(12) PRIMARY KEY,
	d_name varchar(128),
	d_location VARCHAR(75)
	
);

--Creating Department table
CREATE TABLE Department(
	department_id DECIMAL PRIMARY KEY,
	dealership_id DECIMAL(12),
	department_name VARCHAR(128),
	FOREIGN KEY(dealership_id) REFERENCES Dealership(dealership_id)
);


CREATE TABLE vender_dealership(
	vender_dealership_id DECIMAL(12) PRIMARY KEY,
	vender_id DECIMAL(12),
	dealership_id DECIMAL(12),
	FOREIGN KEY(vender_id) REFERENCES Vender(vender_id),
	FOREIGN KEY(dealership_id) REFERENCES Dealership(dealership_id)
);


CREATE TABLE Employee(
	employee_id DECIMAL(12) PRIMARY KEY,
	department_id decimal(12),
	address_id DECIMAL(12),
	first_name VARCHAR(128),
	last_name VARCHAR(128),
	salary DECIMAL(7,2),
	e_position VARCHAR(128),
	DOB  DATE,
	hire_date DATE,
	FOREIGN KEY(department_id) REFERENCES Department(department_id),
	FOREIGN KEY(address_id)REFERENCES Address(address_id)
	
);

CREATE TABLE Mechanic(
	employee_id DECIMAL(12) PRIMARY KEY,
	has_mech_certified BOOLEAN,
	does_sell_car BOOLEAN,
	FOREIGN KEY(employee_id) REFERENCES Employee(employee_id)
);


CREATE TABLE Sale_person(
	employee_id DECIMAL(12) PRIMARY KEY,
	has_mech_certified BOOLEAN,
	does_sell_car BOOLEAN,
	FOREIGN KEY(employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE customer(
	customer_id DECIMAL(12) PRIMARY KEY,
	address_id DECIMAL(12),
	first_name VARCHAR(128),
	last_name VARCHAR(128),
	Phone DECIMAL(10),
	email_address VARCHAR(128),
	FOREIGN KEY(address_id) REFERENCES Address(address_id)
);

CREATE TABLE payment_type(
	payment_type_id DECIMAL PRIMARY KEY,
	p_method VARCHAR(75)
);

CREATE TABLE Vehicle(
	vehicle_id DECIMAL(12) PRIMARY KEY,
	vender_dealership_id DECIMAL(12),
	make_id DECIMAL(12),
	model_id DECIMAL(12),
	color_id DECIMAL(12),
	type_id DECIMAL(12),
	VIN VARCHAR(17),
	mileage DECIMAL(7),
	price DECIMAL(8,2),
	v_condition VARCHAR(10),
	reveived_date DATE,
	vender_price DECIMAL(8,2)
	FOREIGN KEY(vender_dealership_id) REFERENCES vender_dealership(vender_dealership_id),
	FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
	FOREIGN KEY(make_id) REFERENCES Make(make_id),
	FOREIGN KEY(model_id) REFERENCES Model(Model_id),
	FOREIGN KEY(color_id) REFERENCES color(color_id),
	FOREIGN KEY(type_id) REFERENCES V_type(type_id)	
);



CREATE TABLE Car_sale(
	sale_id DECIMAL(12) PRIMARY KEY,
	Customer_id DECIMAL(12),
	Employee_id DECIMAL(12),
	vehicle_id decimal(12),
	sale_price DECIMAL(8,2),
	sale_date DATE,
	FOREIGN KEY(customer_id)REFERENCES Customer(customer_id),
	FOREIGN KEY(employee_id) REFERENCES Employee(employee_id),
	FOREIGN KEY(vehicle_id) REFERENCES Vehicle(vehicle_id)	
);


CREATE TABLE Payment(
	payment_id DECIMAL(12) PRIMARY KEY,
	sale_id DECIMAL(12),
	payment_type_id DECIMAL(12),
	payment_date DATE,
	p_amount DECIMAL(8,2),
	FOREIGN KEY(sale_id) REFERENCES car_sale(sale_id),
	FOREIGN KEY(payment_type_id) REFERENCES Payment_type(payment_type_id)											 
	
);

--***CREATING INDEXING TO THE IDENTIFIED COLUMNS***
--INDEXES FOR THE FOREIGN KEYS
--for department-dealership 

CREATE INDEX DepartmentDealershipsidx
ON Department (dealership_id);

--1.for Vender_dealership-Vender
CREATE INDEX VenderDealershipVenderIdx1
ON Vender_dealership(vender_id);

--2.for Vender_dealership-Vender
CREATE INDEX VenderDealershipVenderIdx2
ON Vender_dealership(dealership_id);

--1.for Employee-Department
CREATE INDEX EmployeeDepartmentIdx1
ON Employee(department_id);

--2.for Employee-Department
CREATE INDEX EmployeeDepartmentIdx2
ON Employee(address_id);

--for mechanic-Employee
CREATE INDEX MechanicEmployeeIdx
ON Mechanic(employee_id);

--For sale_person-Employee
CREATE INDEX SalePersonEmployeeIdx
ON Employee(employee_id);

--For Customer-Address
CREATE INDEX CustomerAddressIdx
ON Customer(address_id);

--For Vehicle-Vender_dearlership
CREATE INDEX VehicleVenderDealershipIdx
ON Vehicle(vender_dealership_id);

--For Vehicle-Make
CREATE INDEX VehicleMakeIdx
ON Vehicle(make_id);

--For Vehicle-Model
CREATE INDEX VehicleModelIdx
ON Vehicle(model_id);

--For vehcile-Color
CREATE INDEX VehicleColorIdx
ON Vehicle(color_id);

--For Vehicle-Type
CREATE INDEX VehicleTypeIdx
ON Vehicle(type_id);

--For Car_sale-Customer
CREATE INDEX SaleCustomerIdx
ON Car_sale(customer_id);

--For Car_sale-Employee
CREATE INDEX SaleEmployeeIdx
ON Car_sale(employee_id);

--For Car_sale-Vehicle
CREATE INDEX SaleVehicleIdx
ON Vehicle(vehicle_id);

--For Payment-Sale
CREATE INDEX PaymentSaleIdx
ON Payment(sale_id);

--For Payment-Payment_type
CREATE INDEX PaymentPaymentTypeIdx
ON Payment(payment_type_id);

--For Vehicle-Price
CREATE INDEX VehiclePriceIdx
ON Vehicle(price);

--For Vehicle-Received_date
CREATE INDEX VehicleReceivedDateIdx
ON Vehicle(reveived_date);

--For Vehicle-Vender_price
CREATE INDEX VehicleVenderPriceIdx
ON Vehicle(vender_price);

--For Car_sale-Sale_price
CREATE INDEX CarSalePriceIdx
ON Car_sale(sale_price);

--For Car_sale-Sale_date
CREATE INDEX CarSaleDateIdx
ON Car_sale(sale_date);

--For Payment-Payment_amount
CREATE INDEX PaymentAmountIdx
ON Payment(p_amount);

--For payment-Payment_date
CREATE INDEX PaymentDateIdx
ON Payment(payment_date);




--***Populating Tables***

--inserting in V_type table
--USING INSERT INTO COMMAND

INSERT INTO V_type VALUES(nextval('V_type_seq'),'Sedan');
INSERT INTO V_type VALUES(nextval('V_type_seq'),'SUV');
INSERT INTO V_type VALUES(nextval('V_type_seq'),'Hatchback');
INSERT INTO V_type VALUES(nextval('V_type_seq'),'Convertible');
INSERT INTO V_type VALUES(nextval('V_type_seq'),'Pickup Truck');
INSERT INTO V_type VALUES(nextval('V_type_seq'),'Minivan');



--inserting into Vender, dealership and vender_dealership tables

INSERT INTO Vender VALUES(nextval('vender_seq'),'Honda USA','Boston');
INSERT INTO Dealership VALUES(nextval('dealership_seq'),'CarMax','Boston');
INSERT INTO Vender_dealership VALUES (nextval('vender_dealership_seq'),currval('vender_seq'),currval('dealership_seq'));

INSERT INTO Vender VALUES(nextval('vender_seq'),'Big Auto Deal','NewYork');
INSERT INTO Dealership VALUES(nextval('dealership_seq'),'Vroom','Boston');
INSERT INTO Vender_dealership VALUES (nextval('vender_dealership_seq'),currval('vender_seq'),currval('dealership_seq'));

INSERT INTO Vender VALUES(nextval('vender_seq'),'Auto USA','Connecticut');
INSERT INTO Dealership VALUES(nextval('dealership_seq'),'FourwheelDeal','Boston');
INSERT INTO Vender_dealership VALUES (nextval('vender_dealership_seq'),currval('vender_seq'),currval('dealership_seq'));


--vehicle 1
INSERT INTO Make VALUES(nextval('make_seq'),'Honda');
INSERT INTO Model VALUES(nextval('model_seq'),'Civic');
INSERT INTO Color VALUES(nextval('color_seq'),'Black');
INSERT INTO Vehicle VALUES(nextval('vehicle_seq'),currval('vender_dealership_seq'),currval('make_seq'),currval('model_seq'),
						   currval('color_seq'),1,'1HBFDR23B4B5N6N78',1000,20000,'NEW','15-AUG-2022',17500);
						   
--vehicle 2
INSERT INTO Make VALUES(nextval('make_seq'),'Honda');
INSERT INTO Model VALUES(nextval('model_seq'),'Accord');
INSERT INTO Color VALUES(nextval('color_seq'),'Red');
INSERT INTO Vehicle VALUES(nextval('vehicle_seq'),2,currval('make_seq'),currval('model_seq'),
						   currval('color_seq'),1,'9KBFDR23A4B5N6N43',1500,28000,'NEW','15-MAR-2022',20000);
						
						
--Third Vehicle						
INSERT INTO Make VALUES(nextval('make_seq'),'Toyota');
INSERT INTO Model VALUES(nextval('model_seq'),'Hilander');
INSERT INTO Color VALUES(nextval('color_seq'),'White');
INSERT INTO Vehicle VALUES(nextval('vehicle_seq'),2,currval('make_seq'),currval('model_seq'),
						   currval('color_seq'),2,'7KDFDR23B4B5N6N32',900,35000,'NEW','21-FEB-2022',25400);
						   
--Fourth Vehicle
INSERT INTO Make VALUES(nextval('make_seq'),'Toyota');
INSERT INTO Model VALUES(nextval('model_seq'),'Hilander Hybrid');
INSERT INTO Color VALUES(nextval('color_seq'),'Grey');
INSERT INTO Vehicle VALUES(nextval('vehicle_seq'),1,currval('make_seq'),currval('model_seq'),
						   currval('color_seq'),2,'9TJFDR23G4B5N6B55',55000,19000,'USED','21-APR-2022',12000);
						   
						   
--fifth vehicle						   
INSERT INTO Make VALUES(nextval('make_seq'),'Mazda');
INSERT INTO Model VALUES(nextval('model_seq'),'CX-9');
INSERT INTO Color VALUES(nextval('color_seq'),'Blue');
INSERT INTO Vehicle VALUES(nextval('vehicle_seq'),1,currval('make_seq'),currval('model_seq'),
						   currval('color_seq'),2,'2IDFMN33B4K5K6N4P',35000,30500,'USED','21-MAY-2022',25800);
						  
						  
--sixth vehicle
INSERT INTO Make VALUES(nextval('make_seq'),'Nissan');
INSERT INTO Model VALUES(nextval('model_seq'),'Pathfinder SL');
INSERT INTO Color VALUES(nextval('color_seq'),'White');
INSERT INTO Vehicle VALUES(nextval('vehicle_seq'),1,currval('make_seq'),currval('model_seq'),
						   currval('color_seq'),2,'8L4MN89B4B9N9R4A',15000,34500,'USED','23-APR-2022',28800);
						   
						   
--for further adding vehicle with this template
INSERT INTO Make VALUES(nextval('make_seq'),'Nissan');
INSERT INTO Model VALUES(nextval('model_seq'),'Rogue SL');
INSERT INTO Color VALUES(nextval('color_seq'),'Black');
INSERT INTO Vehicle VALUES(nextval('vehicle_seq'),2,7,7,
						   2,2,'4RH7HN89K4A7N6NL8',72000,20000,'USED','24-MAY-2022',22500);
						   
						   

--PUPULATING DEPARTMENT TABLE USING STORED PROCEDURE

--*****************************************************************************************************************
--1. Stored procedure for deparment 
CREATE OR REPLACE PROCEDURE add_depart(department_id in DECIMAL,dealership_id IN DECIMAL,department_name IN VARCHAR)
AS
$PROC$
BEGIN
	INSERT INTO department VALUES(department_id,dealership_id,department_name);
	
END;
$PROC$ LANGUAGE plpgsql;

--INSERTING ROW INVOKING THE PROCEDURE
CALL add_depart(nextval('department_seq'),5,'Sales_department');
CALL add_depart(nextval('department_seq'),5,'HR');
CALL add_depart(nextval('department_seq'),5,'Vehicle Service');

--*****************************************************************************************************

--These procedures below are transactionally invoked
--2. Stored Procedure for populating Address table

CREATE OR REPLACE PROCEDURE add_address(
	address_id IN DECIMAL,street_num IN DECIMAL,street_name IN VARCHAR,
	appartment_num IN VARCHAR,city IN VARCHAR, a_state IN VARCHAR,
	country IN VARCHAR, postal_code IN VARCHAR 
)

AS $PROC$
BEGIN 
	INSERT INTO Address VALUES(address_id, street_num,street_name,appartment_num,city,a_state,country,postal_code);
END;
$PROC$  LANGUAGE plpgsql;


--****************************************************************************************************************


--3. Stored Procedure for Sale_person

CREATE OR REPLACE PROCEDURE add_sale_person(
	employee_id IN DECIMAL,department_id IN DECIMAL,address_id IN DECIMAL, first_name IN VARCHAR, last_name IN VARCHAR,
	SALARY IN DECIMAL, e_position VARCHAR,DOB IN DATE,hire_date IN DATE, has_mech_certified IN BOOLEAN, does_sell_car IN BOOLEAN
)
AS
$PROC$
BEGIN
	INSERT INTO Employee VALUES(employee_id,department_id,address_id,first_name,last_name,salary,e_position,DOB,hire_date);
	INSERT INTO Sale_person VALUES(Employee_id,has_mech_certified,does_sell_car);
	
END;
$PROC$ LANGUAGE plpgsql;
--***********************************************************************************

--4.Stored Procedure for Mechanic

CREATE OR REPLACE PROCEDURE add_Mechanic(
	employee_id IN DECIMAL,department_id IN DECIMAL,address_id IN DECIMAL, first_name IN VARCHAR, last_name IN VARCHAR,
	SALARY IN DECIMAL, e_position VARCHAR,DOB IN DATE ,hire_date IN DATE, has_mech_certified IN BOOLEAN, does_sell_car IN BOOLEAN
)
AS
$PROC$
BEGIN
	INSERT INTO Employee VALUES(employee_id,department_id,address_id,first_name,last_name,salary,e_position,DOB,hire_date);
	INSERT INTO Mechanic VALUES(Employee_id,has_mech_certified,does_sell_car);
	
END;
$PROC$ LANGUAGE plpgsql;
--***********************************************************************************************


--5.Stored procedure for Customer
CREATE OR REPLACE PROCEDURE add_customer(
	customer_id IN DECIMAL,
	address_id IN DECIMAL,
	first_name IN VARCHAR,
	last_name IN VARCHAR,
	phone in DECIMAL,
	email_address IN VARCHAR
)
AS $PROC$
BEGIN
	INSERT INTO Customer Values(customer_id,address_id,first_name,last_name,phone,email_address);
END;
$PROC$ LANGUAGE plpgsql;

drop procedure add_car_sale
--************************************************************************************************
--6.Stored procedure for Car_sale

CREATE OR REPLACE PROCEDURE add_car_sale(
	sale_id IN DECIMAL,
	customer_id IN DECIMAL,
	employee_id IN DECIMAL,
	vehicle_id IN DECIMAL,
	sale_price IN DECIMAL,
	Sale_date IN DATE	
)

AS 
$PROC$
BEGIN
	INSERT INTO Car_sale VALUES (sale_id,customer_id,employee_id,vehicle_id,sale_price, sale_date);
END;
$PROC$ LANGUAGE plpgsql;

--************************************************************************************************

--7. Stored procedur for Payment
CREATE OR REPLACE PROCEDURE add_payment(
	payment_id IN DECIMAL,
	sale_id IN DECIMAL,
	payment_type_id IN DECIMAL,
	payment_date IN DATE,
	p_amount IN DECIMAL
)
AS
$PROC$
BEGIN
	INSERT INTO Payment VALUES(payment_id, sale_id,payment_type_id,payment_date,p_amount);
END;
$PROC$ LANGUAGE plpgsql;

--*********************************************************************************************************
--8.Stored Procedure for Payment_type
CREATE OR REPLACE PROCEDURE add_payment_type(
	payment_type_id IN DECIMAL,
	p_method IN VARCHAR
)
AS
$PROC$
BEGIN
	INSERT INTO Payment_type VALUES(payment_type_id,p_method);
END;
$PROC$ LANGUAGE plpgsql;

--*****************************************************************************************************************
--Stored Procedure for employee other than sale_person and mechanic

CREATE OR REPLACE PROCEDURE add_employee(
	employee_id IN DECIMAL,department_id IN DECIMAL,address_id IN DECIMAL, first_name IN VARCHAR, last_name IN VARCHAR,
	SALARY IN DECIMAL, e_position VARCHAR,DOB IN DATE,hire_date IN DATE
)
AS
$PROC$
BEGIN
	INSERT INTO Employee VALUES(employee_id,department_id,address_id,first_name,last_name,salary,e_position,DOB,hire_date);	
	
END;
$PROC$ LANGUAGE plpgsql;

--**********************************************************************************************





--Calling Stored Procedures
--Pupulating each tables by changing parameters of the procedures. and tempates looks like this.

--**************************************************************************************************
--transactionally adding in address table
START TRANSACTION;
DO
 $$BEGIN
   CALL add_address(nextval('address_seq'), 59,'jhones st','2','Newton','Massachussets','USA','02213');
 END$$;
COMMIT TRANSACTION;
--****************************************************************************************************

--transactionally adding in customer table 

START TRANSACTION;
DO
 $$BEGIN
   CALL add_customer(nextval('customer_seq'),currval('address_seq'),'Maya','Thapa',7641349531,'ma@th.com');

 END$$;
COMMIT TRANSACTION;
--***************************************************************************************************

--transactionally adding in sale table
START TRANSACTION;
DO
 $$BEGIN
   CALL add_car_sale(nextval('car_sale_seq'),currval('customer_seq'),4,7,19300, '17-JUN-2022');


 END$$;
COMMIT TRANSACTION;
--**********************************************************************************************
--transactionally adding in payment table

START TRANSACTION;
DO
 $$BEGIN
   CALL add_payment(nextval('payment_seq'), currval('car_sale_seq'),1,'29-JUN-2022',19300);
   
 END$$;
COMMIT TRANSACTION;

---**********************************************************************************************
--Some other stored procedure used are


CALL  add_sale_person(nextval('employee_seq'),5,1,'Punam', 'Jha',
			71000, 'Car service manager','11-JAN-1987','15-AUG-2020', 'FALSE','TRUE');
			
CALL  add_mechanic(nextval('employee_seq'),3,16,'Dibas', 'Lama',
			40000, 'Mechanic engineer','18-JAN-1995','15-SEPT-2021', 'TRUE','FALSE');
			
			
CALL add_employee(nextval('employee_seq'),4,4,'Raja','manandhar',40000,'financial analyst','14-APR-1989','19-JUN-2020')

drop procedure add_employee
CALL add_payment_type(nextval('payment_type_seq'),'Check');



	
--To check tables*************************************************
SELECT* FROM sale_person
SELECT* FROM ADDRESS
SELECT* FROM car_sale
SELECT* FROM employee
SELECT* FROM PAYMENT_type
select* from customer
select* from vehicle
select* from department
select* from dealership
select* from Vender						 					   
SELECT* FROM VEHICLE;
SELECT* FROM MECHANIC
--*****************************************************************					  
							 
--SECTION:QUERY EXECUTIONS AND EXPLANATIONS
--*****************************************************************

--1.Checking gross margin on each vehicle					  
					  
SELECT m.make,t.v_type,mo.model,c.v_color,v.v_condition,to_char(v.vender_price,
			'$99999999.99') as buy_price,to_char(s.sale_price,'$99999999.99') AS sale_price,
					  to_char(s.sale_price-v.vender_price,'$99999999.99')AS gross_margin				  
FROM Vehicle v
JOIN V_type t USING(type_id)
JOIN Make m USING(make_id)
JOIN Model mo USING(model_id)
JOIN Color c USING(color_id)
JOIN Car_sale s USING(vehicle_id);

--*******************************************************************
					  

---2.Subtypes related

SELECT DISTINCT First_name,Last_name, e.e_position,e.Salary,SUM(c.sale_price)AS Gross_sale, count(sale_price)AS "Number of vehicle sold"
FROM employee e
JOIN  sale_person s ON e.employee_id= s.employee_id
JOIN  Car_sale c ON  e. employee_id = c.employee_id
GROUP BY first_name,last_name,e,e_position,e.salary
ORDER BY gross_sale;

--*********************************************************************

--3.Finding status of inventory
					  
SELECT m.make,t.v_type,mo.model,c.v_color,v.v_condition,count(V.vehicle_id) as "Available number"
FROM Vehicle v
JOIN V_type t USING(type_id)
JOIN Make m USING(make_id)
JOIN Model mo USING(model_id)
JOIN Color c USING(color_id)
GROUP BY v_type,make,model,v_color,v_condition
ORDER BY COUNT(v.vehicle_id);


--************************************************************************
-- History table***
--1. Creating VehiclePriceChange table

DROP TABLE VehiclePriceChange;

CREATE SEQUENCE vehiclePriceChange_seq START WITH 1;

CREATE TABLE VehiclePriceChange(
	vehiclePriceChangeID DECIMAL(12) PRIMARY KEY,
	vehicleID DECIMAL(12),
	oldPrice DECIMAL(8,2),
	newPrice DECIMAL(8,2),
	changeDate	DATE,
	FOREIGN KEY(vehicleID)REFERENCES Vehicle(vehicle_id)
	
);
--**********************************************************************************************************
--Creating trigger for price change
CREATE OR REPLACE FUNCTION vehiclePriceChange_func()
RETURNS TRIGGER LANGUAGE plpgsql
AS
$trigfunc$
BEGIN
	IF OLD.price!=NEW.price THEN
	INSERT INTO VehiclePriceChange VALUES(nextval('vehiclePriceChange_seq'),NEW.vehicle_id,OLD.price,NEW.price,CURRENT_DATE);
	END IF;
	RETURN NEW;
END;
$trigfunc$;

CREATE TRIGGER vehiclePriceChange_trg
BEFORE UPDATE OF Price ON Vehicle
FOR EACH ROW

EXECUTE PROCEDURE vehiclePriceChange_func();
--************************************************************************************************
--updating original table
UPDATE  Vehicle
SET price = 20500
WHERE vehicle_id =1;

UPDATE  Vehicle
SET price = 21000
WHERE vehicle_id =1;

UPDATE Vehicle
SET price = 34500
WHERE vehicle_id =3;
--******************************************************************************************************
--2.For salary change
DROP TABLE SalaryChange;
DROP SEQUENCE SALARYCHANGE_SEQ
CREATE SEQUENCE SalaryChange_seq;

CREATE TABLE SalaryChange(
	salaryChangeID DECIMAL(12) PRIMARY KEY,
	employeeID DECIMAL(12),
	oldSalary DECIMAL(8,2),
	newSalary DECIMAL(8,2),
	changeDate DATE,
	FOREIGN KEY(employeeID)REFERENCES Employee(employee_id)
);
--**********************************************************************************************************
--Creating trigger
CREATE OR REPLACE FUNCTION SalaryChange_func()
RETURNS TRIGGER LANGUAGE plpgsql
AS
$trigfunc$
BEGIN
	IF OLD.salary!=NEW.salary THEN
	INSERT INTO SalaryChange VALUES(nextval('SalaryChange_seq'),NEW.employee_id,OLD.salary,NEW.salary,CURRENT_DATE);
	END IF;
	RETURN NEW;
END;
$trigfunc$;

CREATE TRIGGER SalaryChange_trg
BEFORE UPDATE OF Salary ON Employee
FOR EACH ROW

EXECUTE PROCEDURE SalaryChange_func();

--******************************************************************************************************************
--updating original table
UPDATE Employee
SET salary = 39000
WHERE employee_id = 9;

UPDATE Employee
SET salary = 44000
WHERE employee_id =7;

UPDATE Employee
SET salary = 65000
WHERE employee_id = 3;

UPDATE Employee
SET salary = 50000
WHERE employee_id = 4;

UPDATE Employee
SET salary = 50000
WHERE employee_id = 10;




SELECT* FROM SalaryChange;

UPDATE SalaryChange
set newsalary = 47000
where salarychangeid = 2

SELECT* FROM EMPLOYEE

--********************************************************************************************************
--Data Visualization
--

SELECT m.make,to_char(SUM(s.sale_price),'$99999999.99') AS "gross rvenue",
to_char(SUM(s.sale_price-v.vender_price),'$99999999.99')AS "gross_margin"				  
FROM Vehicle v
JOIN Make m USING(make_id)
JOIN Car_sale s USING(vehicle_id)
GROUP BY Make
ORDER BY SUM(s.sale_price-v.vender_price) DESC;
					  
--*********************************************************************************************************	
SELECT First_name||' '||Last_name,to_char(SUM(newsalary-oldsalary),'$99999999.99')
FROM Salarychange
JOIN Employee ON SalaryChange.EmployeeID = Employee.Employee_id
GROUP BY first_name,Last_name 
ORDER BY SUM(newsalary-oldsalary)DESC
LIMIT 10;


--**********************************************************************************************************
















	