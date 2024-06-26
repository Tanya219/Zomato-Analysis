-- EMPLOYMENT DEPARTMENT ANALYSIS

Create database Internship;
use Internship;

Create Table Dept (dept_no int Primary Key, d_name varchar(50), loc varchar(50));
Insert into Dept values
(10, "Operations", "Boston"),
(20, "Research", "Dallas"),
(30, "Sales", "Chicago"),
(40, "Accounting", "New York");
Select * from Dept;

Create Table Employees (empno int Primary Key not null, 
ename varchar(10), 
job varchar(20) default 'Clerk', 
mgr int, 
hiredate Date, 
sal decimal(10,2) check (sal >0), 
comm decimal(10,2),
dept_no int ,Foreign Key (dept_no) references Dept (dept_no) 
);
Insert into Employees values
(7369,"Smith","Clerk",7902,"1890-12-17",800.00,null,20),
(7499,"Allen","Salesman",7698,"1981-02-20",1600.00,300.00,30),
(7521,"Ward","Salesman",7698,"1981-02-22",1250.00,500.00,30),
(7566,"Jones","Manager",7839,"1981-04-02",2975.00,null,20),
(7654,"Martin","Salesman",7698,"1981-09-28",1250.00,1400.00,30),
(7698,"Blake","Manager",7839,"1981-05-01",2850.00,null,30),
(7782,"Clark","Manager",7839,"1981-06-09",2450,null,10),
(7788,"Scott","Analyst",7566,"1987-04-19",3000.00,null,20),
(7839,"King","President",null,"1981-11-17",5000.00,null,10),
(7844,"Turner","Salesman",7698,"1981-09-08",1500.00,0.00,30),
(7876,"Adams","Clerk",7788,"1987-05-23",1100.00,null,20),
(7900,"James","Clerk",7698,"1981-12-03",950.00,null,30),
(7902,"Ford","Analyst",7566,"1981-12-03",3000.00,null,20),
(7934,"Miller","Clerk",7782,"1982-01-23",1300.00,null,10);
Select * from Employees;

-- (3)
Select ename, sal from Employees where sal > 1000;

-- (4)
select * from Employees where hiredate < "1981-10-01";

-- (5)
Select * from Employees where ename like "_i%";

-- (6)
Select ename , sal,
Sal * 0.4 as Allowance,
sal * 0.10 as PF,
sal - (sal * 0.4 + sal * 0.10) as Net_Salary
from Employees;

-- (7)
select ename, job from Employees where mgr is null;

-- (8)
Select empno, ename , sal from Employees order by sal  asc;

-- (9)
select count(Job) as Total_Jobs from Employees;

-- (10)
Select sum(sal) as Total_salary from Employees where job = "Salesman";

-- (11)
Select Job, Dept_no, round(Avg(sal),2) as Average_Salary from Employees group by Job, Dept_no order by Average_Salary desc;

-- (12)
Select ename, sal, d_name from Employees as a left join Dept as b on a.dept_no = b.dept_no;

-- (13)
Create table Jobs_grade (
grade char(1) primary key,
lowest_sal int,
highest_sal int
);
insert into Jobs_grade values 
("A", 0, 999),
("B",1000,1999),
("C",2000,2999),
("D",3000,3999),
("E", 4000,5000);
Select * from Jobs_grade;

-- (14)
-- (15)
Select a.ename , b.ename from Employees a left join Employees b on a.mgr = b.empno;

-- (16)
Select ename , sal + coalesce(comm, 0) as Total_Salary from Employees;

-- (17)
Select ename , sal from Employees where  empno mod 2 = 0 ;

-- (18)
-- (19)
Select ename , sal from Employees order by sal desc limit 3;

-- (20)
Select e.ename , e.dept_no , e.sal from Employees e 
where sal in (select max(sal))
group by Dept_no order by dept_no asc;


-- ORDERS,CUST,SALESPEOPLE

-- (1)
Create table Salespeople (
snum int primary key, 
sname varchar(20), 
city varchar(50), 
comm decimal(10,2)
);
insert into Salespeople values
(1001, "Peel", "London", 0.12),
(1002, "Serres", "San Jose", 0.13),
(1003, "Axelrod", "New York", 0.10),
(1004, "Motika", "London", 0.11),
(1007, "Rafkin", "Barcelona", 0.15);
select * from Salespeople;

-- (2)
Create table Cust (
cnum int primary key,
cname varchar(50),
city varchar(30),
rating int,
snum int
);
Insert into Cust values
(2001, "Hoffman", "London",100,1001),
(2002, "Giovanne", "Rome",200,1003),
(2003, "Liu", "San Jose",300,1002),
(2004, "Grass", "Berlin",100,1002),
(2006, "Clemens", "London",300,1007),
(2007, "Pereira", "Rome",100,1004),
(2008, "James", "London",200,1007);
Select * from Cust;

-- (3)
Create table Orders (
onum int primary key,
amt decimal(10,2),
odate date,
cnum int,
snum int
);
Insert into Orders values
(3001, 18.69,"1994-10-03", 2008, 1007),
(3002, 1900.10,"1994-10-03", 2007, 1004),
(3003, 767.19,"1994-10-03", 2001, 1001),
(3005, 5160.45,"1994-10-03", 2003, 1002),
(3006, 1098.16,"1994-10-04", 2008, 1007),
(3007, 75.75,"1994-10-05", 2004, 1002),
(3008, 4723.00,"1994-10-05", 2006, 1001),
(3009, 1713.23,"1994-10-04", 2002, 1003),
(3010, 1309.95,"1994-10-06", 2004, 1002),
(3011, 9891.88,"1994-10-06", 2006, 1001);
Select * from Orders;

-- (4)
Select * from Salespeople;
Select * from Cust;
Select s.sname, c.cname, s.city from Salespeople s left join Cust c on s.snum= c.snum;

-- (5)
Select s.sname as Sale_Person, c.cname as Customer from Salespeople s left join Cust c on s.snum= c.snum;

-- (6)
select * from Orders;
select * from Cust;
select * from SalesPeople;
Select count(o.onum) as Total_Orders, c.cnum as Cust_Number, s.snum as SalesPerson_Number, c.city as Customer_City ,s.city as SalesPerson_City from Orders o
inner join Cust c on o.cnum = c.cnum 
inner join Salespeople s on o.snum = s.snum
where c.city <> s.city
group by c.cnum, s.snum ,c.city,s.city ;

-- (7)
Select o.onum, c.cname from Orders o inner join Cust c on o.cnum = c.cnum;

-- (8)
Select a.cname, b.cname, a.rating from Cust a inner join Cust b on a.rating = b.rating;

-- (9)
Select s.sname as Sales_Person,count(c.cname) as Cust_Count from Cust c inner join SalesPeople s on c.snum= s.snum group by s.sname;

-- (10)
Select a.sname as SalesPerson_1, b.sname as SalesPerson_2, a.city from SalesPeople a 
inner join SalesPeople b on a.snum = b.snum 
where a.city = b.city and a.sname <> b.sname;

-- (11)
Select count(o.onum) as Total_Orders, c.cnum as Cust_Number, s.snum as SalesPerson_Number 
from Orders o
inner join Cust c on o.cnum = c.cnum 
inner join Salespeople s on o.snum = s.snum
where c.cnum = 2008
group by c.cnum, s.snum;

-- (12)
Select * from Orders;
Select odate as Order_date, onum as Order_Number, amt from Orders 
where odate ="1994-10-04" 
and amt > ( select avg(amt) from Orders where odate ="1994-10-04");

-- (13)
select * from SalesPeople;
select count(o.onum) as Orders_Count ,s.sname as Sales_Person , s.city as City 
from SalesPeople s inner join Orders o on s.snum= o.snum 
where s.city= "London"
group by s.sname , s.city ;

-- (14)
-- (15) #Not showing ans.
select * from Cust;
select cname as Cust_Name, rating from Cust
where rating > (select rating from Cust where city = "San Jose");

-- (16)
select * from Cust;
Select * from SalesPeople;
select s.sname as Sales_Person , c.cname as Cust_Name from Salespeople s left join Cust c on s.snum = c.snum; 

