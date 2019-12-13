create table department(
dept_id int primary key ,
dept_name varchar ( 10 ),
budget numeric ( 8 , 2 )
);
create table fine(
fine_no int primary key ,
fine_amt int
);
create table cabin(
cabin_no int primary key ,
dept_id int references department(dept_id)
);
create table staff(
emp_id int primary key ,
emp_name varchar ( 20 ),
phone numeric ( 10 , 0 ),
salary numeric ( 7 , 2 ),
dept_id int references department(dept_id),
cabin_no int references cabin(cabin_no)
);
create table GAD(
request_no serial primary key ,
req_status varchar ( 10 ) default 'failed' ,
req_date date ,
fine_status boolean default(false),
fine_no int references fine(fine_no) default( null )
);
create table inventory(
item_id int primary key ,
item_condition varchar ( 10 ),
item_name varchar ( 10 ),
price int ,
emp_id int references staff(emp_id) default( null )
);
create table aggregatetable(
emp_id int references staff(emp_id),
request_no int references GAD(request_no),
item_id int references inventory(item_id),
primary key (emp_id,request_no)
);
insert into department
values ( 1 , 'CSE' , 10000 ),( 2 , 'ECE' , 10000 ),( 3 , 'MECH' , 10000 ),( 4 , 'EEE' , 10000 ),( 5 , 'EIE' , 1
0000 );
select * from department;
insert into fine values ( 1 , 100 ),( 2 , 200 );
select * from fine;
insert into cabin values ( 1 , 1 ),( 2 , 1 ),( 3 , 2 ),( 4 , 3 ),( 5 , 4 ),( 6 , 5 ),( 7 , 1 ),( 8 , 3 );
select * from cabin;
insert into staff
values ( 100 , 'Ramesh' , 123 , 1000 , 1 , 1 ),( 101 , 'Suresh' , 556 , 2000 , 2 , 3 ),( 102 , 'Rajesh' , 444 , 1
500 , 3 , 2 ),( 103 , 'Gopi' , 555 , 9000 , 3 , 4 );
select * from staff;
/*Filling the inventory*/
insert into inventory
values ( 0 , 'GOOD' , 'LAPTOP' , 1000 ),( 1 , 'GOOD' , 'PROJECTOR' , 1000 ),( 2 , 'GOOD' , 'LAPTOP' , 200
0 ),( 3 , 'GOOD' , 'TV' , 11000 );
select * from inventory;
/*Making a request*/
insert into GAD values ( 1 , 'failed' , '01/01/2019' );
select * from GAD;
insert into aggregatetable values ( 100 , 1 , 0 );
create view checkp as select budget from department where dept_id in ( SELECT
dept_id from staff where emp_id= 100 );
create view getp as select price from inventory where item_id= 0 ; /*change req
no*/
update gad set req_status= 'success' from checkp,getp where
checkp.budget>getp.price;
update department set budget=budget-getp.price from getp where dept_id= 1 ;
/*change dep id*/
update aggregatetable set item_id= null from gad where gad.req_status= 'failed' and
gad.request_no= 1 ; /*change req no*/
update inventory set emp_id= 100 where item_id= 0 ;
select * from inventory;
select * from gad;
select * from department;
select * from aggregatetable;
select * from staff;
/*Making a request*/
insert into GAD values ( 2 , 'failed' , '02/01/2019' );
select * from GAD;
insert into aggregatetable values ( 101 , 2 , 1 );
drop view getp;
drop view checkp;
create view checkp as select budget from department where dept_id in ( SELECT
dept_id from staff where emp_id= 101 );
create view getp as select price from inventory where item_id= 1 ; /*change req
no*/
update gad set req_status= 'success' from checkp,getp where
checkp.budget>getp.price;
update department set budget=budget-getp.price from getp where dept_id= 2 ;
/*change dep id*/
update aggregatetable set item_id= null from gad where gad.req_status= 'failed' and
gad.request_no= 2 ; /*change req no*/
update inventory set emp_id= 101 where item_id= 1 ;
select * from inventory;
select * from gad;
select * from staff;
select * from department;
select * from aggregatetable;
/*Making a request*/
insert into GAD values ( 3 , 'failed' , '02/01/2019' );
select * from GAD;
insert into aggregatetable values ( 102 , 3 , 2 );
drop view getp;
drop view checkp;
create view checkp as select budget from department where dept_id in ( SELECT
dept_id from staff where emp_id= 102 );
create view getp as select price from inventory where item_id= 2 ; /*change req
no*/
update gad set req_status= 'success' from checkp,getp where
checkp.budget>getp.price;
update department set budget=budget-getp.price from getp where dept_id= 3 ;
/*change dep id*/
update aggregatetable set item_id= null from gad where gad.req_status= 'failed' and
gad.request_no= 3 ; /*change req no*/
update inventory set emp_id= 102 where item_id= 2 ;
select * from inventory;
select * from gad;
select * from staff;
select * from department;
select * from aggregatetable;
/*Making a request*/
insert into GAD values ( 4 , 'failed' , '03/01/2019' );
select * from GAD;
insert into aggregatetable values ( 103 , 4 , 3 );
drop view getp;
drop view checkp;
create view checkp as select budget from department where dept_id in ( SELECT
dept_id from staff where emp_id= 103 );
create view getp as select price from inventory where item_id= 3 ; /*change req
no*/
update gad set req_status= 'success' from checkp,getp where
checkp.budget>getp.price;
update aggregatetable set item_id= null from gad where aggregatetable.request_no
in ( select gad.request_no from gad where req_status= 'failed' ); /*change req no*/
select * from inventory;
select * from gad;
select * from staff;
select * from department;
select * from aggregatetable;
/*Fine*/
insert into fine values ( 1 , 1000 );
update gad set fine_status=true,fine_no= 1 where request_no= 2 ;
select * from gad;
update inventory set emp_id= null ,item_condition= 'BAD' where item_id= 1 ;
select * from inventory;
/*1st Query*/ /*Aggregate Function*/
select count (item_name),item_name from inventory group by item_name;
select avg (salary) as Avg_salary, sum (salary) as tot_salary, max (salary) as
max_salary, min (salary) as min_salary from staff;
/*2nd Query*/ /*Order by queries*/
select aggregatetable.emp_id,aggregatetable.item_id from aggregatetable order by
emp_id;
select * from cabin order by cabin.dept_id;
/*3rd query*/ /*Join Queries*/
select request_no,item_name from aggregatetable join inventory on
aggregatetable.item_id=inventory.item_id;
select * from aggregatetable full outer join staff on
aggregatetable.emp_id=staff.emp_id;
select * from inventory natural join staff ;
select emp_name,item_name from inventory inner join staff on
inventory.emp_id=staff.emp_id;
/*4th Query*/ /*Boolean Queries*/
select * from gad where fine_status=false;
select fine_amt,request_no from gad natural join fine where fine_status=true;
/*5th Query*/ /*Arithmetic operator*/
select dept_name,budget as dept_budget,item_name,price from department natural
join inventory where (budget-price> 5000 );
/*6th Query*/ /*String search*/
select emp_name,phone from staff where emp_name like 'Ra%' ;
/*7th Query*/ /*Extract Query*/
select extract( month from req_date) as Req_month from gad;
/*8th Query*/ /*between, in, not between queries*/
select * from staff where salary between 1000 and 4000 ;
select * from staff where salary not in ( select salary from staff where
salary> 1500 );
select * from staff where salary not between 1000 and 1500 ;
/*9th Query*/ /*update query*/
update staff set emp_name= 'Naresh' where emp_id= 101 ;
select emp_id,emp_name from staff;
/*10th Query*/ /*Subquery*/
select item_name,price from inventory where price in ( select price from inventory
where price> 1000 );
/*11th Query*/ /*Exists,not exists,any,all*/
select * from inventory where exists ( select * from staff where
inventory.emp_id=staff.emp_id);
select * from inventory where not exists ( select * from staff where
inventory.emp_id=staff.emp_id);
select * from inventory where price = any( select price from inventory where
price= 1000 );
select * from department where budget=all( select budget from department where
budget= 10000 );