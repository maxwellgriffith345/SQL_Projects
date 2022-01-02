-- SQLite
select * from table1

select * from table1
where PTS IS '25'

select Driver, SUM(PTS) as 'Total Points'
From table1 
Group by Driver 
Order by 2 DESC