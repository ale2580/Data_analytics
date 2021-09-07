
/* 
	  1) Display course_ID, course_name, offering_no, classroom, 
      number of students and professor's name for a course that is being taught during the Spring 2021 semster.
*/

SELECT course_ID, course_name, offering_no, classroom, no_of_stds,YearSemester, first_name, last_name
FROM
(SELECT C.course_ID, course_name, offering_no, classroom, no_of_stds,staff_ID, YearSemester
FROM course C join offering O on C.course_ID = O.course_ID) as O join prof P on O.staff_ID = P.staff_ID
WHERE YearSemester = 'Spring2021'

------------------------------------------------------------------------------------------------------------
/*
	2) Display the prerequisites for each course
*/

SELECT C.course_ID, STRING_AGG (prereq_course_ID, ',') as prerequisites
from course C left join prerequisite P on C.course_ID = P.main_course_ID
GROUP BY C.course_ID

------------------------------------------------------------------------------------------------------------
/*
--3) Supervising information of all professors
-- prof id, last name, first name, list of students that are being supervised by a given professor, number or students supervised
*/
select prof.staff_ID, prof.first_name,prof.last_name, STRING_AGG(CONCAT(TA.last_name,' ',TA.first_name),', ') as supervised_students , count(prof.staff_ID) as 'no_of_stds_supervised'
from (supervise S join TA on S.student_ID = TA.student_ID) join prof on prof.staff_ID = S.staff_ID
GROUP BY prof.staff_ID,prof.first_name,prof.last_name

-------------------------------------------------------------------------------------------------------------

--4) Let's check the offering preference information of all the TAs for offerings of all the semesters

select TA.student_ID, TA.last_name, TA.first_name, STRING_AGG(CONCAT('(',PO.course_ID,', ', PO.offering_no,')'),', ') as '(Course_ID, Course_offering)'
from pref_offering PO join TA on PO.student_ID = TA.student_ID
group by TA.student_ID, TA.last_name, TA.first_name

-------------------------------------------------------------------------------------------------------------
--5) Which of the two-thousand level courses has the greatest number of students?

Select course_ID,no_of_stds
From (SELECT no_of_stds ,course_ID, ROW_NUMBER() OVER (ORDER BY no_of_stds desc) AS row_num
from offering ) as T1
where course_ID LIKE 'Comp2%' and row_num = 1
order by no_of_stds DESC

---------------------------------------------------------------------------------------------------------------
