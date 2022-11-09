/*在MySQL数据库的存储过程和函数中，可以使用变量来存储查询或计算的中间结果数据，或者输出最终
的结果数据。
在 MySQL 数据库中，变量分为 系统变量 （全局系统变量 、 会话系统变量）以及 用户自定义变量*/

#查看系统变量

SHOW GLOBAL VARIABLES;#查询全局系统变量

SHOW SESSION variables；#查询会话系统变量

SHOW VARIABLES;#默认查询的会话系统变量
#查询部分系统变量

SHOW GLOBAL VARIABLES LIKE 'admin_%'

SHOW VARIABLES LIKE 'character_%'

#查看指定的系统变量

SELECT @@global.max_connections

SELECT @@session.character_set_client

SELECT @@session.pseudo_thread_id

SELECT @@character_set_client； #先查询会话系统变量，再查询全局系统变量

#修改系统变量
#全局系统变量

#方式1
SET @@global.max_connections = 161
#方式2
SET GLOBAL max_connections = 171

#只针对当前数据库实例有效，一旦重启mysql服务，就失效了

#会话系统变量
#只针对当前会话，一旦新建会话，则修改无效


#用户变量

/*用户变量是用户自己定义的，作为 MySQL 编码规范，MySQL 中的用户变量以 一个“@” 开头。根据作用
范围不同，又分为 会话用户变量 和 局部变量 。
会话用户变量：作用域和会话变量一样，只对 当前连接 会话有效。
局部变量：只在 BEGIN 和 END 语句块中有效。局部变量只能在 存储过程和函数 中使用。*/

#会话用户变量

CREATE DATABASE dbtest17

USE dbtest17

CREATE TABLE employees
AS
SELECT * FROM atguigudb.`employees`

CREATE TABLE departments
AS
SELECT * FROM atguigudb.`departments`

SET @m1 = 1;
SET @m2 = 2;
SET @sum = @m1 + @m2;

SELECT @sum;

SELECT @count := COUNT(*) FROM employees

SELECT @count

SELECT AVG(salary) INTO @avg_sal FROM employees

SELECT @avg_sal

#局部变量

DELIMITER //

CREATE PROCEDURE test_var()
BEGIN
      DECLARE a INT DEFAULT 1;
      DECLARE b INT;
      DECLARE emp_name VARCHAR(25);
      
      SET a = 2;
      SET b = 3;
      SELECT last_name INTO emp_name FROM employees WHERE employee_id = 101;
      
      SELECT a,b,emp_name;
END //
DELIMITER ;

CALL test_var();

DELIMITER //

CREATE PROCEDURE add_val()
BEGIN
        DECLARE val1,val2,val3 INT;
        SET val1 = 10;
        SET val2 = 100;
        SET val3 = val1 + val2;
        
        SELECT val3;
END //
DELIMITER ;

CALL add_val();

DELIMITER //

CREATE PROCEDURE different_salary3(IN emp_id INT,OUT dif_salary DOUBLE)
BEGIN
        DECLARE emp_sal DOUBLE;
        DECLARE mgr_id INT;
        DECLARE mgr_salary DOUBLE;
        DECLARE dif_sal DOUBLE;
        
        
        SELECT salary INTO emp_sal FROM employees WHERE employee_id = emp_id;
        SELECT manager_id INTO mgr_id FROM employees WHERE employee_id = emp_id;
        SELECT salary INTO mgr_salary FROM employees WHERE employee_id = mgr_id;
        SET dif_salary = mgr_salary - emp_sal;
        
       
END //
DELIMITER ;
SET @emp_id = 103;
CALL different_salary3(@emp_id,@dif_sal);
SELECT @dif_sal;
#2. 定义条件与处理程序

#一.定义条件：DECLARE 错误名称CONDITION FOR 错误码（或错误条件)
/*
  错误码说明：
  MySQL_error_code 和 sqlstate_value 都可以表示MySQL的错误。
    MySQL_error_code是数值类型错误代码。
    sqlstate_value是长度为5的字符串类型错误代码。

*/
#方式1
DECLARE Filed_Not_Be_Null CONDITION FOR 1048;
#方式2
DECLARE Filed_Not_Be_Null CONDITION FOR SQLSTATE '23000';

#定义处理程序：DECLARE 处理方式 HANDLER FOR 错误类型 处理语句
/*处理方式：处理方式有3个取值：CONTINUE、EXIT、UNDO。
   CONTINUE ：表示遇到错误不处理，继续执行。
   EXIT ：表示遇到错误马上退出。
   UNDO ：表示遇到错误后撤回之前的操作。MySQL中暂时不支持这样的操作。
*/
/* 错误类型
   /**SQLSTATE '字符串错误码' ：表示长度为5的sqlstate_value类型的错误代码；
   MySQL_error_code ：匹配数值类型错误代码；
   错误名称 ：表示DECLARE ... CONDITION定义的错误条件名称。**/
   /**SQLWARNING ：匹配所有以01开头的SQLSTATE错误代码；
   NOT FOUND ：匹配所有以02开头的SQLSTATE错误代码；
   SQLEXCEPTION ：匹配所有没有被SQLWARNING或NOT FOUND捕获的SQLSTATE错误代码；*/
   DECLARE CONTINUE FOR 1048 SET @a1 = 1;
   
#流程控制
#1.if分支语句
DELIMITER //

CREATE PROCEDURE test_if()
BEGIN
       #情况1：
       #declare status_name varchar(15);
       
       #if status_name is null
         #then select 'name is null';
       #end if;
       #情况2
       #declare email varchar(20) default 'aaa';
       #if email is null
           #then select 'email is null';
       #else 
           #select 'email is not null';
       #end if;
       #情况3
       DECLARE id INT;
       IF id IS NULL
         THEN SELECT 'id is null';
       ELSEIF id  = 20
         THEN SELECT 'id是20号'；
       ELSEIF id = 40
         THEN SELECT 'id是40号'；
       END if；
END //

DELIMITER ;
DROP PROCEDURE test_if;
CALL test_if()
   
