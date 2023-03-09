--Drop table Scripts
DROP TABLE V_type;
DROP TABLE Make;
DROP TABLE Model;
DROP TABLE Color;
DROP TABLE Vender;
DROP TABLE Dealership;
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
	address_id	DECIMAL(12),
	phone_number DECIMAL(10),
	FOREIGN KEY(address_id) REFERENCES Address(address_id)
);

CREATE TABLE Dealership(
	dealership_id DECIMAL(12) PRIMARY KEY,
	vender_id DECIMAL(12),
	d_name varchar(128),
	address_id DECIMAL(12),
	FOREIGN KEY(address_id) REFERENCES Address(address_id)
);

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
	customer_id DECIMAL(12),
	make_id DECIMAL(12),
	model_id DECIMAL(12),
	color_id DECIMAL(12),
	type_id DECIMAL(12),
	VIN VARCHAR(17),
	mileage DECIMAL(7),
	price DECIMAL(8,2),
	v_condition VARCHAR(10),
	reveived_date DATE,
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


--Populating Tables




































	