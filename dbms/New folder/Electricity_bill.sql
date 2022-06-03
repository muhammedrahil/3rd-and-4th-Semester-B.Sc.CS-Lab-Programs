# Write a program block to calculate the electricity bill by accepting cust_no and units_consumed 

drop database Electricity;

create database Electricity;

use Electricity;

create table Rate(Rate_no int primary key,Rate_exp varchar(15),Rate int);

create table customer(Cust_no varchar(20) primary key,cust_name varchar(20));

create table bill(Cust_no varchar(20),Date date,Bill_amt int,constraint fk_Cust_no Foreign key (Cust_no) references customer(Cust_no));

insert into rate values(1,"0-100",5),(2,"101-200",7),(3,"201-300",10),(4,"300 abov",15);

insert into customer values("c001","Jack"),("c002","Vishnu"),("c003","Anu"),("c004","Kiran"),("c005","Sharath");


 drop procedure Calc_Bill;

 delimiter //
 create procedure Calc_Bill(IN cust_no varchar(20),month date ,unit float)
     begin
       declare mth date;
       declare Tcust_no varchar(20);
       declare rate1,rate2,rate3,rate4,Tunit,total float;
       Set Tcust_no=cust_no;
       set Tunit=unit;
       set mth = month;
       set rate1=(select Rate.Rate from rate where Rate_no="1");
       set rate2=(select Rate.Rate from rate where Rate_no="2");
       set rate3=(select Rate.Rate from rate where Rate_no="3");
       set rate4=(select Rate.Rate from rate where Rate_no="4");
              if Tunit>0 and Tunit<=100 then
                 set total=Tunit*rate1;
                 insert into bill(Cust_no,Date,Bill_amt)values(Tcust_no,mth,total);
                 
                end if; 
              if Tunit>100 and Tunit<=200 then
                    set total=((100*rate1)+(Tunit-100)*rate2);
                   insert into bill(Cust_no,Date,Bill_amt)values(Tcust_no,mth,total);
                 
                end if;
                if Tunit>200 and Tunit<=300 then
                    set total=((100*5)+(100*rate2)+(Tunit-200)*rate3);
                   insert into bill(Cust_no,Date,Bill_amt)values(Tcust_no,mth,total);
                     
                end if;
                if Tunit>300 then
                    set total=((100*rate1)+(100*rate2)+(100*rate3)+(unit-300)*rate4);
                   insert into bill(Cust_no,Date,Bill_amt)values(Tcust_no,mth,total);
                     
                end if;
              select  bill.cust_no,Cust_name,bill.Date,bill.Bill_amt from bill,customer where Customer.Cust_no=bill.Cust_no order by Date ASC;
     end //

     delimiter ;

call  Calc_Bill("c001","2021/12/01",35);

+---------+-----------+------------+----------+
| cust_no | Cust_name | Date       | Bill_amt |
+---------+-----------+------------+----------+
| c001    | Jack      | 2021-12-01 |      175 |
+---------+-----------+------------+----------+

call  Calc_Bill("c002","2021/12/02",100);

+---------+-----------+------------+----------+
| cust_no | Cust_name | Date       | Bill_amt |
+---------+-----------+------------+----------+
| c001    | Jack      | 2021-12-01 |      175 |
| c002    | Vishnu    | 2021-12-02 |      500 |
+---------+-----------+------------+----------+

call  Calc_Bill("c003","2021/12/03",150);

+---------+-----------+------------+----------+
| cust_no | Cust_name | Date       | Bill_amt |
+---------+-----------+------------+----------+
| c001    | Jack      | 2021-12-01 |      175 |
| c002    | Vishnu    | 2021-12-02 |      500 |
| c003    | Anu       | 2021-12-03 |      850 |
+---------+-----------+------------+----------+

call  Calc_Bill("c004","2021/12/05",201);

+---------+-----------+------------+----------+
| cust_no | Cust_name | Date       | Bill_amt |
+---------+-----------+------------+----------+
| c001    | Jack      | 2021-12-01 |      175 |
| c002    | Vishnu    | 2021-12-02 |      500 |
| c003    | Anu       | 2021-12-03 |      850 |
| c004    | Kiran     | 2021-12-05 |     1210 |
+---------+-----------+------------+----------+

call  Calc_Bill("c005","2021/12/04",305);

+---------+-----------+------------+----------+
| cust_no | Cust_name | Date       | Bill_amt |
+---------+-----------+------------+----------+
| c001    | Jack      | 2021-12-01 |      175 |
| c002    | Vishnu    | 2021-12-02 |      500 |
| c003    | Anu       | 2021-12-03 |      850 |
| c005    | Sharath   | 2021-12-04 |     2275 |
| c004    | Kiran     | 2021-12-05 |     1210 |
+---------+-----------+------------+----------+