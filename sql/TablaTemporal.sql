
/*
    

*/
create table temporal_table
(
    election_name    varchar(50)  not null,
    election_year    INT          not null,
    country          varchar(50)  not null,
    region           varchar(50)  not null,
    department       varchar(50)  not null,
    municipality     varchar(50)  not null,
    political_party  varchar(100) not null,
    party_name       varchar(50)  not null,
    gender           varchar(50)  not null,
    race             varchar(50)  not null,
    illiterate       int          not null,
    literate         int          not null,
    gender2          varchar(50)  not null,
    race2            varchar(50)  not null,
    elementary       int          not null,
    high_school      int          not null,
    university_level int          not null
);

