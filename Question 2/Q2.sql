--CÂU 1:
CREATE DATABASE RestaurantManagement
GO
USE RestaurantManagement
GO

--CÂU 2:
if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BILL') and o.name = 'FK_BILL_PAY_CUSTOMER')
alter table BILL
   drop constraint FK_BILL_PAY_CUSTOMER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DISH') and o.name = 'FK_DISH_HAVE_CATEGORY')
alter table DISH
   drop constraint FK_DISH_HAVE_CATEGORY
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DISH') and o.name = 'FK_DISH_ODER_CUSTOMER')
alter table DISH
   drop constraint FK_DISH_ODER_CUSTOMER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DRINK') and o.name = 'FK_DRINK_HAVE_TO_CATEGORY')
alter table DRINK
   drop constraint FK_DRINK_HAVE_TO_CATEGORY
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DRINK') and o.name = 'FK_DRINK_ODER_TO_CUSTOMER')
alter table DRINK
   drop constraint FK_DRINK_ODER_TO_CUSTOMER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DRINK') and o.name = 'FK_DRINK_PRODUCED_MANUFACT')
alter table DRINK
   drop constraint FK_DRINK_PRODUCED_MANUFACT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BILL')
            and   name  = 'PAY_FK'
            and   indid > 0
            and   indid < 255)
   drop index BILL.PAY_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BILL')
            and   type = 'U')
   drop table BILL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CATEGORY_DISH')
            and   type = 'U')
   drop table CATEGORY_DISH
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CATEGORY_DRINK')
            and   type = 'U')
   drop table CATEGORY_DRINK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CUSTOMER')
            and   type = 'U')
   drop table CUSTOMER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DISH')
            and   name  = 'ODER_FK'
            and   indid > 0
            and   indid < 255)
   drop index DISH.ODER_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DISH')
            and   name  = 'HAVE_FK'
            and   indid > 0
            and   indid < 255)
   drop index DISH.HAVE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DISH')
            and   type = 'U')
   drop table DISH
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DRINK')
            and   name  = 'ODER_TO_FK'
            and   indid > 0
            and   indid < 255)
   drop index DRINK.ODER_TO_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DRINK')
            and   name  = 'PRODUCED_FK'
            and   indid > 0
            and   indid < 255)
   drop index DRINK.PRODUCED_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DRINK')
            and   name  = 'HAVE_TO_FK'
            and   indid > 0
            and   indid < 255)
   drop index DRINK.HAVE_TO_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DRINK')
            and   type = 'U')
   drop table DRINK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MANUFACTURER')
            and   type = 'U')
   drop table MANUFACTURER
go

/*==============================================================*/
/* Table: BILL                                                  */
/*==============================================================*/
create table BILL (
   CODE_BILL            varchar(10)          not null,
   CODE_CUSTOMER        varchar(10)          not null,
   DATE_ISSUANCE        datetime             null,
   PRICE                decimal              null,
   constraint PK_BILL primary key (CODE_BILL)
)
go

/*==============================================================*/
/* Index: PAY_FK                                                */
/*==============================================================*/




create nonclustered index PAY_FK on BILL (CODE_CUSTOMER ASC)
go

/*==============================================================*/
/* Table: CATEGORY_DISH                                         */
/*==============================================================*/
create table CATEGORY_DISH (
   CODE_CATEGORY_DISH   varchar(10)          not null,
   NAME                 varchar(150)         null,
   LOWEST_PRICE         decimal              null,
   HIGHEST_PRICE        decimal              null,
   constraint PK_CATEGORY_DISH primary key (CODE_CATEGORY_DISH)
)
go

/*==============================================================*/
/* Table: CATEGORY_DRINK                                        */
/*==============================================================*/
create table CATEGORY_DRINK (
   CODE_CATEGORY_DRINK  varchar(10)          not null,
   NAME                 varchar(150)         null,
   LOWEST_PRICE         decimal              null,
   HIGHEST_PRICE        decimal              null,
   constraint PK_CATEGORY_DRINK primary key (CODE_CATEGORY_DRINK)
)
go

/*==============================================================*/
/* Table: CUSTOMER                                              */
/*==============================================================*/
create table CUSTOMER (
   CODE_CUSTOMER        varchar(10)          not null,
   ID_NUMBER            numeric              null,
   FULL_NAME            varchar(150)         null,
   ADDRESS              varchar(150)         null,
   GENDER               varchar(150)         null,
   constraint PK_CUSTOMER primary key (CODE_CUSTOMER)
)
go

/*==============================================================*/
/* Table: DISH                                                  */
/*==============================================================*/
create table DISH (
   CODE_DISH            varchar(10)          not null,
   CODE_CATEGORY_DISH   varchar(10)          not null,
   CODE_CUSTOMER        varchar(10)          not null,
   NAME_DISH            varchar(150)         null,
   UNIT_DRINK           varchar(150)         null,
   PRICE_DISH           decimal              null,
   constraint PK_DISH primary key (CODE_DISH)
)
go

/*==============================================================*/
/* Index: HAVE_FK                                               */
/*==============================================================*/




create nonclustered index HAVE_FK on DISH (CODE_CATEGORY_DISH ASC)
go

/*==============================================================*/
/* Index: ODER_FK                                               */
/*==============================================================*/




create nonclustered index ODER_FK on DISH (CODE_CUSTOMER ASC)
go

/*==============================================================*/
/* Table: DRINK                                                 */
/*==============================================================*/
create table DRINK (
   CODE_DRINK           varchar(10)          not null,
   CODE_CATEGORY_DRINK  varchar(10)          not null,
   CODE_MANUFACTURER    varchar(10)          not null,
   CODE_CUSTOMER        varchar(10)          not null,
   NAME_DRINK           varchar(150)         null,
   UNIT_DRINK           varchar(150)         null,
   PRICE_DRINK          decimal              null,
   constraint PK_DRINK primary key (CODE_DRINK)
)
go

/*==============================================================*/
/* Index: HAVE_TO_FK                                            */
/*==============================================================*/




create nonclustered index HAVE_TO_FK on DRINK (CODE_CATEGORY_DRINK ASC)
go

/*==============================================================*/
/* Index: PRODUCED_FK                                           */
/*==============================================================*/




create nonclustered index PRODUCED_FK on DRINK (CODE_MANUFACTURER ASC)
go

/*==============================================================*/
/* Index: ODER_TO_FK                                            */
/*==============================================================*/




create nonclustered index ODER_TO_FK on DRINK (CODE_CUSTOMER ASC)
go

/*==============================================================*/
/* Table: MANUFACTURER                                          */
/*==============================================================*/
create table MANUFACTURER (
   CODE_MANUFACTURER    varchar(10)          not null,
   NAME                 varchar(150)         null,
   ADDRESS              varchar(150)         null,
   PHONE                numeric              null,
   constraint PK_MANUFACTURER primary key (CODE_MANUFACTURER)
)
go

alter table BILL
   add constraint FK_BILL_PAY_CUSTOMER foreign key (CODE_CUSTOMER)
      references CUSTOMER (CODE_CUSTOMER)
go

alter table DISH
   add constraint FK_DISH_HAVE_CATEGORY foreign key (CODE_CATEGORY_DISH)
      references CATEGORY_DISH (CODE_CATEGORY_DISH)
go

alter table DISH
   add constraint FK_DISH_ODER_CUSTOMER foreign key (CODE_CUSTOMER)
      references CUSTOMER (CODE_CUSTOMER)
go

alter table DRINK
   add constraint FK_DRINK_HAVE_TO_CATEGORY foreign key (CODE_CATEGORY_DRINK)
      references CATEGORY_DRINK (CODE_CATEGORY_DRINK)
go

alter table DRINK
   add constraint FK_DRINK_ODER_TO_CUSTOMER foreign key (CODE_CUSTOMER)
      references CUSTOMER (CODE_CUSTOMER)
go

alter table DRINK
   add constraint FK_DRINK_PRODUCED_MANUFACT foreign key (CODE_MANUFACTURER)
      references MANUFACTURER (CODE_MANUFACTURER)
go

--CÂU 3:
insert into CUSTOMER values ('Cus01', 331555666, 'Nguyen Van A', 'Vinh Long', 'male')
insert into CUSTOMER values ('Cus02', 331123456, 'Nguyen Van B', 'Vinh Long', 'male')
insert into CUSTOMER values ('Cus03', 331232555, 'Nguyen Thi C', 'Vinh Long', 'female')
insert into CUSTOMER values ('Cus04', 331898989, 'Nguyen Thi D', 'Vinh Long', 'female')
insert into CUSTOMER values ('Cus05', 331898999, 'Nguyen Van E', 'Vinh Long', 'male')
SELECT * FROM CUSTOMER


insert into Bill values ('Bi01', 'Cus01', '2021-05-15', 2500000)
insert into Bill values ('Bi02', 'Cus02', '2021-04-10', 1550000)
insert into Bill values ('Bi03', 'Cus03', '2021-06-25', 650000)
insert into Bill values ('Bi04', 'Cus04', '2021-04-03', 900000)
SELECT * FROM Bill

insert into Category_Dish values ('TDi01', 'Grilled', 150000, 350000)
insert into Category_Dish values ('TDi02', 'Seafood', 2000000, 10000000)
insert into Category_Dish values ('TDi03', 'Hot Pot', 50000, 200000)
insert into Category_Dish values ('TDi04', 'Rice', 120000, 550000)
SELECT * FROM Category_Dish

insert into Dish values ('Di01', 'TDi01', 'Cus04', 'Grilled Shrimp', N'VND', 350000)
insert into Dish values ('Di02', 'TDi02', 'Cus04', 'King Crab', N'VND', 5600000)
insert into Dish values ('Di03', 'TDi03', 'Cus04', 'Beef Hot Pot', N'VND', 150000)
insert into Dish values ('Di04', 'TDi04', 'Cus04', 'Fried Rice', N'VND', 130000)
SELECT * FROM Dish

insert into Category_Drink values ('TDr01', 'Beer', 9000, 20000)
insert into Category_Drink values ('TDr02', 'Wine', 400000, 5000000)
insert into Category_Drink values ('TDr03', 'Soft Drinks', 15000, 50000)
insert into Category_Drink values ('TDr04', 'Mineral Water', 5000, 15000)
SELECT * FROM Category_Drink

insert into Manufacturer values ('Mu01', 'Nguyen Van Cha', 'Hue', 0868999999)
insert into Manufacturer values ('Mu02', 'Nguyen Van Hoi', 'TP HCM', 0877555444)
insert into Manufacturer values ('Mu03', 'Nguyen Van La', 'Ha Noi', 099888888)
insert into Manufacturer values ('Mu04', 'Nguyen Van Tui','TP Can Tho', 0968111222)
SELECT * FROM Manufacturer

insert into Drink values ('Dr01', 'TDr01', 'Mu01', 'Cus01', '333 Beer', 'VND', 15000)
insert into Drink values ('Dr02', 'TDr02', 'Mu02', 'Cus02', 'White Wine', 'VND', 650000)
insert into Drink values ('Dr03', 'TDr03', 'Mu03', 'Cus03', 'Pepsi', 'VND', 20000)
insert into Drink values ('Dr04', 'TDr04', 'Mu04', 'Cus04', 'Lavie', 'VND', 12000)
SELECT * FROM Drink



----------CÂU 3------------
SELECT * FROM CUSTOMER
SELECT * FROM Bill
SELECT * FROM Category_Dish
SELECT * FROM Dish
SELECT * FROM Category_Drink
SELECT * FROM Manufacturer
SELECT * FROM Drink
--CÂU 4:
	SELECT NAME_DISH,PRICE_DISH FROM Dish,Category_Dish 
	WHERE Dish.CODE_CATEGORY_DISH = Category_Dish.CODE_CATEGORY_DISH 
	AND Category_Dish.NAME LIKE '%grill%'
--CÂU 5:
create view cusme AS
	SELECT top 100 CODE_CUSTOMER, ID_NUMBER, FULL_NAME, ADDRESS, GENDER,RIGHT(FULL_NAME,CHARINDEX(' ',REVERSE(FULL_NAME))) AS NAME 
	FROM CUSTOMER 
	ORDER BY NAME ASC

SELECT FROM cusme
--CÂU 6:
CREATE PROC UPDATE_CUSTOMER(
   @CODE_CUSTOMER varchar(10),
   @ID_NUMBER numeric,
   @FULL_NAME varchar(150),
   @ADDRESS varchar(150),
   @GENDER varchar(150)
)AS
UPDATE CUSTOMER SET ID_NUMBER = @ID_NUMBER, FULL_NAME = @FULL_NAME, ADDRESS = @ADDRESS, GENDER = @GENDER
WHERE CODE_CUSTOMER = @CODE_CUSTOMER

EXEC UPDATE_CUSTOMER 'cus01',331882702,'Vo Huy Khang','Long Ho - Vinh Long','male'

SELECT * FROM CUSTOMER

-----end--------