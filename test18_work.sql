#触发器课后练习

CREATE DATABASE dbtest18_trigger

USE dbtest18_trigger

DROP TABLE emps

DROP TABLE emps_back

CREATE TABLE emps
AS
SELECT employee_id,last_name,salary 
FROM atguigudb.`employees`

CREATE TABLE emps_back
AS
SELECT * FROM emps
WHERE 1 = 2;

SELECT * FROM emps_back

DELIMITER // 

CREATE TRIGGER emps_insert_trigger
AFTER INSERT ON emps
FOR EACH ROW
BEGIN
        INSERT INTO emps_back(employee_id,last_name,salary )
        VALUES(new.employee_id,new.last_name,new.salary);
END //

DELIMITER ;

SHOW TRIGGERS

INSERT INTO emps(employee_id,last_name,salary )
VALUES(300,'Tom',3400)


#练习二

CREATE TABLE emps_back1
AS
SELECT * FROM emps
WHERE 1 = 2;

DELIMITER //

CREATE TRIGGER emp_del_trigger
BEFORE DELETE ON emps
FOR EACH ROW
BEGIN
      INSERT INTO emps_back1(employee_id,last_name,salary )
      VALUES(old.employee_id,old.last_name,old.salary);
END //
DELIMITER ;

SELECT * FROM emps

SELECT * FROM emps_back1

DELETE FROM emps
WHERE employee_id = 100



