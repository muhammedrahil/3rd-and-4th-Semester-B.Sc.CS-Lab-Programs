create database bank;

use bank;

create table bank_customer(accno int(15) primary key,cust_name varchar(25) not null,place varchar(15));

create table deposit(accno int(15),deposit_no varchar(10),damount varchar(10),foreign key (accno) references bank_customer(accno));

create table loan(accno int(15),loan_no varchar(10),lamount varchar(10),foreign key (accno) references bank_customer(accno));

desc bank_customer;

desc deposit;

desc loan;

insert into bank_customer()values("001","suresh","kannur"),("002","saneesh","wayanad"),("003","aneesh","kozhikode"),("004","bibeesh","kasarkode"),("005","umesh","palakkad"),("006","maneesh","kochi"),("007","babeesh","alapuzha"),("008","mahesh","alapuzha");

insert into deposit()values("001","dp1","100000"),("002","dp2","200000"),("003","dp3","300000"),("004","dp4","400000");

insert into loan()value("005","lo1","100000"),("006","lo2","200000"),("007","lo3","300000"),("004","lo4","400000");

 SELECT bank_customer.accno,bank_customer.cust_name,bank_customer.place,deposit.deposit_no,deposit.damount,loan.loan_no,loan.lamount
     FROM Bank_customer
     LEFT JOIN deposit
     ON Bank_customer.accno = deposit.accno
     LEFT JOIN loan
     ON bank_customer.accno = loan.accno;
+-------+-----------+-----------+------------+---------+---------+---------+
| accno | cust_name | place     | deposit_no | damount | loan_no | lamount |
+-------+-----------+-----------+------------+---------+---------+---------+
|     1 | suresh    | kannur    | dp1        | 100000  | NULL    | NULL    |
|     2 | saneesh   | wayanad   | dp2        | 200000  | NULL    | NULL    |
|     3 | aneesh    | kozhikode | dp3        | 300000  | NULL    | NULL    |
|     4 | bibeesh   | kasarkode | dp4        | 400000  | lo4     | 400000  |
|     5 | umesh     | palakkad  | NULL       | NULL    | lo1     | 100000  |
|     6 | maneesh   | kochi     | NULL       | NULL    | lo2     | 200000  |
|     7 | babeesh   | alapuzha  | NULL       | NULL    | lo3     | 300000  |
|     8 | mahesh    | alapuzha  | NULL       | NULL    | NULL    | NULL    |
+-------+-----------+-----------+------------+---------+---------+---------+

select distinct  bank_customer.accno,bank_customer.cust_name,deposit.deposit_no,deposit.damount from bank_customer,deposit,loan where bank_customer.accno=deposit.accno and deposit.accno not in (select accno from loan)order by accno;

+-------+-----------+------------+---------+
| accno | cust_name | deposit_no | damount |
+-------+-----------+------------+---------+
|     1 | suresh    | dp1        | 100000  |
|     2 | saneesh   | dp2        | 200000  |
|     3 | aneesh    | dp3        | 300000  |
+-------+-----------+------------+---------+


select distinct  bank_customer.accno,bank_customer.cust_name,loan.loan_no,loan.lamount from bank_customer,deposit,loan where bank_customer.accno=loan.accno and loan.accno not in (select accno from deposit)order by accno;

+-------+-----------+---------+---------+
| accno | cust_name | loan_no | lamount |
+-------+-----------+---------+---------+
|     5 | umesh     | lo1     | 100000  |
|     6 | maneesh   | lo2     | 200000  |
|     7 | babeesh   | lo3     | 300000  |
+-------+-----------+---------+---------+

select distinct bank_customer.accno,bank_customer.cust_name,deposit.deposit_no,deposit.damount,loan.loan_no,loan.lamount from bank_customer,deposit,loan where deposit.accno=loan.accno and bank_customer.accno=deposit.accno;

+-------+-----------+------------+---------+---------+---------+
| accno | cust_name | deposit_no | damount | loan_no | lamount |
+-------+-----------+------------+---------+---------+---------+
|     4 | bibeesh   | dp4        | 400000  | lo4     | 400000  |
+-------+-----------+------------+---------+---------+---------+

select * from bank_customer where accno not in (select accno from deposit) and accno not in (select accno from loan);

+-------+-----------+----------+
| accno | cust_name | place    |
+-------+-----------+----------+
|     8 | mahesh    | alapuzha |
+-------+-----------+----------+


