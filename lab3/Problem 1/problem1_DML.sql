SET GLOBAL FOREIGN_KEY_CHECKS=0;

insert into employee 
values(4725,'Hisham','Maged','1998-10-20','N/A','m',10000,1);

SET GLOBAL FOREIGN_KEY_CHECKS=1;

insert into department values(1,'management',4725,'2019-11-02');

INSERT INTO department  
VALUES
(2, 'R&D', 4725, '2019-11-02'),
(3, 'IT', 4725, '2019-11-02');

INSERT INTO employee 
VALUES 
(1, 'dmlEmp1', 'dmlEmp1', '2019-11-02', 'N/A', 'M', 4500, 2),
(2, 'dmlEmp2', 'dmlEmp2', '2019-11-02', 'N/A', 'M', 4500, 3);

INSERT INTO project 
VALUES
(1, 'project 1', 'loc 1', 1),
(2, 'project 2', 'loc 2', 2),
(3, 'project 3', 'loc 3', 3);

