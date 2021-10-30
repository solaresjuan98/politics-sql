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



CREATE TABLE POLITIC_PARTY
(
    pol_party_code  int auto_increment not null,
    abbreviate_name varchar(50)        not null,
    full_name       varchar(50),
    country_code    int                not null,
    primary key (pol_party_code),
    foreign key (country_code) references COUNTRIES (country_code)
);

CREATE TABLE ELECTIONS
(
    election_code int auto_increment not null,
    election_name varchar(50)        not null,
    election_year int                not null,
    country_code  int                not null,
    primary key (election_code),
    foreign key (country_code) references COUNTRIES (country_code)
);


CREATE TABLE ELECTION_RESULTS
(
    election_result_code  int auto_increment not null,
    election_name         varchar(50)        not null,
    election_year         int                not null,
    gender                varchar(50)        not null,
    race                  varchar(50)        not null,
    literate_voters       int                not null,
    illiterate_voters     int                not null,
    elementary_lvl_voters int                not null,
    high_school_voters    int                not null,
    university_lvl_voter  int                not null,
    municipality          varchar(50)        not null,
    pp_code               int                not null,
    country_code          int                not null,
    primary key (election_result_code),
    foreign key (pp_code) references POLITIC_PARTY (pol_party_code),
    foreign key (country_code) references COUNTRIES (country_code)
);

-- ==============================================
CREATE TABLE GENDER
(
    gender_code int auto_increment not null,
    gender_type varchar(50)        not null,
    primary key (gender_code)
);

CREATE TABLE RACE
(
    race_code int auto_increment not null,
    race_name varchar(50)        not null,
    primary key (race_code)
);