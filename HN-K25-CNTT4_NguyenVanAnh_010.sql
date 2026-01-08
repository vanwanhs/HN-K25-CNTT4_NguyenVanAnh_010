
drop database if exists Hackathon;
create database Hackathon;
use hackathon;
-- Phần 1: Tạo Bảng
create table Department (
    dept_id varchar(5) primary key,
    dept_name varchar(100) not null unique,
    location varchar(100) not null,
    manager_name varchar(100) not null
);

create table Employee (
    emp_id varchar(5) primary key,
    emp_name varchar(50) not null,
    dob date not null,
    email varchar(100) not null unique,
    phone varchar(15) not null unique,
    dept_id varchar(5) not null,
    foreign key (dept_id) references Department(dept_id)
);

create table Project (
    project_id varchar(5) primary key,
    project_name varchar(50) not null unique,
    start_date date not null,
    end_date date not null,
    budget decimal(10,2) not null
);
create table Assignment (
    assignment_id int auto_increment primary key,
    emp_id varchar(5) not null,
    project_id varchar(5) not null,
    role varchar(50) not null,
    hours_worked int not null,
    foreign key (emp_id) references Employee(emp_id),
    foreign key (project_id) references Project(project_id)
);

-- 2 chèn dữ liệu
insert into department values
('d01','it','floor 5','nguyen van an'),
('d02','hr','floor 2','tran thi binh'),
('d03','sales','floor 1','le van cuong'),
('d04','marketing','floor 3','pham thi duong'),
('d05','finance','floor 4','hoang van tu');

insert into Employee values
('e001','nguyen van tuan','1990-01-01','tuan@mail.com','0901234567','d01'),
('e002','tran thi lan','1995-05-05','lan@mail.com','0902345678','d02'),
('e003','le minh khoi','1992-10-10','khoi@mail.com','0903456789','d01'),
('e004','pham hoang nam','1998-12-12','nam@mail.com','0904567890','d03'),
('e005','vu minh ha','1996-07-07','ha@mail.com','0905678901','d01');

insert into Poject values
('p001','website redesign','2025-01-01','2025-06-01',50000.00),
('p002','mobile app dev','2025-02-01','2025-08-01',80000.00),
('p003','hr system','2025-03-01','2025-09-01',30000.00),
('p004','marketing campaign','2025-04-01','2025-05-01',10000.00),
('p005','ai research','2025-05-01','2025-12-31',100000.00);

insert into Assignment (emp_id, project_id, role, hours_worked) values
('e001','p001','developer',150),
('e003','p001','tester',100),
('e001','p002','tech lead',200),
('e005','p005','data scientist',180),
('e004','p004','content creator',50);

-- Phần 2

-- câu 3
update Department
set location = 'floor 10'
where dept_id = 'C001';

-- câu 4
update Project set  budget = budget * 1.1, end_date = date_add(end_date, interval 1 month)
where project_id = 'P005';

-- câu 5
delete from Assignment
where hours_worked = 0 or role = 'Intern';

-- câu 6
select emp_id, emp_name, email from Employee
where dept_id = 'D01';

-- câu 7
select project_name, start_date, budget from Project
where project_name = '%System%';

-- cau 8
select project_id, project_name, budget from project
order by budget desc;

-- cau 9
select emp_id, emp_name, dob from Employee
order by dob asc
limit 3;

-- caua 10
select project_id, project_name from Project
limit 3 offset 1;

-- Phần 3

-- câu 11
select a.assignment_id,e.emp_name,p.project_name,a.role from Assignment a
join employee e on a.emp_id = e.emp_id
join Project p on a.project_id = p.project_id
where a.hours_worked > 100;

-- cau 12:
select d.dept_id, d.dept_name, e.emp_name from Department d
left join employee e on d.dept_id = e.dept_id;

-- cau 13:
select p.project_name, sum(a.hours_worked) as total_hours from Project p
join assignment a on p.project_id = a.project_id
group by p.project_name;

-- câu 14
select d.dept_name, count(e.emp_id) as employee_count
from department d
	join employee e on d.dept_id = e.dept_id
	group by d.dept_name
	having count(e.emp_id) >= 2;

-- câu 15
select distinct e.emp_name, e.email from Employee e
	join Assignment a on e.emp_id = a.emp_id
	join project p on a.project_id = p.project_id
where p.budget > 50000;

-- cau 16
-- select e.emp_name, a.role from employee e
-- 	join Assignment a on e.emp_id = a.emp_id
-- 	join Project p on a.project_id = p.project_id
-- 	join 

-- câu 17
select e.emp_id, e.emp_name, d.dept_name, p.project_name, a.hours_worked from Assignment a
	join Employee e on a.emp_id = e.emp_id
	join Project p on a.project_id = p.project_id
	join department d on e.dept_id = d.dept_id;
