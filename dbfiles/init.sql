CREATE USER 'shibboleth'@'localhost' IDENTIFIED BY 'shibboleth';
CREATE DATABASE shibbolethdb;
GRANT ALL ON shibbolethdb.* TO 'shibboleth'%'localhost';

USE shibbolethdb;

CREATE TABLE people( 
userid varchar(22) NOT NULL,
email varchar(22) NOT NULL,
firstName varchar(22) NOT NULL,
lastName varchar(22) NOT NULL,
middleInitial varchar(22) NOT NULL,
phone varchar(22) NOT NULL,
manager varchar(22) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE people_role( 
roleid int(11) unsigned NOT NULL AUTO_INCREMENT,
userid varchar(22) NOT NULL,
PRIMARY KEY(roleid),
FOREIGN KEY(userid) REFERENCES people(userid)
);
