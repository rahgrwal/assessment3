create table branch_master(branch_id varchar(6) primary key, branch_name varchar(30), branch_city varchar(40))
create table loan_details(
customer_number varchar(6) foreign key references customer_master(customer_number) ,
branch_id varchar(6) foreign key references branch_master(branch_id),
loan_amount int
)

create table customer_master(
customer_number varchar(6) primary key,
firstname varchar(30),
middlename varchar(30),
lastname varchar(30),
customer_city varchar(15),
customer_contact_no varchar(10),
occupation varchar(20),
customer_date_of_birth DATE
)

create table account_master(
account_number varchar(6) primary key,
customer_number varchar(6) foreign key references customer_master(customer_number),
branch_id varchar(6) foreign key references branch_master(branch_id),
opening_balance int,
account_opening_date DATE,
account_type varchar(10),
account_status varchar(10)
)

create table transaction_details(
transaction_number varchar(6) primary key,
account_number varchar(6) foreign key references account_master(account_number),
date_of_transaction DATE,
medium_of_transaction varchar(20),
transaction_type varchar(20),
transaction_amount int
)
select a.account_number,a.customer_number,c.firstname,c.lastname,a.account_opening_date from customer_master c,account_master a where a.customer_number=c.customer_number
select count(*) as cust_count from customer_master where customer_city='Delhi';
select a.customer_number,c.firstname,a.account_number from account_master a, customer_master c where a.customer_number=c.customer_number and day(account_opening_date)>15
select a.customer_number,c.firstname,a.account_number from account_master a, customer_master c where a.customer_number=c.customer_number and a.account_status='TERMINATED'
select count(*) as trans_count from transaction_details t, account_master a where t.account_number=a.account_number and a.customer_number='C00001'
select count(*) as count_customer from customer_master where customer_number not in(select distinct customer_master.customer_number from customer_master)
select  a.account_number, a.opening_balance+sum(t.transaction_amount) Deposit_Amount from account_master a inner join transaction_details t on a.account_number = t.account_number where t.transaction_type = 'DEPOSIT' group by  a.account_number, a.opening_balance order by a.account_number


