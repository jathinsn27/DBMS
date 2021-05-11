create database order_database;
use order_database;
create table customer(
cust_no int not null,
cname varchar(30) not  null,
city varchar(30) not null,
primary key(cust_no)
);
desc customer;
create table order_table(
order_no int not null,
odate date not null,
cust_no int not null,
order_amount int not null,
primary key (order_no),
foreign key (cust_no) references customer(cust_no) on delete cascade
);
desc order_table;
create table item(
item_no int not null,
price int not null,
primary key(item_no)
);
desc item;
create table order_item(
order_no int not null,
item_no int not null,
quantity int not null,
foreign key(order_no) references order_table(order_no) on delete cascade,
foreign key(item_no) references item(item_no) on delete cascade
);
desc order_item;
create table warehouse(
warehouse_no int not null,
city varchar(30) not null,
primary key(warehouse_no)
);
desc warehouse;
create table shipment(
order_no int not null,
warehouse_no int not null,
ship_date date not null,
foreign key(order_no) references order_table(order_no) on delete cascade,
foreign key(warehouse_no) references warehouse(warehouse_no) on delete cascade
);
desc shipment;
insert into customer values (771,'pushpa k','bangalore'),(772,'suman','mumbai'),(773,'sourav','calicut'),(774,'laila','hyderabad'),(775,'faizal','bangalore');
insert into order_table values(111,'2002-01-22',771,18000),(112,'2002-07-30',774,6000),(113,'2003-04-03',775,9000),(114,'2003-11-03',775,29000),(115,'2003-12-03',773,29000);
insert into item values(5001,503),(5002,750),(5003,150),(5004,600),(5005,890);
insert into order_item values(111,5001,50),(112,5003,20),(113,5002,50),(114,5005,60),(115,5004,90);
insert into warehouse values(1,'delhi'),(2,'bombay'),(3,'chennai'),(4,'bangalore'),(5,'bangalore');
insert into shipment values(111,1,'2002-02-10'),(112,5,'2002-10-09'),(113,2,'2003-02-10'),(114,3,'2003-12-10'),(115,4,'2004-01-19');
select * from customer;
select * from order_table;
select * from item;
select * from order_item;
select * from warehouse;
select * from shipment;

/*1.Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column
is the total numbers of orders by the customer and the last column is the average order amount for that customer.*/
select c.cname as custname, count(*) as no_of_orders,avg(o.order_amount) as avg_order_amt
from customer c,order_table o where c.cust_no=o.cust_no group by c.cname;
/*2.List the order# for orders that were shipped from all warehouses that the company has in a specific city.*/
select order_no from shipment s, warehouse w where w.warehouse_no=s.warehouse_no and city='bombay';
/*3.Demonstrate how you delete item# 10 from the ITEM table and make that field null in the ORDER_ITEM table.*/
delete from item where item_no='5001';
select * from item;
select * from order_item;
