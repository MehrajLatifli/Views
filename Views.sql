-- Views




use Library




--x Display books with the minimum number of pages issued by a particular publishing house.


CREATE OR ALTER VIEW view_1_1
As
Select  
Library.dbo.Books.Pages,
Library.dbo.Books.[Name] as Book,
Library.dbo.Press.[Name] as Pulblisher
from
Library.dbo.Books 
Inner Join Library.dbo.Press
ON
Library.dbo.Books.Id_Press=Library.dbo.Press.Id 
where 
Library.dbo.Press.Name='Piter'
AND
Library.dbo.Books.Pages=
(
Select  
Min(Pages)
from 
Library.dbo.Books 
Inner Join Library.dbo.Press
ON
Library.dbo.Books.Id_Press=Library.dbo.Press.Id 
where 
Library.dbo.Press.Name='Piter'
)
OR
(
Library.dbo.Press.Name='BHV'
AND
Library.dbo.Books.Pages=
(
Select  
Min(Pages)
from 
Library.dbo.Books 
Inner Join Library.dbo.Press
ON
Library.dbo.Books.Id_Press=Library.dbo.Press.Id 
where 
Library.dbo.Press.Name='BHV'
)
)
OR
(
Library.dbo.Press.Name='DiaSoft'
AND
Library.dbo.Books.Pages=
(
Select  
Min(Pages)
from 
Library.dbo.Books 
Inner Join Library.dbo.Press
ON
Library.dbo.Books.Id_Press=Library.dbo.Press.Id 
where 
Library.dbo.Press.Name='DiaSoft'
)
)
OR
(
Library.dbo.Press.Name='Binom'
AND
Library.dbo.Books.Pages=
(
Select  
Min(Pages)
from 
Library.dbo.Books 
Inner Join Library.dbo.Press
ON
Library.dbo.Books.Id_Press=Library.dbo.Press.Id 
where 
Library.dbo.Press.Name='Binom'
)
)
OR
(
Library.dbo.Press.Name='Nauka'
AND
Library.dbo.Books.Pages=
(
Select  
Min(Pages)
from 
Library.dbo.Books 
Inner Join Library.dbo.Press
ON
Library.dbo.Books.Id_Press=Library.dbo.Press.Id 
where 
Library.dbo.Press.Name='Nauka'
)
)
OR
(
Library.dbo.Press.Name='Kudits-Image'
AND
Library.dbo.Books.Pages=
(
Select  
Min(Pages)
from 
Library.dbo.Books 
Inner Join Library.dbo.Press
ON
Library.dbo.Books.Id_Press=Library.dbo.Press.Id 
where 
Library.dbo.Press.Name='Kudits-Image'
)
)
OR
(
Library.dbo.Press.Name='Dialectics'
AND
Library.dbo.Books.Pages=
(
Select  
Min(Pages)
from 
Library.dbo.Books 
Inner Join Library.dbo.Press
ON
Library.dbo.Books.Id_Press=Library.dbo.Press.Id 
where 
Library.dbo.Press.Name='Dialectics'
)
)




select 
*from view_1_1



CREATE OR ALTER VIEW view_1_2
As
Select  
Min(Pages) AS [Min pages],
Library.dbo.Press.Name
from 
Library.dbo.Books 
Inner Join Library.dbo.Press
ON
Library.dbo.Books.Id_Press=Library.dbo.Press.Id 
group by 
Library.dbo.Press.Id,
Library.dbo.Press.Name




select 
*from view_1_2





-- Display the names of publishers who have issued books with an average number of pages larger than 100


CREATE OR ALTER VIEW view_2
As
Select  
AVG(Pages) AS [AVG(Pages)>100],
Library.dbo.Press.[Name] as Pulblisher
from 
Library.dbo.Books 
Inner Join Library.dbo.Press
ON
Library.dbo.Books.Id_Press=Library.dbo.Press.Id 
Group by 
Library.dbo.Press.Id,
Library.dbo.Press.[Name]
Having
AVG(Pages)>100



select 
*from view_2




-- Output the total amount of pages of all the books in the library issued by the publishing houses BHV and BINOM


CREATE OR ALTER VIEW view_3
As
Select  
SUM(Pages) as [Sum of Pages]
from
Library.dbo.Books 
Inner Join Library.dbo.Press
ON
Library.dbo.Books.Id_Press=Library.dbo.Press.Id 
where 
Library.dbo.Press.Name='BHV'
or
Library.dbo.Press.Name='Binom'




select 
*from view_3




-- Select the names of all students who took books between January 1, 2001 and the current date.


CREATE OR ALTER VIEW view_4
As
Select
Library.dbo.S_Cards.DateIn,
Library.dbo.Students.FirstName,
Library.dbo.Students.LastName
from
Library.dbo.Students 
Inner Join Library.dbo.S_Cards
ON
Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
--where 
--Library.dbo.S_Cards.DateIn>=N'2000-01-01 00:00:00.000'
Group by 
Library.dbo.S_Cards.DateIn,
Library.dbo.Students.FirstName,
Library.dbo.Students.LastName
Having
Library.dbo.S_Cards.DateIn >=N'2000-01-01 00:00:00.000'
AND
Library.dbo.S_Cards.DateIn <=GETDATE() 




select 
*from view_4




--  Find all students who are currently working with the book "Windows 2000 Registry" by Olga Kokoreva.


CREATE OR ALTER VIEW view_5
As
Select
Library.dbo.Students.FirstName,
Library.dbo.Students.LastName
from
Library.dbo.Students 
Inner Join Library.dbo.S_Cards
ON
Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
Inner Join Library.dbo.Authors
ON
Library.dbo.Authors.Id=Library.dbo.Books.Id_Author
where
Library.dbo.Authors.FirstName='Olga'
AND
Library.dbo.Authors.LastName='Kokoreva'
AND
Library.dbo.Books.Name='Windows 2000 Registry'




select 
*from view_5




-- Display information about authors whose average volume of books (in pages) is more than 600 pages.


CREATE OR ALTER VIEW view_6
As
Select
AVG(Pages) AS [AVG>600],
Library.dbo.Authors.FirstName,
Library.dbo.Authors.LastName
from
Library.dbo.Books
Inner Join Library.dbo.Authors
ON
Library.dbo.Authors.Id=Library.dbo.Books.Id_Author
GROUP BY
Library.dbo.Authors.Id,
Library.dbo.Authors.FirstName,
Library.dbo.Authors.LastName
Having AVG(Pages)>600




select 
*from view_6




-- Display information about publishers, whose total number of pages of books published by them is more than 700.


CREATE OR ALTER VIEW view_7
As
Select  
SUM(Pages) as [SUM(Pages)>700],
Library.dbo.Press.[Name] as Publisher
from
Library.dbo.Books 
Inner Join Library.dbo.Press
ON
Library.dbo.Books.Id_Press=Library.dbo.Press.Id
GROUP BY
Library.dbo.Press.Id,
Library.dbo.Press.[Name]
Having
SUM(Pages)>700




select 
*from view_7




-- Display all visitors to the library (and students and teachers) and the books they took.


CREATE OR ALTER VIEW view_8
As
Select  
Library.dbo.Teachers.FirstName,
Library.dbo.Teachers.LastName
from
Library.dbo.Teachers 
Inner Join Library.dbo.T_Cards
ON
Library.dbo.Teachers.Id=Library.dbo.T_Cards.Id_Teacher
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.T_Cards.Id_Book
Union ALL
Select  
Library.dbo.Students.FirstName,
Library.dbo.Students.LastName
from
Library.dbo.Students 
Inner Join Library.dbo.S_Cards
ON
Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book




select 
*from view_8




-- Print the most popular author (s) among students and the number of books of this author taken in the library.


CREATE OR ALTER VIEW view_9
As
Select  
Library.dbo.Authors.FirstName,
Library.dbo.Authors.LastName,
Library.dbo.Books.[Name],
Library.dbo.Books.Quantity
from
Library.dbo.Students 
Inner Join Library.dbo.S_Cards
ON
Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
Inner Join Library.dbo.Authors
ON
Library.dbo.Authors.Id=Library.dbo.Books.Id_Author




select 
*from view_9




-- To deduce the most popular Themes among students and teachers.


CREATE OR ALTER VIEW view_10
As
Select Distinct
Top(2)
Library.dbo.Themes.Id,
Library.dbo.Themes.[Name]
from
Library.dbo.Teachers 
Inner Join Library.dbo.T_Cards
ON
Library.dbo.Teachers.Id=Library.dbo.T_Cards.Id_Teacher
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.T_Cards.Id_Book
Inner Join Library.dbo.Themes
ON
Library.dbo.Books.Id_Themes=Library.dbo.Themes.Id
INTERSECT
Select Distinct
Library.dbo.Themes.Id,
Library.dbo.Themes.[Name]
from
Library.dbo.Students 
Inner Join Library.dbo.S_Cards
ON
Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
Inner Join Library.dbo.Themes
ON
Library.dbo.Books.Id_Themes=Library.dbo.Themes.Id




select 
*from view_10




-- Display the number of teachers and students who visited the library


CREATE OR ALTER VIEW view_11
As
SELECT
 (
  Select 
  COUNT(*) as [Teachers' count]
  from
  Library.dbo.Teachers 
  Inner Join Library.dbo.T_Cards
  ON
  Library.dbo.Teachers.Id=Library.dbo.T_Cards.Id_Teacher
  Inner Join Library.dbo.Books
  ON
  Library.dbo.Books.Id=Library.dbo.T_Cards.Id_Book
 ) 
  as [Teachers' count],
 (
  Select 
  COUNT(*) as [Students' count]
  from
  Library.dbo.Students 
  Inner Join Library.dbo.S_Cards
  ON
  Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
  Inner Join Library.dbo.Books
  ON
  Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
 ) 
  as [Students' count]




 select 
*from view_11




--x If you count the total number of books in the library for 100%, then you need to calculate how many books (in percentage terms) each faculty took.


 Select 
 Count(*) as [Count]
 from
 Library.dbo.Faculties
 Inner Join Library.dbo.Groups
 ON
 Library.dbo.Faculties.Id=Library.dbo.Groups.Id_Faculty
 Inner Join Library.dbo.Students
 ON
 Library.dbo.Groups.Id=Library.dbo.Students.Id_Group
 Inner Join Library.dbo.S_Cards
 ON
 Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
 Inner Join Library.dbo.Books
 ON
 Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
 Group by
 Faculties.Id




CREATE OR ALTER VIEW view_12_1
As
SELECT
 (
   Select 
   Count(*) as [Count]
   from
   Library.dbo.Faculties
   Inner Join Library.dbo.Groups
   ON
   Library.dbo.Faculties.Id=Library.dbo.Groups.Id_Faculty
   Inner Join Library.dbo.Students
   ON
   Library.dbo.Groups.Id=Library.dbo.Students.Id_Group
   Inner Join Library.dbo.S_Cards
   ON
   Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
   Inner Join Library.dbo.Books
   ON
   Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
   Group by
   Faculties.Id
   Having Faculties.Id=1
  ) 
  * 100 /
  (
   Select 
   COUNT(*) as [Students' count]
   from
   Library.dbo.Students 
   Inner Join Library.dbo.S_Cards
   ON
   Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
   Inner Join Library.dbo.Books
   ON
   Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
  ) 
   as [Percent1],
  (
   Select 
   Count(*) as [Count]
   from
   Library.dbo.Faculties
   Inner Join Library.dbo.Groups
   ON
   Library.dbo.Faculties.Id=Library.dbo.Groups.Id_Faculty
   Inner Join Library.dbo.Students
   ON
   Library.dbo.Groups.Id=Library.dbo.Students.Id_Group
   Inner Join Library.dbo.S_Cards
   ON
   Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
   Inner Join Library.dbo.Books
   ON
   Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
   Group by
   Faculties.Id
   Having Faculties.Id=2
  ) 
  * 100 /
  (
   Select 
   COUNT(*) as [Students' count]
   from
   Library.dbo.Students 
   Inner Join Library.dbo.S_Cards
   ON
   Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
   Inner Join Library.dbo.Books
   ON
   Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
  ) 
   as [Percent2],
  (
   Select 
   Count(*) as [Count]
   from
   Library.dbo.Faculties
   Inner Join Library.dbo.Groups
   ON
   Library.dbo.Faculties.Id=Library.dbo.Groups.Id_Faculty
   Inner Join Library.dbo.Students
   ON
   Library.dbo.Groups.Id=Library.dbo.Students.Id_Group
   Inner Join Library.dbo.S_Cards
   ON
   Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
   Inner Join Library.dbo.Books
   ON
   Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
   Group by
   Faculties.Id
   Having Faculties.Id=3
  ) 
  * 100 /
  (
   Select 
   COUNT(*) as [Students' count]
   from
   Library.dbo.Students 
   Inner Join Library.dbo.S_Cards
   ON
   Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
   Inner Join Library.dbo.Books
   ON
   Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
  ) 
   as [Percent3]




 select 
*from view_12_1




CREATE OR ALTER VIEW view_12_2
As
(
 select Count(*)*100/
 (
  select Count(*) from Books
  inner join S_Cards
  on S_Cards.Id_Book=Books.Id
  inner join Students
  on Students.Id=S_Cards.Id_Student
  inner join Groups
  on Groups.Id=Students.Id_Group
  inner join Faculties
  on Faculties.Id=Groups.Id_Faculty
  ) as PercentOfBook 
 from Books
 inner join S_Cards
 on S_Cards.Id_Book=Books.Id
 inner join Students
 on Students.Id=S_Cards.Id_Student
 inner join Groups
 on Groups.Id=Students.Id_Group
 inner join Faculties
 on Faculties.Id=Groups.Id_Faculty
 group by Faculties.Id
)




 select 
*from view_12_2




-- Display the most reading faculty and the most reading chair.


CREATE OR ALTER VIEW view_13
As
(
 select Count(*)*100/
 (
  select Count(*) from Books
  inner join S_Cards
  on S_Cards.Id_Book=Books.Id
  inner join Students
  on Students.Id=S_Cards.Id_Student
  inner join Groups
  on Groups.Id=Students.Id_Group
  inner join Faculties
  on Faculties.Id=Groups.Id_Faculty
 ) as [most reading], Faculties.Name
  from 
 Books
 inner join S_Cards
 on S_Cards.Id_Book=Books.Id
 inner join Students
 on Students.Id=S_Cards.Id_Student
 inner join Groups
 on Groups.Id=Students.Id_Group
 inner join Faculties
 on Faculties.Id=Groups.Id_Faculty
 Where Faculties.Id=1
 group by 
 Faculties.Id,
 Faculties.Name
)




 select 
*from view_13




-- Show the author (s) of the most popular books among teachers and students.


CREATE OR ALTER VIEW view_14
As
(
Select Distinct
Top(2)
Library.dbo.Authors.Id,
Library.dbo.Authors.FirstName, 
Library.dbo.Authors.LastName
from
Library.dbo.Teachers 
Inner Join Library.dbo.T_Cards
ON
Library.dbo.Teachers.Id=Library.dbo.T_Cards.Id_Teacher
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.T_Cards.Id_Book
Inner Join Library.dbo.Authors
ON
Library.dbo.Books.Id_Author=Library.dbo.Authors.Id
INTERSECT
Select Distinct
Library.dbo.Authors.Id,
Library.dbo.Authors.FirstName, 
Library.dbo.Authors.LastName
from
Library.dbo.Students 
Inner Join Library.dbo.S_Cards
ON
Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
Inner Join Library.dbo.Authors
ON
Library.dbo.Books.Id_Author=Library.dbo.Authors.Id
)




 select 
*from view_14




-- Display the names of the most popular books among teachers and students


CREATE OR ALTER VIEW view_15
As
(
Select Distinct
Top(2)
Library.dbo.Books.Id,
Library.dbo.Books.Name
from
Library.dbo.Teachers 
Inner Join Library.dbo.T_Cards
ON
Library.dbo.Teachers.Id=Library.dbo.T_Cards.Id_Teacher
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.T_Cards.Id_Book
INTERSECT
Select Distinct
Library.dbo.Books.Id,
Library.dbo.Books.Name
from
Library.dbo.Students 
Inner Join Library.dbo.S_Cards
ON
Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
)




 select 
*from view_15




-- Show all students and teachers of designers.


CREATE OR ALTER VIEW view_16
As
(
Select Distinct
Library.dbo.Teachers.FirstName,
Library.dbo.Teachers.LastName
from
Library.dbo.Teachers 
Inner Join Library.dbo.T_Cards
ON
Library.dbo.Teachers.Id=Library.dbo.T_Cards.Id_Teacher
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.T_Cards.Id_Book
Inner Join Library.dbo.Departments
ON
Library.dbo.Departments.Id=Library.dbo.Teachers.Id_Dep
where Library.dbo.Departments.Name like '%Design%'
UNION
Select Distinct
Library.dbo.Students.FirstName,
Library.dbo.Students.LastName
from
Library.dbo.Students 
Inner Join Library.dbo.S_Cards
ON
Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
Inner Join Library.dbo.Groups
ON
Library.dbo.Groups.Id=Library.dbo.Students.Id_Group
Inner Join Library.dbo.Faculties
ON
Library.dbo.Faculties.Id=Library.dbo.Groups.Id_Faculty
where Library.dbo.Faculties.Name like '%Design%'
)




 select 
*from view_16




--Show all information about students and teachers who have taken books


CREATE OR ALTER VIEW view_17
As
(
Select Distinct
Library.dbo.Teachers.FirstName,
Library.dbo.Teachers.LastName
from
Library.dbo.Teachers 
Inner Join Library.dbo.T_Cards
ON
Library.dbo.Teachers.Id=Library.dbo.T_Cards.Id_Teacher
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.T_Cards.Id_Book
Union ALL
Select Distinct
Library.dbo.Students.FirstName,
Library.dbo.Students.LastName
from
Library.dbo.Students 
Inner Join Library.dbo.S_Cards
ON
Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
)




 select 
*from view_17




-- Show books that were taken by both teachers and students.


CREATE OR ALTER VIEW view_18
As
(
Select Distinct
Library.dbo.Books.Name
from
Library.dbo.Students 
Inner Join Library.dbo.S_Cards
ON
Library.dbo.Students.Id=Library.dbo.S_Cards.Id_Student
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.S_Cards.Id_Book
UNION ALL
Select Distinct
Library.dbo.Books.Name
from
Library.dbo.Teachers 
Inner Join Library.dbo.T_Cards
ON
Library.dbo.Teachers.Id=Library.dbo.T_Cards.Id_Teacher
Inner Join Library.dbo.Books
ON
Library.dbo.Books.Id=Library.dbo.T_Cards.Id_Book
)




 select 
*from view_18




-- Show how many books each librarian issued.


CREATE OR ALTER VIEW view_19
As
(
Select 
Convert(nvarchar(100), COUNT(*)) + ' book give to Students'AS [book count],
Libs.FirstName
from
Library.dbo.Libs 
Inner Join Library.dbo.S_Cards
ON
Library.dbo.Libs.Id=Library.dbo.S_Cards.Id_Lib
Inner Join Library.dbo.Books
ON
Library.dbo.S_Cards.Id_Book=Library.dbo.Books.Id
GROUP BY 
Libs.Id,
Libs.FirstName
Union ALL
Select
Convert(nvarchar(100), COUNT(*)) + ' book give to Teachers' AS [book count] ,
Libs.FirstName
from
Library.dbo.Libs 
Inner Join Library.dbo.T_Cards
ON
Library.dbo.Libs.Id=Library.dbo.T_Cards.Id_Lib
Inner Join Library.dbo.Books
ON
Library.dbo.T_Cards.Id_Book=Library.dbo.Books.Id
Group by 
Libs.Id,
Libs.FirstName
)




 select 
*from view_19