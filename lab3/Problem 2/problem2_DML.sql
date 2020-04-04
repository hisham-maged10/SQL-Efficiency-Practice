/* Write a SQL query to retrieve names of members Who Joined the system after 1
September 2000.*/
select name from member where join_date > '2000-9-01';

/*Write a SQL query to retrieve all info of members Who Joined the system between 1
October 1995 and 1 October 2019.*/
select * from member where join_date between '1995-10-01' and '2019-10-01';

/*Write a SQL query to retrieve all info of books with publisher Name “Oxford” or price
between 15 to 20*/
select *
from book
where pub_id = (select pub_id from publisher where name = "Oxford")
or 
price between 15 and 20;

/*Write a SQL query to retrieve book title for books borrowed by Member with name
“Scot Reinger”*/
select b.title from book b, member m, borrowing_book bb where b.book_id = bb.book_id and m.member_id = bb.member_id and m.name = 'Scot Reinger';

