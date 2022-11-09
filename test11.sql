# 1、创建数据库test01_library 
CREATE DATABASE IF NOT EXISTS test02_library CHARACTER SET 'utf8'
# 2、创建表 books，表结构如下：
CREATE TABLE books(
id INT,
`name` VARCHAR(50),
`authors` VARCHAR(100),
price FLOAT,
pubdate YEAR,
note VARCHAR(100),
num INT

);
# 3、向books表中插入记录
# 1）不指定字段名称，插入第一条记录 
INSERT INTO books
VALUES
(1,'Tal of AAA','Dickes',23,'1995','novel',11);
# 2）指定所有字段名称，插入第二记录 
INSERT INTO books(id,NAME,AUTHORS,price,pubdate,note,num)
VALUES
(2,'EmmaT','Jane lura',35,'1993','joke',22)
# 3）同时插入多条记录（剩下的所有记录）
INSERT INTO books(id,NAME,AUTHORS,price,pubdate,note,num)
VALUES
(3,'Story of Jane','Jane Tim',40,'2001','novel',0),
#(4 ,'Lovey Day George','Byron',20,'2005','novel',30),
(5,'Old land','Honore Blade',30,'2010','law',0);
#(6,'The Battle','Upton Sara',30,'1999','medicine',40),
#(7,'Rose Hood','Richard haggard',28,'2008','cartoon',28);

# 4、将小说类型(novel)的书的价格都增加5。
UPDATE books
SET price = price + 5
WHERE note = 'novel'
# 5、将名称为EmmaT的书的价格改为40，并将说明改为drama。
UPDATE books
SET price = 40,note = 'drama'
WHERE NAME = 'EmmaT'
# 6、删除库存为0的记录。
DELETE FROM books
WHERE num = 0
# 7、统计书名中包含a字母的书
SELECT *
FROM books
WHERE NAME LIKE '%a%'
# 8、统计书名中包含a字母的书的数量和库存总量
SELECT COUNT(*),SUM(num)
FROM books
WHERE NAME LIKE '%a%'
# 10、查询图书信息，按照库存量降序排列，如果库存量相同的按照note升序排列
SELECT *
FROM books
ORDER BY num DESC,note ASC
# 12、按照note分类统计书的库存量，显示库存量超过30本的
SELECT note,SUM(num)
FROM books
GROUP BY note
HAVING SUM(num) > 30
# 13、查询所有图书，每页显示5本，显示第二页
SELECT *
FROM books
LIMIT 5,5
# 15、查询书名达到10个字符的书，不包括里面的空格
SELECT NAME
FROM books
WHERE CHAR_LENGTH(REPLACE(NAME,' ','')) >= 10

