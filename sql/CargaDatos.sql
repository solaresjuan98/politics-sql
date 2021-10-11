-- Fill 'COUNTRIES' table
insert into countries (country_name)
select distinct country
from temporal_table;

select *
from countries;

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