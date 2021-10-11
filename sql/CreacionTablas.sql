use proyecto2;

-- Create tables
CREATE TABLE COUNTRIES
(
    country_code int auto_increment not null,
    country_name varchar(20)        not null,
    primary key (country_code)
);

CREATE TABLE REGIONS
(
    region_code  int auto_increment NOT NULL,
    region_name  varchar(15)        not null,
    country_code int                not null,
    primary key (region_code),
    foreign key (country_code) references COUNTRIES (country_code)
);


CREATE TABLE DEPARTMENTS
(
    department_code int auto_increment not null,
    department_name varchar(30)        not null,
    region_code     int                not null,
    primary key (department_code),
    foreign key (region_code) references REGIONS (region_code)
);


CREATE TABLE MUNICIPALITIES
(
    municipality_code int auto_increment not null,
    municipality_name varchar(50)        not null,
    department_code   int                not null,
    primary key (municipality_code),
    foreign key (department_code) references DEPARTMENTS (department_code)
);