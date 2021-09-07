Create table course (
course_ID varchar(8) primary key,
course_name varchar(80),
credits tinyint
);

 
Create table prof (
staff_ID int primary key,
last_name varchar(80),
first_name varchar(80),
userName varchar(20),
password varchar(10)
);

Create table prof_phone (
staff_ID int references prof(staff_ID),
phone_number int unique,
primary key (staff_ID, phone_number)
);

Create table prerequisite (
main_course_ID varchar(8) references course(course_ID),
prereq_course_ID varchar(8) references course(course_ID),
primary key (main_course_ID, prereq_course_ID)
);

/* offering must be created before those tables that references (course_ID,offering_no)*/
Create table offering (
course_ID varchar(8) references course(course_ID),
offering_no int,
YearSemester varchar(10),
classroom int,
no_of_stds int,
staff_ID int NOT NULL references prof(staff_ID),
primary key (course_ID, offering_no)
);

Create table prof_teach (
staff_ID int references prof(staff_ID),
course_ID  varchar(8),
offering_no int,
foreign key (course_ID,offering_no) references offering(course_ID,offering_no),
primary key (staff_ID, course_ID,offering_no)
);


/* TA must be created before those tables that references (student_ID)*/

Create table TA (
student_ID  int  primary key,
last_name varchar(80),
first_name varchar(80),
phone int,
course_ID varchar(8) NOT NULL,
offering_no int NOT NULL,
      foreign key (course_ID,offering_no) references offering(course_ID,offering_no)
);
 
Create table pref_TA (
staff_ID int references prof(staff_ID),
student_ID int references TA(student_ID),
primary key (staff_ID, student_ID)
);

Create table supervise (
staff_ID int references prof(staff_ID),
student_ID int references TA(student_ID),
primary key (staff_ID, student_ID)
);

Create table pref_offering (
student_ID int references TA(student_ID),
course_ID varchar(8),
offering_no int,
foreign key (course_ID,offering_no) references offering(course_ID,offering_no), 
primary key (student_ID, course_ID, offering_no)
);


