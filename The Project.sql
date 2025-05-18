use sales
drop database Supermarket
create database Supermarket
use Supermarket

--CREATE TABLES--

create table clients(         
c_ID char(3) primary key,
c_country varchar(25) null default('Egypt'),
c_gov varchar(25) not null,
c_street varchar(50) not null,
c_phone char(11) not null,
c_email varchar(50) null
);

create table clients_phone( 
c_code char(3),
c_phone varchar(11) check (len(c_phone) = 11 ),
constraint client_clintPhone_COM_PK primary key(c_code,c_phone),
constraint c_code_FK foreign key (c_code) references clients(c_ID)
);


create table reviews(
r_ID char(3) primary key,
r_rating int check (r_rating between 1 and 5) null,
r_comment varchar(70) null,
c_ID_FK char(3),
constraint R_fk foreign key (c_ID_FK) references clients(c_ID)
);

create table sections (
sec_ID char(4) primary key ,
sec_name varchar(20)
);

create table products(
prod_ID char(7) primary key ,
prod_name varchar(20) not null,
prod_price float not null,
sec_code_FK char(4) not null,
constraint product_section_FK foreign key (sec_code_FK) references sections(sec_ID)
);

create table suppliers(
sup_ID char(5) primary key,
sup_name varchar(20) not null,
sup_salary smallmoney check((sup_salary between 1000 and 7000)) not null
);

create table recipets(
r_num char(3) primary key,
r_date date ,
r_time  time ,
r_way varchar(8) not null default ('Cash'),
client_FK char(3),
constraint recipets_client_FK foreign key(client_FK) references clients(c_ID)
);

create table buy_process(
prod_ID_buy_FK char(7) ,
client_ID_FK char(3) ,
buy_amount  int not null,
constraint purchase_process_COM_PK primary key (prod_ID_buy_FK,client_ID_FK),
constraint client_ID_FK foreign key (client_ID_FK) references clients(c_ID),
constraint prod_ID_buy_FK foreign key(prod_ID_buy_FK) references products(prod_ID)
);


create table supply_process(
prod_ID_supply_FK char(7) ,
sup_ID_supply_FK char(5),
supply_date date,
supply_time time,
constraint product_supplier_COM_PK primary key (prod_ID_supply_FK  ,sup_ID_supply_FK),
constraint prod_ID_supply_FK foreign key (prod_ID_supply_FK ) references products(prod_ID),
constraint sup_ID_supply_FK  foreign key (sup_ID_supply_FK ) references suppliers(sup_ID)
);

create table employees (
e_ID  char(4) primary key,
e_F_name varchar(10) not null,
e_L_name varchar(10) not null,
e_country varchar(10) not null default('Egypt'),
e_gov varchar(10) not null,
e_street varchar(50) not null,
e_salary smallmoney check((e_salary between 1000 and 5000)) not null,
e_gender varchar(6) not null,
e_birth_date date ,
e_hire_date date,
e_phone varchar(11) check (len(e_phone) = 11 ),
supervisorID_FK char(4) null,
employee_sec_ID_FK char(4) not null default '1111',
constraint Supervisor_FK foreign key (supervisorID_FK) references employees(e_ID),
constraint Section_Employee_FK foreign key (employee_sec_ID_FK) references sections(sec_ID)
);
ALTER TABLE employees
ALTER COLUMN e_F_name varchar(10) NULL;

ALTER TABLE employees
ALTER COLUMN e_L_name varchar(10) NULL;

ALTER TABLE employees
ALTER COLUMN e_country varchar(10) NULL;

ALTER TABLE employees
ALTER COLUMN e_gov varchar(10)  NULL;

ALTER TABLE employees
ALTER COLUMN e_street varchar(50) NULL;

ALTER TABLE employees
ALTER COLUMN e_salary smallmoney  NULL;

ALTER TABLE employees
ALTER COLUMN e_gender varchar(6) NULL;

ALTER TABLE employees
ALTER COLUMN e_street varchar(50) NULL;
ALTER TABLE employees
ALTER COLUMN e_street varchar(50) NULL;
ALTER TABLE employees
ALTER COLUMN e_street varchar(50) NULL;



create table employees_email(
e_code  char(4) ,
e_email varchar(30) not null,
constraint employee_employeeEmail_PK primary key(e_code,e_email),
constraint e_code_FK foreign key(e_code) references employees(e_ID)
);

create table dependents(
e_ID_FK char(4),
d_name varchar(10) not null,
d_gender varchar(6) not null,
d_birth_date date ,
d_relation varchar(10) not null,

constraint employee_dependent_FK foreign key (e_ID_FK) references employees(e_ID),
constraint Employee_dependent_PK primary key (e_ID_FK)
);
create table imports(
e_ID_FK char(4),
sup_ID_import_FK char(5),
prod_amount  int not null,
process_time time,
returned_items int not null,
constraint import_supplier_COM_PK primary key (e_ID_FK ,sup_ID_import_FK),
constraint e_ID_FK foreign key (e_ID_FK) references employees(e_ID),
constraint sup_ID_import_FK foreign key (sup_ID_import_FK) references suppliers(sup_ID)
);

--*ALTER TABLES--
alter table products
add prod_expire_date date not null


alter table reviews
add r_date datetime 

--INSERT TABLES--

-- Insert clients--
INSERT INTO clients (c_ID, c_country, c_gov, c_street, c_phone, c_email)
VALUES
('001', 'Egypt', 'Cairo', 'El-Tahrir St.', '01000000001', 'client1@example.com'),
('002', 'Egypt', 'Alexandria', 'Fouad St.', '01000000002', 'client2@example.com'),
('003', 'Egypt', 'Giza', 'El-Haram St.', '01000000003', NULL),
('004', 'Egypt', 'Luxor', 'Karnak St.', '01000000004', 'client4@example.com'),
('005', 'Egypt', 'Aswan', 'Corniche St.', '01000000005', NULL),
('006', 'Egypt', 'Mansoura', 'Gomhoria St.', '01000000006', 'client6@example.com'),
('007', 'Egypt', 'Ismailia', 'Tawfiqia St.', '01000000007', NULL),
('008', 'Egypt', 'Port Said', 'Zahraa St.', '01000000008', 'client8@example.com'),
('009', 'Egypt', 'Suez', 'Suez Canal St.', '01000000009', 'client9@example.com'),
('010', 'Egypt', 'Fayoum', 'Hawara St.', '01000000010', NULL);
-- Insert clients_phone--
INSERT INTO clients_phone (c_code, c_phone)
VALUES
('001', '01000000001'),
('002', '01000000002'),
('003', '01000000003'),
('004', '01000000004'),
('005', '01000000005'),
('006', '01000000006'),
('007', '01000000007'),
('008', '01000000008'),
('009', '01000000009'),
('010', '01000000010');
-- Insert reviews--
INSERT INTO reviews (r_ID, r_rating, r_comment, c_ID_FK, r_date)
VALUES
    ('R01', 5, 'Great service!', '001', '2024-12-14 00:00:00'),
    ('R02', 4, 'Good quality products.', '002', '2024-12-14 00:00:00'),
    ('R03', 3, null, '003', '2024-12-13 00:00:00'),
    ('R04', 2, 'Not satisfied.', '004', '2024-12-13 00:00:00'),
    ('R05', 1, 'Very bad.', '005', '2024-12-12 00:00:00'),
    ('R06', 4, 'Nice staff!', '006', '2023-12-11 00:00:00'),
    ('R07', 5, 'Amazing offers!', '007', '2013-12-12 00:00:00'),
    ('R08', 3, 'Could be better.', '008', '2010-10-12 00:00:00'),
    ('R09', 2, 'Delivery was late.', '009', '2024-09-16 00:00:00'),
    ('R10', 5, null, '010', '2005-08-17 00:00:00');
-- Insert sections--
INSERT INTO sections (sec_ID, sec_name)
VALUES
('0001', 'Dairy'),
('0002', 'Bakery'),
('0003', 'Beverages'),
('0004', 'Snacks'),
('0005', 'Fruits'),
('0006', 'Vegetables'),
('0007', 'Meat'),
('0008', 'Seafood'),
('0009', 'Frozen Foods'),
('0010', 'Cleaning Supplies');

-- Insert products--
INSERT INTO products (prod_ID, prod_name, prod_price,sec_code_FK ,prod_expire_date)
VALUES
('PRD001', 'Milk', 25.0,'0001','2025-01-01'),
('PRD002', 'Bread', 10.0,'0002','2024-12-31'),
('PRD003', 'Juice', 15.0,'0003','2025-02-15'),
('PRD004', 'Cheese', 30.0,'0004','2024-11-20'),
('PRD005', 'Chips', 5.0,'0005','2025-03-10'),
('PRD006', 'Apples', 20.0,'0006', '2025-04-05'),
('PRD007', 'Tomatoes', 12.0,'0007','2024-12-25'),
('PRD008', 'Chicken', 50.0,'0008','2024-12-31'),
('PRD009', 'Shrimp', 100.0,'0009','2025-05-01'),
('PRD010', 'Detergent', 40.0,'0010','2025-06-15');

-- Insert suppliers--
INSERT INTO suppliers (sup_ID, sup_name, sup_salary)
VALUES
('SUP01', 'Fresh Foods', 5000),
('SUP02', 'Daily Dairy', 4500),
('SUP03', 'Beverage Co.', 4800),
('SUP04', 'Snack World', 3000),
('SUP05', 'Fruit Farm', 3200),
('SUP06', 'Green Veg', 4000),
('SUP07', 'Meat Masters', 6000),
('SUP08', 'Sea Fresh', 6500),
('SUP09', 'Frosty Foods', 5500),
('SUP10', 'Clean Home', 3500);



-- Insert recipets--
INSERT INTO recipets (r_num, r_date, r_time, r_way, client_FK)
VALUES
('R01', '2024-12-01', '10:30:00', 'Cash', '001'),
('R02', '2024-12-02', '11:00:00', 'Card', '002'),
('R03', '2024-12-03', '12:15:00', 'Cash', '003'),
('R04', '2024-12-04', '14:20:00', 'Card', '004'),
('R05', '2024-12-05', '16:00:00', 'Cash', '005'),
('R06', '2024-12-06', '10:45:00', 'Card', '006'),
('R07', '2024-12-07', '11:30:00', 'Cash', '007'),
('R08', '2024-12-08', '12:50:00', 'Card', '008'),
('R09', '2024-12-09', '15:10:00', 'Cash', '009'),
('R10', '2024-12-10', '17:20:00', 'Card', '010');
-- Insert buy_process--
INSERT INTO buy_process (prod_ID_buy_FK, client_ID_FK, buy_amount)
VALUES
('PRD001', '001', 2),
('PRD002', '002', 1),
('PRD003', '003', 3),
('PRD004', '004', 1),
('PRD005', '005', 5),
('PRD006', '006', 4),
('PRD007', '007', 3),
('PRD008', '008', 2),
('PRD009', '009', 1),
('PRD010', '010', 2);

-- Insert supply_process--
INSERT INTO supply_process (prod_ID_supply_FK, sup_ID_supply_FK, supply_date, supply_time)
VALUES
('PRD001', 'SUP01', '2024-12-01', '09:00:00'),
('PRD002', 'SUP02', '2024-12-02', '09:30:00'),
('PRD003', 'SUP03', '2024-12-03', '10:00:00'),
('PRD004', 'SUP02', '2024-12-04', '10:30:00'),
('PRD005', 'SUP04', '2024-12-05', '11:00:00'),
('PRD006', 'SUP05', '2024-12-06', '11:30:00'),
('PRD007', 'SUP06', '2024-12-07', '12:00:00'),
('PRD008', 'SUP07', '2024-12-08', '12:30:00'),
('PRD009', 'SUP08', '2024-12-09', '13:00:00'),
('PRD010', 'SUP10', '2024-12-10', '13:30:00');
-- Insert employees--
INSERT INTO employees (e_ID, e_F_name, e_L_name, e_country, e_gov, e_street, e_salary, e_gender, e_birth_date, e_hire_date, e_phone, supervisorID_FK, employee_sec_ID_FK)
VALUES
('E001', 'Ahmed', 'Ali', 'Egypt', 'Cairo', 'Nasr City St.', 3000, 'Male', '1990-05-10', '2020-01-15', '01100000001', NULL, '0001'),
('E002', 'Sara', 'Hassan', 'Egypt', 'Alexandria', 'Gleem St.', 3200, 'Female', '1992-08-12', '2021-03-20', '01100000002', 'E001', '0002'),
('E003', 'Omar', 'Ibrahim', 'Egypt', 'Giza', '6th October St.', 2800, 'Male', '1988-02-25', '2019-10-10', '01100000003', 'E001', '0003'),
('E004', 'Mona', 'Youssef', 'Egypt', 'Mansoura', 'Mansoura St.', 3100, 'Female', '1995-11-01', '2022-06-01', '01100000004', 'E002', '0004'),
('E005', 'Khaled', 'Farid', 'Egypt', 'Suez', 'Suez St.', 3500, 'Male', '1987-07-19', '2018-09-15', '01100000005', 'E003', '0005'),
('E006', 'Heba', 'Tarek', 'Egypt', 'Port Said', 'Port St.', 2700, 'Female', '1993-12-05', '2020-04-10', '01100000006', 'E004', '0006'),
('E007', 'Yasser', 'Gamal', 'Egypt', 'Luxor', 'Luxor St.', 2900, 'Male', '1991-03-29', '2017-07-18', '01100000007', 'E005', '0007'),
('E008', 'Amira', 'Salah', 'Egypt', 'Fayoum', 'Fayoum St.', 3000, 'Female', '1994-08-22', '2023-01-10', '01100000008', 'E006', '0008'),
('E009', 'Nour', 'Mahdy', 'Egypt', 'Aswan', 'Aswan St.', 3200, 'Female', '1989-03-15', '2016-12-05', '01100000009', 'E007', '0009'),
('E010', 'Samir', 'Mostafa', 'Egypt', 'Ismailia', 'Ismailia St.', 3400, 'Male', '1996-11-10', '2018-08-20', '01100000010', 'E008', '0010');

--Insert employee_email--

INSERT INTO employees_email(e_code,e_email)
VALUES
('E001', 'ahmed.ali@company.com'),
('E002', 'sara.hassan@company.com'),
('E003', 'omar.ibrahim@company.com'),
('E004', 'mona.youssef@company.com'),
('E005', 'khaled.farid@company.com'),
('E006', 'heba.tarek@company.com'),
('E007', 'yasser.gamal@company.com'),
('E008', 'amira.salah@company.com'),
('E009', 'nour.mahdy@company.com'),
('E010', 'samir.mostafa@company.com');
--Insert depandent--
INSERT INTO dependents(e_ID_FK,d_name,d_gender,d_birth_date,d_relation)
VALUES
('E001', 'Omar', 'Male', '2012-05-15', 'Son'),
('E002', 'Laila', 'Female', '2015-03-10', 'Daughter'),
('E003', 'Yousef', 'Male', '2010-12-25', 'Son'),
('E004', 'Hana', 'Female', '2016-06-18', 'Daughter'),
('E005', 'Adel', 'Male', '2008-11-30', 'Son'),
('E006', 'Jana', 'Female', '2013-09-07', 'Daughter'),
('E007', 'Khaled', 'Male', '2011-01-19', 'Son'),
('E008', 'Mariam', 'Female', '2017-07-14', 'Daughter'),
('E009', 'Noor', 'Female', '2014-02-22', 'Daughter'),
('E010', 'Ali', 'Male', '2015-08-05', 'Son');
 
 --Insert imorts--
 INSERT INTO imports (e_ID_FK, sup_ID_import_FK, prod_amount, process_time, returned_items)
VALUES
('E001', 'SUP01', 100, '10:30:00', 5),
('E002', 'SUP02', 200, '11:00:00', 10),
('E003', 'SUP03', 150, '12:15:00', 8),
('E004', 'SUP04', 180, '09:45:00', 12),
('E005', 'SUP05', 120, '14:00:00', 6),
('E006', 'SUP06', 90, '15:30:00', 3),
('E007', 'SUP07', 75, '13:15:00', 4),
('E008', 'SUP08', 110, '16:00:00', 7),
('E009', 'SUP09', 130, '17:20:00', 2),
('E010', 'SUP10', 95, '18:10:00', 1);

--More Employee in each Section--

INSERT INTO employees (e_ID, e_F_name, e_L_name, e_country, e_gov, e_street, e_salary, e_gender, e_birth_date, e_hire_date, e_phone, employee_sec_ID_FK)
VALUES
('E011', 'Ali', 'Ahmed', 'Egypt', 'Cairo', 'Street 1', 2000, 'Male', '1990-01-01', '2024-01-01', '01011111111', '0001'),
('E012', 'Sara', 'Mahmoud', 'Egypt', 'Giza', 'Street 2', 2500, 'Female', '1992-02-01', '2024-01-01', '01022222222', '0001'),
('E013', 'Omar', 'Ibrahim', 'Egypt', 'Alexandria', 'Street 3', 3000, 'Male', '1995-03-01', '2024-01-01', '01033333333', '0001'),
('E014', 'Laila', 'Hassan', 'Egypt', 'Luxor', 'Street 4', 3500, 'Female', '1993-04-01', '2024-01-01', '01044444444', '0001'),
('E015', 'Khaled', 'Nasser', 'Egypt', 'Aswan', 'Street 5', 4000, 'Male', '1989-05-01', '2024-01-01', '01055555555', '0001'),
('E016', 'Hana', 'Adel', 'Egypt', 'Cairo', 'Street 6', 2000, 'Female', '1991-06-01', '2024-01-01', '01066666666', '0002'),
('E017', 'Tamer', 'Ali', 'Egypt', 'Giza', 'Street 7', 2500, 'Male', '1990-07-01', '2024-01-01', '01077777777', '0002'),
('E018', 'Noha', 'Samir', 'Egypt', 'Alexandria', 'Street 8', 3000, 'Female', '1994-08-01', '2024-01-01', '01088888888', '0002'),
('E019', 'Mohamed', 'Fouad', 'Egypt', 'Luxor', 'Street 9', 3500, 'Male', '1992-09-01', '2024-01-01', '01099999999', '0002'),
('E020', 'Mona', 'Saleh', 'Egypt', 'Aswan', 'Street 10', 4000, 'Female', '1988-10-01', '2024-01-01', '01100000000', '0002'),
('E021', 'Ahmed', 'Youssef', 'Egypt', 'Cairo', 'Street 11', 2500, 'Male', '1987-11-01', '2024-01-01', '01111111111', '0003'),
('E022', 'Salma', 'Fathi', 'Egypt', 'Giza', 'Street 12', 3000, 'Female', '1991-12-01', '2024-01-01', '01122222222', '0003'),
('E023', 'Yasser', 'Saeed', 'Egypt', 'Alexandria', 'Street 13', 3500, 'Male', '1985-01-01', '2024-01-01', '01133333333', '0003'),
('E024', 'Mai', 'Ahmed', 'Egypt', 'Luxor', 'Street 14', 4000, 'Female', '1990-02-01', '2024-01-01', '01144444444', '0003'),
('E025', 'Ibrahim', 'Farid', 'Egypt', 'Aswan', 'Street 15', 4500, 'Male', '1986-03-01', '2024-01-01', '01155555555', '0003');

INSERT INTO employees (e_ID, e_F_name, e_L_name, e_country, e_gov, e_street, e_salary, e_gender, e_birth_date, e_hire_date, e_phone, employee_sec_ID_FK)
VALUES
('E026', 'Mona', 'Hassan', 'Egypt', 'Cairo', 'Street 16', 2000, 'Female', '1992-04-01', '2024-01-01', '01166666666', '0004'),
('E027', 'Hassan', 'Ali', 'Egypt', 'Giza', 'Street 17', 2500, 'Male', '1993-05-01', '2024-01-01', '01177777777', '0004'),
('E028', 'Sami', 'Nabil', 'Egypt', 'Alexandria', 'Street 18', 3000, 'Male', '1990-06-01', '2024-01-01', '01188888888', '0004'),
('E029', 'Rania', 'Mousa', 'Egypt', 'Luxor', 'Street 19', 3500, 'Female', '1989-07-01', '2024-01-01', '01199999999', '0004'),
('E030', 'Amr', 'Kamal', 'Egypt', 'Aswan', 'Street 20', 4000, 'Male', '1985-08-01', '2024-01-01', '01200000000', '0004');


INSERT INTO employees (e_ID, e_F_name, e_L_name, e_country, e_gov, e_street, e_salary, e_gender, e_birth_date, e_hire_date, e_phone, employee_sec_ID_FK)
VALUES
('E031', 'Nadia', 'Samy', 'Egypt', 'Cairo', 'Street 21', 2000, 'Female', '1991-09-01', '2024-01-01', '01211111111', '0005'),
('E032', 'Khaled', 'Mohamed', 'Egypt', 'Giza', 'Street 22', 2500, 'Male', '1992-10-01', '2024-01-01', '01222222222', '0005'),
('E033', 'Marwa', 'Farouk', 'Egypt', 'Alexandria', 'Street 23', 3000, 'Female', '1988-11-01', '2024-01-01', '01233333333', '0005'),
('E034', 'Karim', 'Tarek', 'Egypt', 'Luxor', 'Street 24', 3500, 'Male', '1994-12-01', '2024-01-01', '01244444444', '0005'),
('E035', 'Ghada', 'Amin', 'Egypt', 'Aswan', 'Street 25', 4000, 'Female', '1987-01-01', '2024-01-01', '01255555555', '0005');


INSERT INTO employees (e_ID, e_F_name, e_L_name, e_country, e_gov, e_street, e_salary, e_gender, e_birth_date, e_hire_date, e_phone, employee_sec_ID_FK)
VALUES
('E036', 'Hany', 'Youssef', 'Egypt', 'Cairo', 'Street 26', 2000, 'Male', '1989-02-01', '2024-01-01', '01266666666', '0006'),
('E037', 'Lina', 'Fawzy', 'Egypt', 'Giza', 'Street 27', 2500, 'Female', '1991-03-01', '2024-01-01', '01277777777', '0006'),
('E038', 'Sherif', 'Salah', 'Egypt', 'Alexandria', 'Street 28', 3000, 'Male', '1990-04-01', '2024-01-01', '01288888888', '0006'),
('E039', 'Yara', 'Zaki', 'Egypt', 'Luxor', 'Street 29', 3500, 'Female', '1989-05-01', '2024-01-01', '01299999999', '0006'),
('E040', 'Ali', 'Said', 'Egypt', 'Aswan', 'Street 30', 4000, 'Male', '1992-06-01', '2024-01-01', '01300000000', '0006');


INSERT INTO employees (e_ID, e_F_name, e_L_name, e_country, e_gov, e_street, e_salary, e_gender, e_birth_date, e_hire_date, e_phone, employee_sec_ID_FK)
VALUES
('E041', 'Tariq', 'Salem', 'Egypt', 'Cairo', 'Street 31', 2000, 'Male', '1991-07-01', '2024-01-01', '01311111111', '0007'),
('E042', 'Mona', 'Magdy', 'Egypt', 'Giza', 'Street 32', 2500, 'Female', '1992-08-01', '2024-01-01', '01322222222', '0007'),
('E043', 'Mohamed', 'Amer', 'Egypt', 'Alexandria', 'Street 33', 3000, 'Male', '1993-09-01', '2024-01-01', '01333333333', '0007'),
('E044', 'Reham', 'Nasr', 'Egypt', 'Luxor', 'Street 34', 3500, 'Female', '1988-10-01', '2024-01-01', '01344444444', '0007');


INSERT INTO employees (e_ID, e_F_name, e_L_name, e_country, e_gov, e_street, e_salary, e_gender, e_birth_date, e_hire_date, e_phone, employee_sec_ID_FK)
VALUES
('E045', 'Amira', 'Hassan', 'Egypt', 'Aswan', 'Street 35', 4000, 'Female', '1990-11-01', '2024-01-01', '01355555555', '0008'),
('E046', 'Hossam', 'Omar', 'Egypt', 'Cairo', 'Street 36', 2000, 'Male', '1991-12-01', '2024-01-01', '01366666666', '0008'),
('E047', 'Salma', 'Mahmoud', 'Egypt', 'Giza', 'Street 37', 2500, 'Female', '1993-01-01', '2024-01-01', '01377777777', '0008'),
('E048', 'Fayza', 'Aly', 'Egypt', 'Alexandria', 'Street 38', 3000, 'Female', '1994-02-01', '2024-01-01', '01388888888', '0008'),
('E049', 'Tamer', 'Mahmoud', 'Egypt', 'Luxor', 'Street 39', 3500, 'Male', '1992-03-01', '2024-01-01', '01399999999', '0008'),
('E050', 'Reem', 'Mostafa', 'Egypt', 'Aswan', 'Street 40', 4000, 'Female', '1987-04-01', '2024-01-01', '01400000000', '0008');


INSERT INTO employees (e_ID, e_F_name, e_L_name, e_country, e_gov, e_street, e_salary, e_gender, e_birth_date, e_hire_date, e_phone, employee_sec_ID_FK)
VALUES
('E051', 'Mohamed', 'Mousa', 'Egypt', 'Cairo', 'Street 41', 2000, 'Male', '1990-05-01', '2024-01-01', '01411111111', '0009'),
('E052', 'Maha', 'Ahmed', 'Egypt', 'Giza', 'Street 42', 2500, 'Female', '1993-06-01', '2024-01-01', '01422222222', '0009'),
('E053', 'Yousef', 'Tarek', 'Egypt', 'Aswan', 'Street 45', 4000, 'Male', '1994-09-01', '2024-01-01', '01455555555', '0009');


INSERT INTO employees (e_ID, e_F_name, e_L_name, e_country, e_gov, e_street, e_salary, e_gender, e_birth_date, e_hire_date, e_phone, employee_sec_ID_FK)
VALUES
('E054', 'Ramy', 'Ahmed', 'Egypt', 'Cairo', 'Street 46', 2000, 'Male', '1992-10-01', '2024-01-01', '01466666666', '0010'),
('E055', 'Nadia', 'Samy', 'Egypt', 'Giza', 'Street 47', 2500, 'Female', '1991-11-01', '2024-01-01', '01477777777', '0010'),
('E056', 'Mohamed', 'Ibrahim', 'Egypt', 'Luxor', 'Street 49', 3500, 'Male', '1988-01-01', '2024-01-01', '01499999999', '0010'),
('E057', 'Amr', 'Khaled', 'Egypt', 'Aswan', 'Street 50', 4000, 'Male', '1987-02-01', '2024-01-01', '01500000000', '0010');



--Update statements:--
-- update on clients table --
Update clients 
Set c_country = 'Bani sweif'
Where c_ID = '010' ;

-- update on clients_phone table --
Update clients_phone 
Set c_phone= '01000000011'
Where c_code= '001' ;

-- update on reviews table  --
Update reviews
Set r_comment= 'Fantastic' , r_rating= 5
Where r_ID = 'R06' ;

-- update on sections table  --
Update sections 
Set sec_name= 'Breakfast Foods'
Where sec_ID= '0004' ; 

-- update on products table  --
Update products
Set prod_name= 'Egg' , prod_price = 15.0 , prod_expire_date= '2025-01-04' 
Where prod_ID= 'PRD010' ; 
-- update on suppliers table  --
Update suppliers 
Set sup_salary= 5500
Where sup_ID = 'SUP7' ;

-- update on recipets table  --
Update recipets 
Set r_way = 'card'
Where r_num = 'R01' ;

-- update on buy_process table  --
Update buy_process 
Set buy_amount = 8 
Where prod_ID_buy_FK = 'PRD006';

-- update on supply_process table  --
UPDATE supply_process
SET supply_date = '2024-12-02', supply_time = '10:30:00'
WHERE prod_ID_supply_FK = 'PRD001' AND sup_ID_supply_FK = 'SUP01';

-- update on employees table  --
UPDATE employees
SET e_salary = 4000
WHERE e_ID = 'E001';
-- update on employees_email table  --
UPDATE employees_email
SET e_email = 'newemail@example.com'
WHERE e_code = 'E001' AND e_email = 'oldemail@example.com';

-- update on dependents table  --
UPDATE dependents
SET d_relation = 'Wife'
WHERE e_ID_FK = 'E002';

-- update imports table  --
UPDATE imports
SET returned_items = 5
WHERE e_ID_FK = 'E001' AND sup_ID_import_FK = 'SUP01';

select *
from employees 
where e_gov='Alexandria'or e_gov='Cairo' and e_salary>1000

select employee_sec_ID_FK as "emp_sec",count(e_ID)as countt
from employees
group by (employee_sec_ID_FK)
order by employee_sec_ID_FK DESC

-----------------------------------------------------------
--Subquery--
select r_rating,c_ID_FK
from reviews
where r_rating>all(select r_rating
				from Reviews
				where r_comment like '%Good%')


select *
from employees
where e_salary>any(select e_salary
				from employees
				where employee_sec_ID_FK='0003')

------------------------------------------------------------
--DISTINCT:--
select distinct e_F_name
from employees
------------------------------------------------------------
--BETWEEN:--
select e_F_name,e_ID,e_gov
from employees
where e_salary between 4500 and 5000
--------------------------------------------------------------------------------
--LIKE:--
select *
from clients
where c_gov like 'A%'
-------------------------------------------------------------------------
--NULL:--
select *
from clients
where c_email is null
-------------------------------------------------------------------------------
--NOT NULL:--
--1.Retrieve all reviews which have comment.
select *
from reviews
where r_comment is not null 
---------------------------------------------------------------------------------------
--AND:--
select *
from employees
where e_salary>4000 and e_gov like 'A%'
----------------------------------------------------------------------------
--order by:--
select e_F_name,e_ID,e_gov
from employees
where e_salary >3800
order by (e_ID)desc

select *
from clients
order by c_ID,c_gov

---------------------------------------------------------------------
--OR:
select *
from recipets
where r_way='cash' or r_num='R05'
---------------------------------------------------------
--Derived Attributes--
--Age
SELECT e_ID,e_F_name,e_gender,datediff(YEAR, e_birth_date, GETDATE()) as Age    
FROM employees;
----------------------------------------------------------------------------
--Aggregate function--
select min(e_salary) as 'minimum salary',max(e_salary) as 'maximum salary' ,avg(e_salary) as 'average salary',sum(e_salary) as 'sum of salaries'
from employees

select count(*) as 'number of customers'
from recipets
where r_way='Card'
------------------------------------------------------------------------------------
--Greater than (>):
select *
from buy_process
where buy_amount>2
-------------------------------------------------------------------------------------
--Equal to (=):

select e_F_name,e_ID
from employees
where e_ID='E017'

select c.*,a.c_phone
from clients c,clients_phone a
where c.c_ID=a.c_code and a.c_phone='01000000002'

----------------------------------------------------------------------------------
--group by--
select employee_sec_ID_FK,count(*) as 'Number of employees'
from employees
where e_salary between 2500and 5000
group by employee_sec_ID_FK

select sec_code_FK,max(prod_price) as 'The highest expensive'
from products
group by sec_code_FK

-------------------------------------------------------------------------------------------
--group by with order by & having--

select r_rating as stars,count(*) as 'Total Reviews'
from reviews
group by r_rating
having count(*)>1
order by count(*),r_rating desc

select employee_sec_ID_FK,avg(e_salary) as 'Average Salary'
from employees
group by employee_sec_ID_FK
having avg(e_salary)>3000 
order by avg(e_salary),employee_sec_ID_FK desc
-------------------------------------------------------------------------------------
--Inner join:--

select  s.e_F_name,s.e_L_name
from employees s inner join employees m
on s.e_ID=m.supervisorID_FK
where s.e_phone like '%7'
------------------------------------------------------------------------------------
--left join--
select c.c_ID,r_rating,r_comment
from clients c left join reviews r
on c.c_ID=r.c_ID_FK
------------------------------------------------------------------------------------
--Right join--
select sec_ID,prod_ID,prod_name
from products right join sections
on sec_code_FK=sec_ID
------------------------------------------------------------------------------------
--full join--
select c.*,r_rating,r_date
from clients c full join reviews r
on c.c_ID=r.c_ID_FK


