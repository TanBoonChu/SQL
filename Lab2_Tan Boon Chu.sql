CREATE DATABASE practise;
use practise;
CREATE TABLE student (Id int NOT NULL, name text NOT NULL,
	CONSTRAINT PK_student PRIMARY KEY (Id));
CREATE TABLE term_gpa (Id int NOT NULL, term int NOT NULL, 
	gpa decimal(3, 2) NOT NULL, 
    CONSTRAINT PK_term_gpa PRIMARY KEY (Id, term), 
    CONSTRAINT FK_term_gpa FOREIGN KEY (Id) REFERENCES student(Id));
CREATE TABLE degree (Id int NOT NULL, term int NOT NULL, 
	degree char(5) NOT NULL, 
    CONSTRAINT PK_degree PRIMARY KEY (Id, term, degree), 
    CONSTRAINT FK_degree_student FOREIGN KEY (Id) REFERENCES student(Id),
    CONSTRAINT FK_degree_term_gpa FOREIGN KEY (Id, term) REFERENCES term_gpa(Id, term));
INSERT INTO student 
VALUES (1, 'William'), (2, 'Kate'), (3, 'Hisham'),
	(4, 'Ahmad'), (5, 'Hussien');
SELECT * FROM student;
INSERT INTO term_gpa 
VALUES (1, 2011, 3.32), (1, 2012, 3.51), (2, 2011, 2.22),
	(2, 2013, 1.70), (3, 2011, 3.70), (4, 2011, 3.10),
    (4, 2012, 3.21), (4, 2013, 3.30), (5, 2013, 2.99);
SELECT * FROM term_gpa;
INSERT INTO degree
VALUES (1, 2012, 'Econ'), (3, 2011, 'Math'), 
	(3, 2011, 'Comp'), (4, 2012, 'Eng');
SELECT * FROM degree;

# Q3
SELECT student.Id, student.name, term_gpa.gpa
FROM student
JOIN term_gpa ON student.Id = term_gpa.Id
WHERE term_gpa.Id = 1;

# Q4
SELECT degree.Id, student.name, term_gpa.gpa
FROM degree
JOIN term_gpa ON degree.Id = term_gpa.Id AND degree.term = term_gpa.term 
JOIN student ON degree.Id = student.Id
GROUP BY degree;

# Q5
SELECT student.Id, student.name, term_gpa.gpa, IFNULL(degree.degree, '') AS degree
FROM term_gpa
JOIN student ON term_gpa.Id = student.Id 
LEFT JOIN degree ON term_gpa.term = degree.term AND term_gpa.Id = degree.Id;

# Q6
SELECT student.Id, student.name, ROUND(avg(term_gpa.gpa),2) AS gpa
FROM term_gpa
JOIN student ON term_gpa.Id = student.Id 
LEFT JOIN degree ON term_gpa.term = degree.term AND term_gpa.Id = degree.Id
WHERE degree.degree is NULL
Group by Id;

# Q7
SELECT term_gpa.Id, student.name, 
CASE WHEN avg(term_gpa.gpa) >= 3.5 THEN 2
WHEN avg(term_gpa.gpa) < 3.0 THEN 0
Else 1
END AS 'Gpa_type'
FROM student
JOIN term_gpa ON student.Id = term_gpa.Id
Group by Id;