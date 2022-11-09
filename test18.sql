#第17章 触发器

/*1.触发器概述
触发器是由 事件来触发 某个操作，这些事件包括 INSERT 、 UPDATE 、 DELETE 事件。所谓事件就是指
用户的动作或者触发某项行为。如果定义了触发程序，当数据库执行这些语句时候，就相当于事件发生
了，就会 自动 激发触发器执行相应的操作。

当对数据表中的数据执行插入、更新和删除操作，需要自动执行一些数据库逻辑时，可以使用触发器来
实现。
*/
/*2.触发器语法
CREATE TRIGGER 触发器名称 
{BEFORE|AFTER} {INSERT|UPDATE|DELETE} ON 表名 
FOR EACH ROW 
触发器执行的语句块;*/
CREATE DATABASE dbtest18

USE dbtest18

CREATE TABLE test_trigger ( 
id INT PRIMARY KEY AUTO_INCREMENT, 
t_note VARCHAR(30) 
);

CREATE TABLE test_trigger_log ( 
id INT PRIMARY KEY AUTO_INCREMENT, 
t_log VARCHAR(30) 
);

#2、创建触发器：创建名称为before_insert_test_tri的触发器，向test_trigger数据表插入数据之前，向
#test_trigger_log数据表中插入before_insert的日志信息

DELIMITER //

CREATE TRIGGER before_insert_test_tri
BEFORE INSERT ON test_trigger
FOR EACH ROW
BEGIN
      INSERT INTO test_trigger_log(t_log)
      VALUES('before insert....');
END //

DELIMITER ;

#测试
INSERT INTO test_trigger(t_note)
VALUES('Tom...')

SELECT * FROM test_trigger;
SELECT * FROM test_trigger_log;

#举例2：创建名称为after_insert的触发器，向test_trigger数据表插入数据之后，向test_trigger_log数据表中插
#入after_insert的日志信息。

DELIMITER //

CREATE TRIGGER after_insert
AFTER INSERT ON test_trigger
FOR EACH ROW
BEGIN
       INSERT INTO test_trigger_log(t_log)
       VALUES('James.....');
END //
DELIMITER ;

DROP TRIGGER after_insert

INSERT INTO test_trigger(t_note)
VALUES('Kobe...');

SELECT *
FROM test_trigger;

SELECT *
FROM test_trigger_log;

#举例3：定义触发器“salary_check_trigger”，基于员工表“employees”的INSERT事件，在INSERT之前检查
#将要添加的新员工薪资是否大于他领导的薪资，如果大于领导薪资，则报sqlstate_value为'HY000'的错
#误，从而使得添加失败。

CREATE TABLE employees
AS
SELECT * FROM atguigudb.`employees`;

CREATE TABLE departments
AS
SELECT * FROM atguigudb.`departments`;

#创建触发器
DELIMITER //

CREATE TRIGGER salary_check_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
      DECLARE mgr_sal DOUBLE;
      
      SELECT salary INTO mgr_sal
      WHERE employee_id = new.manager_id;
      
      IF new.salary > mgr_sal
               THEN SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = '薪资高于领导薪资错误';
               END IF;
END //

DELIMITER ;
#上面触发器声明过程中的NEW关键字代表INSERT添加语句的新记录。


#二.查看触发器

#方式1：查看当前数据库的所有触发器的定义
SHOW TRIGGERS;
#方式2：查看当前数据库中某个触发器的定义
SHOW CREATE TRIGGER salary_check_trigger
#方式3：从系统库information_schema的TRIGGERS表中查询“salary_check_trigger”触发器的信息。
SELECT * FROM information_schema.`TRIGGERS`

#删除触发器
 
DROP TRIGGER IF EXISTS after_insert

#触发器优缺点

/*优点
     1.1、触发器可以确保数据的完整性。
     2.触发器可以帮助我们记录操作日志。
     3.触发器还可以用在操作数据前，对数据进行合法性检查。
*/

/*缺点
   1.触发器最大的一个问题就是可读性差。
   2、相关数据的变更，可能会导致触发器出错。
*/
