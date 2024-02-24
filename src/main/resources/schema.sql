#
#
# create SCHEMA if not exists `securecapita`;
#
# SET NAMES utf8mb4;
# SET time_zone = '+00:00';
#
# USE securecapita;
#
# DROP TABLE IF EXISTS Users;
#
# CREATE TABLE Users
# (
#     id bigint unsigned not null auto_increment primary key,
#     first_name varchar(25) not null,
#     last_name varchar(25) not null,
#     email varchar(50) not null,
#     password varchar(100) not null,
#     adress varchar(100) not null,
#     phone varchar(10) not null,
#     title varchar(50) not null,
#     bio varchar(255) not null,
#     enabled boolean default false,
#     non_locked boolean default true,
#     using_nfa boolean default false,
#     created_at datetime default current_timestamp,
#     image_url varchar(255) default 'https://cdn-icones-png.flaticon.com/512/149/14901.png',
#     CONSTRAINT UQ_users_email unique (email)
# )ENGINE=InnoDB;
#
# DROP TABLE IF Exists Roles;
#
# CREATE TABLE Roles
# (
#     id bigint unsigned not null auto_increment primary key,
#     name varchar(50) not null,
#     permission varchar(255) not null,
#     CONSTRAINT UQ_Role_Name unique (name)
# )ENGINE=InnoDB;
#
# DROP TABLE IF EXISTS UserRoles;
#
# CREATE TABLE UserRoles
# (
#     id bigint unsigned not null auto_increment primary key,
#
#     user_id bigint unsigned not null,
#     role_id bigint unsigned not null,
#     foreign key (user_id) references users(id) on delete cascade on update cascade,
#     foreign key (role_id) references roles(id) on delete restrict on update cascade,
#     CONSTRAINT UQ_UserRole_User_id unique (user_id)
# )ENGINE=InnoDB;
#
# DROP TABLE IF EXISTS Events;
#
# CREATE TABLE Events
# (
#     id bigint unsigned not null auto_increment primary key,
#     type varchar(50) not null check(type in('LOGIN_ATTEMPT', 'LOGIN_ATTEMPT_FAILURE', 'LOGIN_ATTEMPT_SUCCESS','PROFILE_PICTURE_UPDATE','ROLE_UPDATE','ACCOUNT_SETTING_UPDATE','PASSWORD_UPDATE','MFA_UPDATE')),
#     description varchar(255) not null,
#     CONSTRAINT UQ_Events_Type unique (type)
# )ENGINE=InnoDB;
#
# DROP TABLE IF EXISTS UserEvents;
#
# CREATE TABLE UserEvents
# (
#     id bigint unsigned not null auto_increment primary key,
#     user_id bigint unsigned not null,
#     event_id bigint unsigned not null,
#     device varchar(255) not null,
#     ip_address varchar(255) default null,
#     created_at datetime not null default current_timestamp,
#     url varchar(255) not null,
#     foreign key (user_id) references users(id) on delete cascade on update cascade,
#     foreign key (event_id) references events(id) on delete restrict on update cascade
# )ENGINE=InnoDB;
#
# DROP TABLE IF EXISTS AccountVerifications;
#
# CREATE TABLE AccountVerifications
# (
#     id bigint unsigned not null auto_increment primary key,
#     user_id bigint unsigned not null,
#     url varchar(200) not null,
#     --  date datetime not null,
#     foreign key (user_id) references Users(id) on delete cascade on update cascade,
#     CONSTRAINT UQ_AccountVerifications_UserId unique (user_id),
#     CONSTRAINT UQ_AccountVerifications_Url unique (url)
# )ENGINE=InnoDB;
#
# DROP TABLE IF EXISTS resetPasswordVerifications;
#
# CREATE TABLE ResetPasswordVerifications
# (
#     id bigint unsigned not null auto_increment primary key,
#     user_id bigint unsigned not null,
#     url varchar(200) not null,
#     expiration_date datetime not null,
#     foreign key (user_id) references users(id) on delete cascade on update cascade,
#     CONSTRAINT UQ_ResetPasswordVerifications_UserId unique (user_id),
#     CONSTRAINT UQ_ResetPasswordVerifications_Url unique (url)
# )ENGINE=InnoDB;
#
# DROP TABLE IF EXISTS TwofactorsVerifications;
#
# CREATE TABLE TwofactorsVerifications
# (
#     id bigint unsigned not null auto_increment primary key,
#     user_id bigint unsigned not null,
#     code varchar(200) not null,
#     expiration_date datetime not null,
#     foreign key (user_id) references users(id) on delete cascade on update cascade,
#     CONSTRAINT UQ_TwofactorsVerifications_UserId unique (user_id),
#     CONSTRAINT UQ_TwofactorsVerifications_Code unique (code)
# )ENGINE=InnoDB;
#
# *************************************************************

use securecapita;
select * users;
select * roles;
insert into securecapita.roles(name, permission)
value ('ROLE_USER','READ:USER, READ:CUSTOMER'),
      ('ROLE_MANAGER','READ:USER, READ:CUSTOMER, UPDATE:USER, UPDATE:CUSTOMER'),
      ('ROLE_ADMIN','READ:USER, READ:CUSTOMER, CREATE:USER, CREATE:CUSTOMER, UPDATE:USER, UPDATE:CUSTOMER'),
      ('ROLE_SYSADMIN','READ:USER, READ:CUSTOMER, CREATE:USER, CREATE:CUSTOMER, UPDATE:USER, UPDATE:CUSTOMER, DELETE:USER, DELETE:CUSTOMER');
