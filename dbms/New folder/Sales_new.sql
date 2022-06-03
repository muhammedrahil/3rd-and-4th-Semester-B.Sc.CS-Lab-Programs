   
	
 create database sales;

use sales;

create table sales_man(
  salesman_no varchar(10) primary key,
  s_name varchar(20) not null,
  place varchar(15),
  phone int(14) unique);


create table sales_order(order_no varchar(10),
order_date date not null,
salesman_no varchar(10),
 del_type varchar(1),
 order_status varchar(20),
constraint pk_order primary key (order_no),
constraint fk_salesman_no foreign key (salesman_no) references sales_man(salesman_no),constraint ck_del_type check(del_type="F" or del_type="P"),
constraint ck_order_status check (order_status in("Inprocess","Fullfilled","Backordered","Cancelled")));
      
insert into sales_man(salesman_no,s_name,place,phone)values
 ("s001","Anil","US","705030201"),
 ("s002","Arun","UK","708030201"),
 ("s003","Jack","US","705020201"),
 ("s004","Manu","UK","705030261"),
 ("s005","Ram","UK","705038201");
	 

select *from sales_man;

+-------------+--------+-------+-----------+
| salesman_no | s_name | place | phone     |
+-------------+--------+-------+-----------+
| s001        | Anil   | US    | 705030201 |
| s002        | Arun   | UK    | 708030201 |
| s003        | Jack   | US    | 705020201 |
| s004        | Manu   | UK    | 705030261 |
| s005        | Ram    | UK    | 705038201 |
+-------------+--------+-------+-----------+

desc sales_order;

+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| order_no     | varchar(10) | NO   | PRI | NULL    |       |
| order_date   | date        | NO   |     | NULL    |       |
| salesman_no  | varchar(10) | YES  | MUL | NULL    |       |
| del_type     | varchar(1)  | YES  |     | NULL    |       |
| order_status | varchar(20) | YES  |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
   	 
insert into sales_order(order_no,order_date,salesman_no,del_type,order_status)values
("1","2021/09/01","s001","P","Inprocess"),
("2","2021/09/02","s002","P","Fullfilled"),
("3","2021/09/03","s003","F","Backordered"),
("4","2021/09/04","s004","F","cancelled"),
("5","2021/09/05","s005","P","Fullfilled");
          
select * from sales_order;

+----------+------------+-------------+----------+--------------+
| order_no | order_date | salesman_no | del_type | order_status |
+----------+------------+-------------+----------+--------------+
| 1        | 2021-09-01 | s001        | P        | Inprocess    |
| 2        | 2021-09-02 | s002        | P        | Fullfilled   |
| 3        | 2021-09-03 | s003        | F        | Backordered  |
| 4        | 2021-09-04 | s004        | F        | cancelled    |
| 5        | 2021-09-05 | s005        | P        | Fullfilled   |
+----------+------------+-------------+----------+--------------+
 	
desc sales_order;

+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| order_no     | varchar(10) | NO   | PRI | NULL    |       |
| order_date   | date        | NO   |     | NULL    |       |
| salesman_no  | varchar(10) | YES  | MUL | NULL    |       |
| del_type     | varchar(1)  | YES  |     | NULL    |       |
| order_status | varchar(20) | YES  |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+
 
alter table sales_order drop foreign key fk_salesman_no;

desc sales_order;

+--------------+-------------+------+-----+---------+-------+
| Field        | Type        | Null | Key | Default | Extra |
+--------------+-------------+------+-----+---------+-------+
| order_no     | varchar(10) | NO   | PRI | NULL    |       |
| order_date   | date        | NO   |     | NULL    |       |
| salesman_no  | varchar(10) | YES  | MUL | NULL    |       |
| del_type     | varchar(1)  | YES  |     | NULL    |       |
| order_status | varchar(20) | YES  |     | NULL    |       |
+--------------+-------------+------+-----+---------+-------+

desc sales_man;

+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| salesman_no | varchar(10) | NO   | PRI | NULL    |       |
| s_name      | varchar(20) | NO   |     | NULL    |       |
| place       | varchar(15) | YES  |     | NULL    |       |
| phone       | int         | YES  | UNI | NULL    |       |
+-------------+-------------+------+-----+---------+-------+

alter table sales_man drop primary key;

desc sales_man;

+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| salesman_no | varchar(10) | NO   |     | NULL    |       |
| s_name      | varchar(20) | NO   |     | NULL    |       |
| place       | varchar(15) | YES  |     | NULL    |       |
| phone       | int         | YES  | UNI | NULL    |       |
+-------------+-------------+------+-----+---------+-------+

alter table sales_order drop constraint ck_del_type;

alter table sales_order drop constraint ck_order_status;


alter table sales_man add constraint pk_salesman_no primary key (salesman_no);

desc sales_man;

+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| salesman_no | varchar(10) | NO   | PRI | NULL    |       |
| s_name      | varchar(20) | NO   |     | NULL    |       |
| place       | varchar(15) | YES  |     | NULL    |       |
| phone       | int         | YES  | UNI | NULL    |       |
+-------------+-------------+------+-----+---------+-------+

alter table sales_order add constraint fk_salesman_no foreign key (salesman_no) references sales_man(salesman_no);

alter table sales_order add constraint ck_del_type check(del_type="F" or del_type="P");

alter table sales_order add constraint ck_order_status check (order_status in("Inprocess","Fullfilled","Backordered","Cancelled"));



          

	
