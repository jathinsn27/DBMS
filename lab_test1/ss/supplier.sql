create database SUPPLIER_DATABASE;
use SUPPLIER_DATABASE;
create table suppliers(
sid integer not  null,
sname varchar(20) not null,
address varchar(20) not null,
primary key(sid)
);
desc suppliers;
create table parts(
pid integer not null,
pname varchar(20) not null,
color varchar(20) not null,
primary key(pid)
);
desc parts;
create table catalog(
sid int not null,
pid int not null,
cost real not null,
foreign key(sid) references suppliers(sid) on delete cascade on update cascade,
foreign key(pid) references parts(pid) on delete cascade on update cascade
);
desc catalog;
create table accounts(
accid int not null,
accname varchar(20) not null,
balanceamt real not null,
primary key(accid)
);
desc accounts;

insert into suppliers values(100,'jatin','gokulam'),(101,'nitin','mg road'),(102,'john','basavanagudi'),(103,'zack','jayanagar'),(104,'garry','jp nagar');
insert into parts values(1,'pen','red'),(2,'pencil','yellow'),(3,'eraser','pink'),(4,'scale','blue'),(5,'sharpner','green');
insert into catalog values(100,1,10000),(101,2,15000),(102,3,12000),(103,4,30000),(104,5,37000);
insert into accounts values(10,'jatin',20000),(11,'jatin',27000),(12,'john',15000),(13,'zack',30000),(14,'garry',18000);

select * from suppliers;
select * from parts;
select * from catalog;
select * from accounts;

/*4*/
select s.sname from suppliers s where s.sid in(select ca.sid
from catalog ca, parts p where ca.pid=p.pid and p.color='red'
group by ca.sid having count(ca.pid)=(select count(*) from parts p where p.color='red'));

/*5*/
select s.sid,s.sname,s.address from suppliers s, accounts a where s.sname=a.accname and balanceamt >= 25000;

/*6*/
set sql_safe_updates = 0;
update parts set pid=10 where color='yellow';
select * from parts;

/*7*/
select c.sid from catalog c where c.cost>20000;
