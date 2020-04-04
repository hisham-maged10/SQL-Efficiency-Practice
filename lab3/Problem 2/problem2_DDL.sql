create database if not exists `Library Management System`;

use `Library Management System`;

create table category
(
	category_id int primary key auto_increment,
	name varchar(100) not null
);

create table publisher
(
	pub_id int primary key,
	name varchar(100) not null,
	address varchar(100) not null
);

create table book
(
	book_id int primary key auto_increment,
	title varchar(100) not null,
	price int not null,
	pub_id int not null,
	category_id int not null,
	foreign key (pub_id) references publisher(pub_id),
	foreign key (category_id) references category(category_id)
);


create table member
(
	member_id int primary key,
	name varchar(100) not null,
	address varchar(100) not null,
	join_date datetime not null
);

create table borrowing_book
(
	member_id int not null,
	book_id int not null,
	due_date datetime not null,
	return_date datetime not null,
	primary key (member_id,book_id),
	foreign key (member_id) references member(member_id),
	foreign key (book_id) references book(book_id)
);

