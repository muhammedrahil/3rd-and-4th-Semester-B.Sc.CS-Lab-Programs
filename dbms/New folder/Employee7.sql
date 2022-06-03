# Consider the employee database given below. Give an expression in SQL for each of  the following queries:

create database Employee;

Use Employee;


COMPANY (Company-Name, City)

create table company(Company_name varchar(20) not null,City varchar(15) , constraint pk_Company_name primary key (Company_name)); 

EMPLOYEE (Employee-Name, City)
 
create table Employee(Employee_name varchar(20) not null,City varchar(20),constraint pk_Employee_name primary key (Employee_name));
  
WORKS (Employee-Name, Company-Name, Salary)

create table Works(Employee_name varchar(20) not null,Company_name varchar(20),Salary int(15),constraint fk_Employee_name foreign key (Employee_name) references Employee(Employee_name),constraint fk_Comany_name foreign key (Company_name) references company(Company_name)); 

MANAGES (Employee-Name, Manager-Name)

create table manages(Employee_name varchar(20) not null,Manager_name varchar(20) not null,constraint fk_Employee_name1 foreign key (Employee_name) references Employee(Employee_name)); 

desc company;

+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| Company_name | varchar(20) | NO   | PRI | NULL    |       |
| City         | varchar(15) | YES  |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+


 desc Employee;
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| Employee_name | varchar(20) | NO   | PRI | NULL    |       |
| City          | varchar(20) | YES  |     | NULL    |       |
+---------------+-------------+------+-----+---------+-------+


 desc works;
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| Employee_name | varchar(20) | NO   | MUL | NULL    |       |
| Company_name  | varchar(20) | YES  | MUL | NULL    |       |
| Salary        | int         | YES  |     | NULL    |       |
+---------------+-------------+------+-----+---------+-------+


 desc manages;
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| Employee_name | varchar(20) | NO   | MUL | NULL    |       |
| Manager_name  | varchar(20) | NO   |     | NULL    |       |
+---------------+-------------+------+-----+---------+-------+

insert into company(Company_name,City)values("Wipro","Singapore"),("Infosys","Singapore");

insert into employee(Employee_name,city)
values("Karthik","Singapore"),  
     ("Daniel","Banglore"),
     ("Sreelakshmi","Mysoor"),
     ("Albin","Singapore"),
     ("Shan","Kerala"),
     ("Malik","Banglore"),
     ("Mubeena","Mysoor");


insert into works(Employee_name,Company_name,Salary)values("karthik","Wipro",10000),
     ("Daniel","Infosys",10000), 
     ("Sreelakshmi","Wipro",20000),
     ("Albin","Wipro",30000),
     ("Shan","Infosys",27000),
     ("Malik","Wipro",18000),
     ("Mubeena","Infosys",22000); 

insert into manages(Employee_name,Manager_name)
     values("Karthik","Vishal"),
     ("Daniel","Vishal"),
     ("Sreelakshmi","Sithara"),
     ("Albin","Sithara"), 
     ("Shan","Vishal"),
     ("Malik","Anoop"),
     ("Mubeena","Anoop");

     select *from Company;
+--------------+-----------+
| Company_name | City      |
+--------------+-----------+
| Infosys      | Singapore |
| Wipro        | Singapore |
+--------------+-----------+

     select *from Employee;

+---------------+-----------+
| Employee_name | City      |
+---------------+-----------+
| Albin         | Singapore |
| Daniel        | Banglore  |
| Karthik       | Singapore |
| Malik         | Banglore  |
| Mubeena       | Mysoor    |
| Shan          | Kerala    |
| Sreelakshmi   | Mysoor    |
+---------------+-----------+
     select *from Works;
+---------------+--------------+--------+
| Employee_name | Company_name | Salary |
+---------------+--------------+--------+
| karthik       | Wipro        |  10000 |
| Daniel        | Infosys      | 150000 |
| Sreelakshmi   | Wipro        |  20000 |
| Albin         | Wipro        |  30000 |
| Shan          | Infosys      |  27000 |
| Malik         | Wipro        |  18000 |
| Mubeena       | Infosys      |  22000 |
+---------------+--------------+--------+
     select *from manages;
+---------------+--------------+
| Employee_name | Manager_name |
+---------------+--------------+
| Karthik       | Vishal       |
| Daniel        | Vishal       |
| Sreelakshmi   | Sithara      |
| Albin         | Sithara      |
| Shan          | Vishal       |
| Malik         | Anoop        |
| Mubeena       | Anoop        |
+---------------+--------------+

A) Find the names of all employees who work in Infosys

  select Employee_name from works where Company_name="Infosys";

+---------------+
| Employee_name |
+---------------+
| Daniel        |
| Shan          |
| Mubeena       |
+---------------+

B) Find the names and cities of residence of all employees who works in Wipro

   select * from employee where Employee_name in(select Employee_name from works where Company_name="Wipro"); 

+---------------+-----------+
| Employee_name | City      |
+---------------+-----------+
| Albin         | Singapore |
| Karthik       | Singapore |
| Malik         | Banglore  |
| Sreelakshmi   | Mysoor    |
+---------------+-----------+ 

C) Find the names, and cities of all employees who work in Infosys and earn more than Rs. 10,000.

  select * from employee where Employee_name in(select Employee_name from works where Company_name="Infosys" and Salary>10000); 
+---------------+----------+
| Employee_name | City     |
+---------------+----------+
| Shan          | Kerala   |
| Mubeena       | Mysoor   |
+---------------+----------+
D) Find the employees who live in the same cities as the companies for which they work.

   select Employee_name from employee where City in(select City from company);
+---------------+
| Employee_name |
+---------------+
| Albin         |
| Karthik       |
+---------------+

E) Find all employees who do not work in Wipro Corporation.

  select * from employee where Employee_name in(select Employee_name from works where Company_name!="Wipro");  

+---------------+----------+
| Employee_name | City     |
+---------------+----------+
| Daniel        | Banglore |
| Mubeena       | Mysoor   |
| Shan          | Kerala   |
+---------------+----------+

F) Find the company that has the most employees.

    create view Employee_count as select Company_name,COUNT(company_name) as count from works group by Company_name;
 
    select Company_name  from Employee_count where count in(select MAX(count) from Employee_count);

+--------------+
| Company_name |
+--------------+
| Wipro        |
+--------------+
