-- Fill 'COUNTRIES' table
insert into countries (country_name)
select distinct country
from temporal_table;

-- Fill 'REGIONS' table
insert into regions (region_name, country_code)
select distinct region, c.country_code
from temporal_table
         join countries c on temporal_table.country = c.country_name;

-- Fill 'DEPARTMENTS' table
insert into departments (department_name, region_code)
select distinct department, r.region_code
from temporal_table
         join countries c on temporal_table.country = c.country_name
         join regions r on c.country_code = r.country_code
    and region = r.region_name;

-- Fill 'MUNICIPALITIES' table
insert into municipalities (municipality_name, department_code)
select distinct municipality, d.department_code
from temporal_table
         join departments d on temporal_table.department = d.department_name;


-- POLITICAL PARTIES
INSERT INTO politic_party(abbreviate_name, full_name, country_code)
select distinct political_party, party_name, c.country_code
from temporal_table
         join countries c on temporal_table.country = c.country_name;