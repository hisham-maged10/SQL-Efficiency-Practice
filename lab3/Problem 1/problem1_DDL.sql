create database if not exists company;
use company;

CREATE TABLE employee (
  ssn int primary key,
  fname varchar(100) NOT NULL,
  lname varchar(100) NOT NULL,
  bdate date NOT NULL,
  address varchar(100) NOT NULL,
  gender char(1) NOT NULL,
  salary int NOT NULL,
  dno int NOT NULL
);


CREATE TABLE department (
  dnumber int primary key,
  dname varchar(100) NOT NULL,
  mgr_ssn int NOT NULL,
  mgr_start_date date NOT NULL
);

CREATE TABLE project (
  pnumber int(11) primary key,
  pname varchar(100) NOT NULL,
  plocation varchar(100) NOT NULL,
  dno int(11) NOT NULL
);

ALTER TABLE department ADD FOREIGN KEY (mgr_ssn) REFERENCES employee (ssn);

ALTER TABLE employee ADD FOREIGN KEY (dno) REFERENCES department (dnumber);

ALTER TABLE project ADD FOREIGN KEY (dno) REFERENCES department (dnumber);

