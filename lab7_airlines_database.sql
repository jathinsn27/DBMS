create database aircraft;
use aircraft;
 create table flights
 (flno int,
 pfrom varchar(30),
 pto varchar(30),
 distance int ,
 departs timestamp,
 arrives timestamp,
 price int,
 constraint f_air primary key(flno));
 create table aircraft (
 aid int ,
 aname varchar(15),
 cruisingrange int,
primary key (aid)
);
create table employees(
 eid int ,
 ename varchar(30),
 salary int,
primary key(eid)
);
create table certified(
 eid int ,
 aid int,
 foreign key (eid) references employees(eid),
 foreign key (aid) references aircraft (aid) 
);

insert into aircraft values(101,'747',3000);
 insert into aircraft values(102,'Boeing',900);
 insert into aircraft values(103,'647',800);
 insert into aircraft values(104,'Dreamliner',10000);
 insert into aircraft values(105,'Boeing',3500);
 insert into aircraft values(106,'707',1500);
 insert into aircraft values(107,'Dream', 120000);
 
 insert into employees values(701,'A',50000); 
insert into employees values(702,'B',100000);
insert into employees values(703,'C',150000);
insert into employees values(704,'D',90000);
insert into employees values(705,'E',40000);
insert into employees values(706,'F',60000);

insert into certified values(701,101);
insert into certified values(701,102);
insert into certified values(701,106);
insert into certified values(701,105);
insert into certified values(702,104);
insert into certified values(703,104);
insert into certified values(704,104);
insert into certified values(702,107);
insert into certified values(703,107);
insert into certified values(704,107);
insert into certified values(702,101);
insert into certified values(703,105);
insert into certified values(704,105);
insert into certified values(705,103);

insert into flights values(101,'Bangalore','Delhi',2500, '2005-05-13 07:15:31', '2005-05-13 17:15:31',5000);
insert into flights values(102,'Bangalore','Lucknow',3000,'2005-05-13 07:15:31', '2005-05-13 11:15:31',6000); 
insert into flights values(103,'Lucknow','Delhi',500, '2005-05-13 12:15:31',' 2005-05-13 17:15:31',3000);
insert into flights values(107,'Bangalore','Frankfurt',8000, '2005-05-13  07:15:31', '2005-05-13 22:15:31',60000);
insert into flights values(104,'Bangalore','Frankfurt',8500, '2005-05-13 07:15:31','2005-05-13 23:15:31',75000);
insert into flights values(105,'Kolkata','Delhi',3400, '2005-05-13 07:15:31',  '2005-05-13 09:15:31',7000);
insert into flights values(106,'Madison','New York',3400, '2005-05-13 07:15:31', '2005-05-13 017:15:31',7000);

-- i Find the names of aircraft such that all pilots certified to operate them have salaries more than Rs.80,000. 
select distinct(a.aname) from aircraft a where a.aid in
 (select c.aid from certified c where c.eid in 
 (select e.eid from employees e where e.salary>80000));
 
 -- ii.For each pilot who is certified for more than three aircrafts, find the eid and the maximum cruisingrange of the aircraft for which she or he is certified.

select c.eid,a.cruisingrange from certified c,aircraft a where c.aid =a.aid and 
(select count(ca.aid) from certified ca where ca.eid=c.eid)>3 order by a.cruisingrange desc limit 1;


-- iii.Find the names of pilots whose salary is less than the price of the cheapest route from Bengaluru to Frankfurt.

select em.ename from employees em where em.eid in
( select e.eid from employees e where e.salary<
(select min(f.price) from flights f where f.pfrom='Bangalore' and f.pto='Frankfurt'));


-- iv.For all aircraft with cruisingrange over 1000 Kms, find the name of the aircraft and the average salary of all pilots certified for this aircraft 

select  c.aid,avg(e.salary) from employees e,certified c,aircraft a  
where e.eid=c.eid and a.cruisingrange>1000 and c.aid=a.aid group by c.aid;



-- v.Find the names of pilots certified for some Boeing aircraft.

select distinct(e.ename) from employees e where e.eid in 
              (select c.eid from certified c where c.eid=e.eid and c.aid in
                      (select a.aid from aircraft a where a.aname='Boeing'));


-- vi. Find the aids of all aircraft that can be used on routes from Bengaluru to New Delhi. 

select a.aid from aircraft a where a.cruisingrange >= 
         (select f.distance from flights f where pfrom='Bangalore' and f.pto='Delhi');


-- vii. A customer wants to travel from Madison to New York with no more than two changes of flight. List the choice of departure times from Madison if the customer wants to arrive in New York by 6 p.m 

select f1.departs from flights f1,flights f2 where 
   f1.pfrom='Madison' and f2.pto='New York' and f2.arrives<'18:00:00';
