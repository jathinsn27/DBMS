create database BOOK_DEALER;
show databases;
use book_dealer;
create table AUTHOR(
author_id int not null,
name varchar(100) not null,
city varchar(100) not null,
country varchar(100) not null,
primary key(author_id)
);
desc AUTHOR;
create table PUBLISHER(
publisher_id int not null,
name varchar(100) not null,
city varchar(100) not null,
country varchar(100) not null,
primary key(publisher_id)
);
desc PUBLISHER;
create table category(
category_id int not null,
description varchar(50) not null,
primary key(category_id)
);
desc category;
create table  CATALOG(
book_id int not null,
title varchar(100) not null,
author_id int not null,
publisher_id int not null,
category_id int not null,
year int not null,
price int not null,
primary key(book_id),
foreign key(author_id) references AUTHOR(author_id) on delete cascade,
foreign key(publisher_id) references PUBLISHER(publisher_id) on delete cascade,
foreign key(category_id) references CATEGORY(category_id) on delete cascade
);
desc CATALOG;
create table CATEGORY(
category_id int not null,
description varchar(100) not null
);
desc CATEGORY;
create table ORDER_DETAILS(
order_no int not null,
book_id int not null,
quantity int not null,
foreign key(book_id) references CATALOG(book_id) on delete cascade
);
desc ORDER_DETAILS;

insert into AUTHOR values(1001,'TERAS CHAN','CA','USA'),(1002,'STEVENS','ZOMBI','UGANDA'),(1003,'M MANO','CAIR','CANADA'),(1004,'KARTHIK B.P','NEW YORK','USA'),(1005,'WILLIAM STALLINGS','LAS VEGAS','USA');
insert into PUBLISHER values(1,'PEARSON','NEW YORK','USA'),(2,'EEE','NEW SOUTH VALES','USA'),(3,'PHI','DELHI','INDIA'),(4,'WILLEY','BERLIN','GERMANY'),(5,'MGH ','NEW YORK','USA');
insert into CATEGORY values(1001,'COMPUTER SCIENCE'),(1002,'ALGORITHM DESIGN'),(1003,'ELECTRONICS'),(1004,'PROGRAMMING'),(1005,'OPERATING SYSTEMS');
insert into CATALOG values(11,'Unix System Prg',1001,1,1001,2000,251),(12,'Digital Signals',1002,2,1003,2001,425),(13,'Logic Design',1003,3,1002,1999,225),(14,'Server Prg',1004,4,1004,2001,333),(15,'Linux OS',1005,5,1005,2003,326),(16,'C++ Bible',1005,5 ,1001,2000,526),(17,'COBOL Handbook',1005,4,1001,2000,658);
insert into ORDER_DETAILS values(1,11,5),(2,12,8),(3,13,15),(4,14,22),(5,15,3),(2,17,10);

select * from author;
select * from publisher;
select * from catalog;
select * from category;
select * from order_details;

/*3.Give the details of the authors who have 2 or more books in the catalog and the price of the books in the catalog and the year of publication is after 2000*/
select a.author_id,name,city,country from author a,catalog c where a.author_id=c.author_id group by c.author_id having count(c.author_id)>1;
select price from catalog where year>2000;
/*4.Find the author of the book which has maximum sales*/ 
select name from author a,catalog c where a.author_id=c.author_id and book_id in(select book_id from order_details where quantity=(select max(quantity) from order_details));
/*5.Demonstrate how you increase the price of books published by a specific publisher by 10%*/
update catalog set price=(price + 0.1*price) where publisher_id in(select publisher_id from publisher where name='willey');
select * from catalog;
