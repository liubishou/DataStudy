SELECT @@innodb_default_row_format

CREATE TABLE mytest(
col1 VARCHAR(10),
col2 VARCHAR(10),
col3 CHAR(10),
col4 VARCHAR(10)
)ENGINE = INNODB CHARSET = LATIN1 ROW_FORMAT = COMPACT

CREATE DATABASE dbtest20

USE dbtest20
#隐式的创建索引（通过创建表系统自动创建索引）
CREATE TABLE dept(
dept_id INT PRIMARY KEY AUTO_INCREMENT,#自增列
emp_name VARCHAR(20)
);

CREATE TABLE emp(
emp_id INT PRIMARY KEY AUTO_INCREMENT,
emp_name VARCHAR(20) UNIQUE,
dept_id INT,
CONSTRAINT emp_dept_id_fk FOREIGN KEY(dept_id) REFERENCES dept(dept_id)
);
#显示创建索引
CREATE TABLE book(
book_id INT,
book_name VARCHAR(100),
AUTHORS VARCHAR(100),
info VARCHAR(100),
COMMENT VARCHAR(100),
year_publication YEAR,
#申明索引
INDEX idx_bname(book_name)
);

#通过命令查看索引
SHOW CREATE TABLE book

EXPLAIN SELECT * FROM book WHERE book_name = 'mysql高级'

#创建唯一性索引
#申明唯一性索引的字段，在添加数据时，要保证唯一性，但是可以添加null
CREATE TABLE book1(
book_id INT,
book_name VARCHAR(100),
AUTHORS VARCHAR(100),
info VARCHAR(100),
COMMENT VARCHAR(100),
year_publication YEAR,
#申明索引
UNIQUE INDEX uk_idx_cmt(COMMENT)
);

#创建主键索引
#通过创建主键的方式来创建主键索引
CREATE TABLE book2(
book_id INT PRIMARY KEY AUTO_INCREMENT,
book_name VARCHAR(100),
AUTHORS VARCHAR(100),
info VARCHAR(100),
COMMENT VARCHAR(100),
year_publication YEAR
);
#通过删除主键约束的方式删除主键索引

#创建单列索引
CREATE TABLE book3(
book_id INT,
book_name VARCHAR(100),
AUTHORS VARCHAR(100),
info VARCHAR(100),
COMMENT VARCHAR(100),
year_publication YEAR,
#申明索引
UNIQUE INDEX idx_bname(book_name)
);

SHOW INDEX FROM book3
#创建联合索引
CREATE TABLE book4(
book_id INT,
book_name VARCHAR(100),
AUTHORS VARCHAR(100),
info VARCHAR(100),
COMMENT VARCHAR(100),
year_publication YEAR,
#申明索引
INDEX mul_bid_bname_info(book_id,book_name,info)
);

SHOW INDEX FROM book4
#最左前缀原则
EXPLAIN SELECT * FROM book4 WHERE book_id = 101 AND book_name = 'mysql高级'
#当查询有索引中放在最左边的那个时，联合索引会使用

#创建全文索引
CREATE TABLE book1(
book_id INT,
book_name VARCHAR(100),
AUTHORS VARCHAR(100),
info VARCHAR(100),
COMMENT VARCHAR(100),
year_publication YEAR,
#申明索引
FULLTEXT INDEX uk_idx_cmt(COMMENT)
);

#方法二.在创建表以后在添加索引
#①alter table .. add index ....
CREATE TABLE book5(
book_id INT,
book_name VARCHAR(100),
AUTHORS VARCHAR(100),
info VARCHAR(100),
COMMENT VARCHAR(100),
year_publication YEAR

);

ALTER TABLE book5 ADD INDEX idx_cmt(COMMENT)

ALTER TABLE book5 ADD INDEX mul_id_name_info(book_id,book_name,info)

#②create index .... on .... 
CREATE TABLE book6(
book_id INT,
book_name VARCHAR(100),
AUTHORS VARCHAR(100),
info VARCHAR(100),
COMMENT VARCHAR(100),
year_publication YEAR

);

CREATE INDEX idx_cmt ON book6(COMMENT)

#删除索引

#①alter table ... drop index ..
ALTER TABLE book6
DROP INDEX idx_cmt

SHOW INDEX FROM book6
#添加auto_increment的字段唯一索引不能删除
#删除联合索引的其中一个字段，索引自动改变
ALTER TABLE book5
DROP COLUMN book_id

SHOW INDEX FROM book5
#隐藏索引
CREATE TABLE book7(
book_id INT,
book_name VARCHAR(100),
AUTHORS VARCHAR(100),
info VARCHAR(100),
COMMENT VARCHAR(100),
year_publication YEAR,
#创建不可见索引
INDEX idx_cmt(COMMENT) invisible
);

SHOW INDEX FROM book7

#修改索引可见性

ALTER TABLE book7
ALTER INDEX idx_cmt visible;


