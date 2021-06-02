create database student_enrollment;
show databases;

use student_enrollment;
create table student(
regno varchar(20) not null,
name varchar(20) not null,
major varchar(20) not null,
bdate date not null,
primary key(regno)
);
desc student;
create table course(
course_no int not null,
cname varchar(20) not null,
dept varchar(20) not null,
primary key(course_no)
);
desc course;
create table enroll(
regno varchar(20) not null,
course_no int not null,
sem int not null,
marks int not null,
foreign key(regno) references student(regno) on delete cascade,
foreign key(course_no) references course(course_no) on delete cascade
);
desc enroll;
create table book_adoption(
course_no int not null,
sem int not null,
book_isbn int not null,
primary key(book_isbn),
foreign key(course_no) references course(course_no) on delete cascade
);
desc book_adoption;
create table text(
book_isbn int not null,
book_title varchar(20) not null,
publisher varchar(20) not null,
author varchar(20) not null,
primary key(book_isbn),
foreign key(book_isbn) references book_adoption(book_isbn) on delete cascade
);
desc text;

insert into student values('CS01','RAM','DS','1986-03-12'),('IS02','SMITH','USP','1987-12-23'),('EC03','AHMED','SNS','1985-04-17'),('CS03','SNEHA','DBMS','1987-01-01'),('TC05','AKHILA','EC','1986-10-06');
insert into course values(11,'DS','CS'),(22,'USP','IS'),(33,'SNS','EC'),(44,'DBMS','CS'),(55,'EC','TC');
insert into enroll values('CS01',11,4,85),('IS02',22,6,80),('EC03',33,2,80),('CS03',44,6,75),('TC05',55,2,88);
insert into book_adoption values('11',4,1),('11',4,2),('44',6,3),('44',6,4),('55',2,5),('22',6,6);
insert into text values(1,'DS AND C','PRINCETON','PADMA'),(2,'FUNDAMENTALS OF DS','PRINCETON','GODSE'),(3,'FUNDAMENTALS OF DBMS','PRINCETON','NAVATHE'),(4,'SQL','PRINCETON','FOLEY'),(5,'ELECTRONIC CIRCUITS','TMH','ELMASRI'),(6,'ADV LINUX PROG','TMH','STEVENS');

select * from student;
select * from course;
select * from enroll;
select * from book_adoption;
select * from text;

/*1.Demonstrate how you add a new text book to the database and make this book be adopted by some department.*/
insert into text(book_isbn,book_title,publisher,author) values(7,'PROGRAMMING IN C','OXFORD','REEMA THAREJA');
insert into book_adoption values(11, 4, 7);
select * from book_adoption;
select * from text;

/*2.Produce a list of text books (include Course #, Book-ISBN, Book-title) in the alphabetical order for courses offered by the ‘CS’ department that use more than two books.*/
select c.course_no,t.book_isbn,t.book_title from course c, text t, book_adoption b where t.book_isbn=b.book_isbn
and b.course_no=c.course_no and c.dept="cs" and (select count(b.book_isbn) from book_adoption b where c.course_no=b.course_no)>=2 order by t.book_title;

/*3.List any department that has all its adopted books published by a specific publisher.*/
select distinct c.dept from course c where c.dept in (select c.dept from course c, book_adoption b, text t
where c.course_no=b.course_no and t.book_isbn=b.book_isbn and t.publisher='TMH') and c.dept not in
(select c.dept from course c, book_adoption b, text t where c.course_no=b.course_no and t.book_isbn=b.book_isbn and t.publisher != 'TMH');
