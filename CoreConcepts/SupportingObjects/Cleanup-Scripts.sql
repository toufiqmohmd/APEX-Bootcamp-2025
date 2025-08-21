--drop views--
drop view CUSTOMER_ORDER_PRODUCTS;
drop view PRODUCT_ORDERS;
drop view PRODUCT_REVIEWS;
drop view STORE_ORDERS;
drop view STORE_ORDERS_STATUS;
--drop package--
drop package manage_orders;
--drop tables--
drop table CLOTHING_LOOKUP cascade constraints;
drop table COLOR_LOOKUP cascade constraints;
drop table DEPARTMENT_LOOKUP cascade constraints;
drop table PRODUCTS cascade constraints;
drop table STORES cascade constraints;
drop table customers cascade constraints;
drop table ORDERS cascade constraints;
drop table ORDER_ITEMS cascade constraints;