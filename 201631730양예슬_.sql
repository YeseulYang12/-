CREATE DATABASE ysdb;
USE ysdb;

CREATE TABLE patient(
p_no int(20) NOT NULL auto_increment,
name varchar(20) default NULL,
phone varchar(20) default NULL,
dob DATE default NULL,
p_gender varchar(20) default NULL,
PRIMARY KEY(p_no)
) ENGINE=InnoDB;

INSERT INTO patient VALUES (0, "가사랑", "010-1111-1111", "1990-01-02", "F");
INSERT INTO patient VALUES (0, "나봄", "010-2222-2222", "1992-04-05", "M");
INSERT INTO patient VALUES (0, "다여름", "010-3333-3333", "1996-03-06", "F");
INSERT INTO patient VALUES (0, "라가을", "010-4444-4444", "1999-11-02", "F");
INSERT INTO patient VALUES (0, "마겨울", "010-5555-5555", "1988-09-25", "M");

select * from patient;

CREATE TABLE wearable(
w_no int(20) NOT NULL auto_increment,
EKG varchar(20) default NULL,
BP varchar(20) default NULL,
P int(20) default NULL,
M int(20) default NULL,
p_no int(20),
foreign key(p_no) references patient(p_no) on delete cascade,
PRIMARY KEY(w_no)
) ENGINE=InnoDB;

INSERT INTO wearable VALUES (0, "S", "100/70", 80, 30, 1);
INSERT INTO wearable VALUES (0, "SF", "122/80", 90, 60, 2);
INSERT INTO wearable VALUES (0, "S", "110/70", 75, 30, 3);
INSERT INTO wearable VALUES (0, "S", "120/80", 80, 120, 4);
INSERT INTO wearable VALUES (0, "A", "120/90", 85, 30, 5);

select * from wearable;

CREATE TABLE doctor(
d_no int(20) NOT NULL auto_increment,
d_name varchar(20) default NULL,
email varchar(20) default NULL,
department varchar(20) default NULL,
d_gender varchar(20) default NULL,
PRIMARY KEY(d_no)
) ENGINE=InnoDB;

INSERT INTO doctor VALUES (0, "김해달", "K123@gachon.com", "IM", "F");
INSERT INTO doctor VALUES (0, "이바람", "L123@gachon.com", "CS", "F");
INSERT INTO doctor VALUES (0, "박공기", "P123@gachon.com", "RM", "M");
INSERT INTO doctor VALUES (0, "최산", "C123@gachon.com", "OS", "M");
INSERT INTO doctor VALUES (0, "정바다", "J123@gachon.com", "GS", "F");

select * from doctor;

CREATE TABLE exam(
place varchar(20) default NULL,
e_date DATE,
p_no int(20),
d_no int(20),
foreign key(p_no) references patient(p_no) on delete cascade,
foreign key(d_no) references doctor(d_no) on delete cascade,
PRIMARY KEY(p_no, d_no)
) ENGINE=InnoDB;

INSERT INTO exam VALUES ("hospital", "2021-04-21", 1, 1);
INSERT INTO exam VALUES ("hospital", "2021-03-20", 2, 2);
INSERT INTO exam VALUES ("hospital", "2021-02-18", 3, 3);
INSERT INTO exam VALUES ("hospital", "2021-01-06", 4, 5);
INSERT INTO exam VALUES ("hospital", "2021-02-16", 5, 5);

select * from exam;

CREATE TABLE refer(
w_no int(20),
d_no int(20),
PRIMARY KEY(w_no, d_no)
) ENGINE=InnoDB;

INSERT INTO refer VALUES(1, 1);
INSERT INTO refer VALUES(2,2);
INSERT INTO refer VALUES(3,3);
INSERT INTO refer VALUES(4,5);
INSERT INTO refer VALUES(5,5);

select * from refer;

# 심전도가 S(동리듬)인 환자의 이름과 생년월일, 진료과를 검색하시오.
select patient.name, patient.dob, doctor.department
from patient, wearable, doctor, exam
where patient.p_no=wearable.p_no and patient.p_no=exam.p_no and doctor.d_no=exam.d_no and wearable.EKG='s';


select patient.name, patient.dob, doctor.department, wearable.EKG
from patient, wearable, doctor, exam
where patient.p_no=wearable.p_no and patient.p_no=exam.p_no and doctor.d_no=exam.d_no and wearable.EKG='s';

# 진료과 GS에서 진료받은 환자의 이름과 심전도, 혈압, 맥박수, 운동량을 검색하시오.
select patient.name, wearable.EKG, wearable.BP, wearable.P, wearable.M
from patient, wearable, doctor, refer
where patient.p_no=wearable.p_no and wearable.w_no=refer.w_no and doctor.d_no=refer.d_no and 
doctor.department="GS";


select patient.name, wearable.EKG, wearable.BP, wearable.P, wearable.M, doctor.department
from patient, wearable, doctor, refer
where patient.p_no=wearable.p_no and wearable.w_no=refer.w_no and doctor.d_no=refer.d_no and 
doctor.department="GS";

# 병원에서 진료받은 환자의 이름과 성별, 진료과를 검색하시오.
select patient.name, patient.p_gender, doctor.department
from patient, doctor, exam
where patient.p_no=exam.p_no and doctor.d_no=exam.d_no and exam.place='hospital';


select patient.name, patient.p_gender, doctor.department, exam.place
from patient, doctor, exam
where patient.p_no=exam.p_no and doctor.d_no=exam.d_no and exam.place='hospital';

