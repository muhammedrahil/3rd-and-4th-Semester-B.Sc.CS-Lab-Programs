create database ho;
use ho;
create table employee(employee_name varchar(20),city varchar(30));
create table works(employee_name varchar(20),company_name varchar(20),salary int);
create table company(company_name varchar(20),city varchar(30));
create table managers(employee_name varchar(20),manager_name varchar(20));

insert into employee values('Sam','Cochin');
insert into employee values('Ram','Bengaluru');
insert into employee values('Priya','Pune');

insert into works values('Sam','Wipro',15000);
insert into works values('Ram','Infosys',25000);
insert into works values('Priya','Wipro',22000);

insert into company values('Wipro', 'Bengaluru');
insert into company values('Infosys','Bengaluru');

insert into managers values('Sam','Diya');
insert into managers values('Ram','Arul');
insert into managers values('Priya','Das');

select * from employee;
select * from works;
select * from company;
select * from managers;

select employee_name from works where company_name='Infosys';
select * from employee where Employee_name in(select Employee_name from works where Company_name="Wipro");

  select * from employee where Employee_name in(select Employee_name from works where Company_name="Infosys" and Salary>10000);  
  select Employee_name from employee where City in(select City from company);
    select * from works where company_name<>'Wipro';
    
create view Employee_count as select Company_name,COUNT(company_name) as count from works group by Company_name;
 
    select Company_name  from Employee_count where count in(select MAX(count) from Employee_count);