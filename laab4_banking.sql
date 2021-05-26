create database banking_enterprise;
show databases;
drop database banking_enterprise;
use banking_enterprise;
create table branch(
branch_name varchar(30) not null,
branch_city varchar(20) not null,
assets real not null,
primary key(branch_name)
);
desc branch;
create table accounts(
accno int not null,
branch_name varchar(30) not null,
balance real not null,
primary key(accno),
foreign key(branch_name) references branch(branch_name) on delete cascade
);
desc accounts;
create table customer(
customer_name varchar(20) not null,
customer_street varchar(20) not null,
customer_city varchar(20) not null,
primary key(customer_name)
);
desc customer;
create table loan(
loan_number int not null,
branch_name varchar(20) not null,
amount real not null,
primary key(loan_number),
foreign key(branch_name) references branch(branch_name) on delete cascade
);
desc loan;
create table depositor(
customer_name varchar(20) not null,
accno int not null,
primary key(customer_name,accno),
foreign key(customer_name) references customer(customer_name) on delete cascade,
foreign key(accno) references accounts(accno) on delete cascade
);
desc depositor;
create table borrower(
customer_name varchar(20) not null,
loan_number int not null,
primary key(customer_name,loan_number),
foreign key(customer_name) references customer(customer_name) on delete cascade,
foreign key(loan_number) references loan(loan_number) on delete cascade
);
desc borrower;
create database banking_enterprise;
show databases;
drop database banking_enterprise;
use banking_enterprise;
create table branch(
branch_name varchar(30) not null,
branch_city varchar(20) not null,
assets real not null,
primary key(branch_name)
);
desc branch;
create table accounts(
accno int not null,
branch_name varchar(30) not null,
balance real not null,
primary key(accno),
foreign key(branch_name) references branch(branch_name) on delete cascade
);
desc accounts;
create table customer(
customer_name varchar(20) not null,
customer_street varchar(20) not null,
customer_city varchar(20) not null,
primary key(customer_name)
);
desc customer;
create table loan(
loan_number int not null,
branch_name varchar(20) not null,
amount real not null,
primary key(loan_number),
foreign key(branch_name) references branch(branch_name) on delete cascade
);
desc loan;
create table depositor(
customer_name varchar(20) not null,
accno int not null,
primary key(customer_name,accno),
foreign key(customer_name) references customer(customer_name) on delete cascade,
foreign key(accno) references accounts(accno) on delete cascade
);
desc depositor;
create table borrower(
customer_name varchar(20) not null,
loan_number int not null,
primary key(customer_name,loan_number),
foreign key(customer_name) references customer(customer_name) on delete cascade,
foreign key(loan_number) references loan(loan_number) on delete cascade
);
desc borrower;

insert into branch(branch_name,branch_city,assets) values('sbi pd nagar','bangalore',200000),('sbi rajaji nagar','bangalore',500000),('sbi jayanagar','bangalore',660000),('sbi vijaynagar','bangalore',870000),('sbi hosakerehalli','bangalore',550000);
insert into accounts(accno,branch_name,balance) values(1234602,'sbi hosakerehalli',5000),(1234603,'sbi vijaynagar',5000),(1234604,'sbi jayanagar',5000),(1234605,'sbi rajaji nagar',10000),(1234503,'sbi vijaynagar',40000);
insert into customer(customer_name,customer_street,customer_city) values('kezar','MG road','bangalore'),('lal krishna','ST MKS road','bangalore'),('rahul','AUGSTEN road','bangalore'),('lallu','VS road','bangalore'),('faizal','RESEDENCY road','bangalore');
insert into loan(loan_number,branch_name,amount) values(10011,'sbi jayanagar',10000),(10012,'sbi vijaynagar',5000),(10013,'sbi hosakerehalli',20000),(10014,'sbi pd nagar',15000),(10015,'sbi rajaji nagar',25000);
insert into borrower(customer_name,loan_number) values('kezar',10011),('lal krishna',10012),('rahul',10013),('lallu',10014),('lal krishna',10015);
insert into depositor(customer_name,accno)  values('lal krishna', 1234603),('lal krishna', 1234503),('kezar', 1234604),('rahul', 1234602),('lallu', 1234605);

select * from branch;
select * from accounts;
select * from customer;
select * from loan;
select * from depositor;
select * from borrower;
show tables;

select * from branch;
select * from accounts;
select * from customer;
select * from loan;
select * from depositor;
select * from borrower;

/*3.Find all the customers who have at least two accounts at the main branch*/
select customer_name from accounts a,depositor d where d.accno=a.accno and a.branch_name='sbi vijaynagar' group by d.customer_name having count(a.accno>1);

/*4.Find all the customers who have an account at all the branches located in a specific city*/
select customer_name from depositor
join accounts on accounts.accno=depositor.accno
join branch on branch.branch_name=accounts.branch_name
where branch.branch_city='bangalore' group by depositor.customer_name 
having count(distinct branch.branch_name)=(select count(branch_name) from branch where branch_city='bangalore');

/*5.Demonstrate how you delete all account tuples at every branch located in a specific city.*/
delete from accounts where branch_name in(select branch_name from branch where branch_city='bangalore');
select * from accounts;
