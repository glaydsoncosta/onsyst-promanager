/* 
	Description: "ProManager" database script - Fictional proposal manager software 
	Date: 08/27/2020
	Author: Glaydson Costa
	Info: Create a database named as "promanager" and then execute this script from top down and you'll have a fresh database with some demo data to test
*/

-- Tables
create table customer (
	id bigint identity not null primary key,
	name varchar(100) not null,
	phone_number varchar(50),
	address varchar(255),
	address_number varchar(10)
);

create table supplier (
	id bigint identity not null primary key,
	name varchar(100) not null,
	phone_number varchar(50),
	address varchar(255),
	address_number varchar(10)
);

create table supplier_contacts (
	id bigint identity not null primary key,
	supplier_id bigint not null,
	name varchar(100) not null,
	phone_number varchar(50),
	constraint fk_supplier_contacts foreign key(supplier_id) references supplier(id)
);

create table product (
	id bigint identity not null primary key,
	description varchar(100) not null,
	unit_price numeric(15,2) not null default 0.00,
	current_inventory int not null default 0
);

create table proposal (
	id bigint identity not null primary key,
	customer_id bigint not null,
	supplier_id bigint not null,
	number varchar(50) not null,
	created_at datetime not null default getdate(),
	updated_at datetime,
	subtotal numeric(15,2) not null default 0.00,
	discount numeric(15,2) default 0.00,
	grandtotal numeric(15,2) default 0.00,
	constraint fk_proposal_customer foreign key(customer_id) references customer(id),
	constraint fk_proposal_supplier foreign key(supplier_id) references supplier(id),
);

create table proposal_items (
	id bigint identity not null primary key,
	proposal_id bigint not null,
	product_id bigint not null,
	quantity int not null default 1,
	unit_price decimal(15, 2) not null default 0,
	total decimal(15, 2) not null default 0,
	constraint fk_proposal_item_proposal foreign key(proposal_id) references proposal(id),
	constraint fk_proposal_item_supplier foreign key(product_id) references product(id),
);

-- Demo Data
insert into customer(name, phone_number, address, address_number) values ('Glaydson Costa', '+5585987894075', 'Av. B', '400');

insert into supplier(name, phone_number, address, address_number) values ('OnSyst', '+551234567890', 'City of Cambridge, MA', '123');
insert into supplier_contacts(supplier_id, name, phone_number) values (1, 'Higor', '+551234567890');
insert into supplier_contacts(supplier_id, name, phone_number) values (1, 'John Doe', '+551234567890');
insert into supplier_contacts(supplier_id, name, phone_number) values (1, 'Chris', '+551234567890');

insert into product(description, unit_price, current_inventory) values('Cellulose', 10.00, 100);
insert into product(description, unit_price, current_inventory) values('Mineral Wool', 25.85, 50);
insert into product(description, unit_price, current_inventory) values('Natural Fiber', 39.99, 25);
insert into product(description, unit_price, current_inventory) values('Phenolic foam', 88.00, 30);
insert into product(description, unit_price, current_inventory) values('Polyurethane', 99.00, 10);

-- Drop table (to restart the database, just uncomment lines below and execute the script)
/*drop table proposal_items;
drop table product;
drop table proposal;
drop table supplier_contacts;
drop table supplier;
drop table customer;*/