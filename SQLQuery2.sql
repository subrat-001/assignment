CREATE DATABASE Db_Tutorial;
Create table Tb_employee
(employee_name varchar(255),street varchar(255), city varchar(255),primary key(employee_name));
Create table Tb_works
(employee_name varchar(255),company_name varchar(255),salary int ,primary key (employee_name), foreign key(employee_name) references tb_employee(employee_name),foreign key(company_name) references Tb_company(company_name));
Create table Tb_company
(company_name varchar(255),city varchar(255) ,primary key (company_name));
Create table Tb_manages
(employee_name varchar(255),manager_name varchar(255),primary key (employee_name), foreign key(employee_name) references tb_employee(employee_name) );
select * from Tb_employee;
insert into Tb_employee 
values('subrat','naya bato','banepa'),('suyog','purano bato','kathmandu');
insert into Tb_employee 
values('tarris','4th avvinue','Lonodon'),('Trought','144th Street','New York');
insert into Tb_company
values ('First bank Corporation','kathmandu'),('Second bank Corporation','London');
insert into Tb_company
values ('Small bank Corporation','kathmandu');
insert into Tb_works
values('subrat','First bank Corporation',100000),('tarris','Second bank Corporation',50000);
insert into Tb_works
values('suyog','First bank Corporation',150000),('Trought','Second bank Corporation',21000)
insert into Tb_employee 
values('Wall','New avvinue','Lonodon');
insert into Tb_works
values('Wall','Small bank Corporation',20000);
insert into Tb_employee 
values('Winl','Old avvinue','Lonodon');
insert into Tb_works
values('Winl','Small bank Corporation',10000);
alter table tb_manages
add foreign key(manager_name) references tb_employee(employee_name);
insert into Tb_employee 
values('Red','naya bato','banepa');
insert into Tb_works
values('Red','First bank Corporation',20000);
insert into Tb_manages
values('subrat','Red'),('suyog','subrat'),('Trought','tarris')

Select * from Tb_company;
--Solution 2a
Select * from Tb_works where company_name='First bank Corporation';
-- Solution 2b
select Tb_employee.city,Tb_employee.street from Tb_employee full join Tb_works on Tb_employee.employee_name=Tb_works.employee_name where Tb_works.company_name='First bank Corporation';
--Solution 2c
update Tb_works
set salary=5000
where employee_name='subrat';
select Tb_employee.employee_name,Tb_employee.city,Tb_employee.street 
from Tb_employee 
full join Tb_works 
on Tb_employee.employee_name=Tb_works.employee_name 
where Tb_works.company_name='First bank Corporation' and Tb_works.salary>=10000;
--solution 2d
select Tb_works.employee_name 
from Tb_employee 
full join (Tb_works left join Tb_company on Tb_company.company_name=Tb_works.company_name)on Tb_employee.employee_name=Tb_works.employee_name where Tb_employee.city=Tb_company.city;
--2e
select Tb_manages.employee_name,Tb_manages.manager_name,Tb_employee.city,Tb_employee.street
into Tb_combined 
from Tb_employee right join Tb_manages
on Tb_manages.manager_name=Tb_employee.employee_name;
select *from Tb_combined;
select *from Tb_employee;
alter table Tb_combined
add foreign key(employee_name) references tb_employee(employee_name);
select * from Tb_combined left join Tb_employee 
on Tb_combined.employee_name=Tb_employee.employee_name
where Tb_combined.city=Tb_employee.city and Tb_combined.street=Tb_employee.street;
--2f
select * from Tb_works
where Tb_works.company_name!='First bank Corporation';
--2g
select * from tb_works
where Tb_works.salary>all(select Tb_works.salary 
from Tb_works where Tb_works.company_name='Small bank Corporation');
--2i
select salary, employee_name, company_name
from Tb_works
where salary > (
	select AVG(salary)
    from Tb_works w
    where w.company_name = Tb_works.company_name);
select * from Tb_works;
--1j
select company_name, COUNT(*) as max_employee
from Tb_works
group by company_name
order by max_employee;
select * from Tb_works;
--1k
select company_name,Sum(salary) as min_salary
from Tb_works
group by company_name
order by min_salary;
--1l
select company_name,avg(salary) as avg_salary
from Tb_works
group by company_name
having avg(salary)>(
select avg(salary) as avg_salary 
from Tb_works w2 
group by company_name 
having w2.company_name='First bank Corporation');
select * from Tb_works;
-- several select * statements were used to check table
-- insted of jones we will be using subrat for 3a
--3a
update Tb_employee
Set city='newtown'
where employee_name like ('%subrat');
select * from Tb_works;
select * from Tb_manages;
--3b
update Tb_works
set salary=salary+0.1*salary
where company_name='First bank Corporation';
--3c syntax problem so commented the statemen
--UPDATE Tb_works, Tb_manages
--SET salary = salary + (salary * 0.1)
--WHERE tb_works.employee_name = tb_manages.employee_name AND works.company_name = 'First bank Corporation';
--3d siliar to 3c
--3e
delete from Tb_works
where Tb_works.company_name='Small bank Corporation';
select * from Tb_works;
