SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| circle_db          |
| employee           |
| fibonacci          |
| hospital           |
| mysql              | 
| performance_schema |
| prime              |
| product            |
| sales              |
| sys                |
+--------------------+

# TO CREATE DATABASE

   CREATE DATABASE emp_salary;

# TO USE DATABASE

   USE emp_salary;

# TO CREATE TABLE

    CREATE TABLE emp_salary(EmpNo VARCHAR(10) PRIMARY KEY,EName VARCHAR(20) NOT NULL,Dept VARCHAR(20) NOT NULL,Salary INT);
# TO DISPLAY THE STRUCTURE OF THE TABLE

   DESC emp_salary;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| EmpNo  | varchar(10) | NO   | PRI | NULL    |       |
| EName  | varchar(20) | NO   |     | NULL    |       |
| Dept   | varchar(20) | NO   |     | NULL    |       |
| Salary | int(11)     | YES  |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+


# TO INSERT VALUE INTO TABLE

    INSERT INTO emp_salary(EmpNo,EName,Dept,Salary)
    VALUES("H001","ANU","HR",35000),
    ("H002","SARFAS","HR",45000),
    ("H003","MADAV","HR",55000),
    ("P001","JERRY","PURCHASE",30000),
    ("P002","ARSHAD","PURCHASE",25000),
    ("P003","KIRAN","PURCHASE",50000),
    ("S001","JACK","SALES",20000),
    ("S002","ASWIN","SALES",30000),
    ("S003","DEVE","SALES",40000);

# TO DISPLAY THE TBLE

    SELECT *FROM emp_salary;
+-------+--------+----------+--------+
| EmpNo | EName  | Dept     | Salary |
+-------+--------+----------+--------+
| H001  | ANU    | HR       |  35000 |
| H002  | SARFAS | HR       |  45000 |
| H003  | MADAV  | HR       |  55000 |
| P001  | JERRY  | PURCHASE |  30000 |
| P002  | ARSHAD | PURCHASE |  25000 |
| P003  | KIRAN  | PURCHASE |  50000 |
| S001  | JACK   | SALES    |  20000 |
| S002  | ASWIN  | SALES    |  30000 |
| S003  | DEVE   | SALES    |  40000 |
+-------+--------+----------+--------+

# TO CREATE PROCEDURE 

  
 DELIMITER /
 CREATE PROCEDURE avg_salary1(IN dep VARCHAR(20))
 BEGIN
   SELECT AVG(Salary) AVG_SALARY,Dept  FROM emp_salary WHERE Dept=dep GROUP BY Dept;
 END/

# TO CALL THE PROCEDURE
   
    CALL avg_salary("HR");

   +------------+------+
   | AVG_SALARY | Dept |
   +------------+------+
   | 45000.0000 | HR   | 
   +------------+------+

   
   CALL avg_salary1("PURCHASE");
   
   +------------+----------+
   | AVG_SALARY | Dept     |
   +------------+----------+
   | 35000.0000 | PURCHASE |
   +------------+----------+

   CALL avg_salary1("SALES");
   
   +------------+-------+
   | AVG_SALARY | Dept  |
   +------------+-------+
   | 30000.0000 | SALES |
   +------------+-------+