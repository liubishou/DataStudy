#15

CREATE DATABASE dbtest16

USE dbtest16


CREATE TABLE employees
AS
SELECT *
FROM atguigudb.`employees`

CREATE TABLE departments
AS
SELECT *
FROM atguigudb.`departments`

#1.创建存储过程
DELIMITER $

CREATE PROCEDURE select_all_data()
BEGIN
     SELECT * FROM employees;
END $
DELIMITER ;

#2.存储过程的调用

CALL select_all_data();

#举例2
DELIMITER //

CREATE PROCEDURE avg_employee_salary()
BEGIN
      SELECT AVG(salary) FROM employees;


END //
DELIMITER ;
CALL avg_employee_salary()
#举例3

DELIMITER //
CREATE PROCEDURE show_max_salary()
BEGIN
      SELECT MAX(salary)
      FROM employees;
END //
DELIMITER ;

CALL show_max_salary()

#类型2 带OUT

DELIMITER //

CREATE PROCEDURE show_min_salary(OUT ms DOUBLE)
BEGIN
      SELECT MIN(salary) INTO ms
      FROM employees;
END //

DELIMITER ;

CALL show_min_salary(@ms)

SELECT @ms

DELIMITER //
#类型3 带in
CREATE PROCEDURE show_someone_salary(IN empname VARCHAR(20))
BEGIN
      SELECT salary
      FROM employees
      WHERE last_name = empname;
     
END //

DELIMITER ;

CALL show_someone_salary('Abel')

SET @empname = 'Abel';
CALL show_someone_salary(@empname);
#练习4 带in和带out
DELIMITER //
CREATE PROCEDURE show_someone_salary2(IN empname VARCHAR(20),OUT empsalary DOUBLE)
BEGIN
      SELECT salary INTO empsalary
      FROM employees
      WHERE last_name = empname;
END //

DELIMITER ;

SET @empname = 'Abel';

CALL show_someone_salary2(@empname,@empsalary);

 SELECT @empsalary
 #类型5 带inout
DELIMITER //
CREATE PROCEDURE show_mgr_name2(INOUT empname VARCHAR(25))
 BEGIN
      SELECT last_name INTO empname
      FROM employees
      WHERE employee_id = (  SELECT manager_id
      FROM employees
      WHERE last_name = empname);
    
END //
 
 
DELIMITER ;
SET @empname = 'Abel';
CALL show_mgr_name2(@empname);
SELECT @empname;