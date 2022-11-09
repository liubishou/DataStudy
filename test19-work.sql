#第18章课后练习

CREATE DATABASE test19_work

USE test19_work

CREATE TABLE students( 
id INT PRIMARY KEY AUTO_INCREMENT, 
student VARCHAR(15), points TINYINT 
);
#2. 向表中添加数据如下 
INSERT INTO students(student,points) 
VALUES ('张三',89), ('李四',77), ('王五',88), ('赵六',90), ('孙七',90), ('周八',88);

#排序

SELECT ROW_NUMBER() over (ORDER BY points DESC) AS '排序1',
RANK() over (ORDER BY points DESC) AS '排序2',
DENSE_RANK() over (ORDER BY points DESC) AS '排序3',
id,student,points
FROM students

#方式2
SELECT ROW_NUMBER() over w AS '排序1',
RANK() over w AS '排序2',
DENSE_RANK() over w AS '排序3',
id,student,points
FROM students Window w AS (ORDER BY points DESC);