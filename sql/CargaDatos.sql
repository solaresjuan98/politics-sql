-- Fill 'COUNTRIES' table
insert into countries
    (country_name)
select distinct country
from temporal_table;

-- Fill 'REGIONS' table
insert into regions
    (region_name, country_code)
select distinct region, c.country_code
from temporal_table
    join countries c on temporal_table.country = c.country_name;

-- Fill 'DEPARTMENTS' table
insert into departments
    (department_name, region_code)
select distinct department, r.region_code
from temporal_table
    join countries c on temporal_table.country = c.country_name
    join regions r on c.country_code = r.country_code
        and region = r.region_name;

-- Fill 'MUNICIPALITIES' table
insert into municipalities
    (municipality_name, department_code)
select distinct municipality, d.department_code
from temporal_table
    join departments d on temporal_table.department = d.department_name;


-- POLITICAL PARTIES
INSERT INTO politic_party
    (abbreviate_name, full_name, country_code)
select distinct political_party, party_name, c.country_code
from temporal_table
    join countries c on temporal_table.country = c.country_name;


-- ELECTIONS
insert into elections
    (election_name, election_year, country_code)
select distinct election_name, election_year, c.country_code
from temporal_table
    join countries c on temporal_table.country = c.country_name;

insert into gender
    (gender_type)
select distinct gender
from temporal_table;

insert into race
    (race_name)
select distinct race
from temporal_table;


/*
-- INSERT DATA INTO 'LITERACY_LEVEL'
insert into literacy_level_result
    (municipality_code, election_code, literate_voters, illiterate_voters)
select distinct m.municipality_code,
    e.election_code,
    literate,
    illiterate
from temporal_table
    join countries c on temporal_table.country = c.country_name
    join elections e on temporal_table.election_name = e.election_name
        and e.country_code = c.country_code
    join regions r on temporal_table.region = r.region_name
    join departments d on temporal_table.department = d.department_name
        and d.region_code = r.region_code
    join municipalities m
    on temporal_table.municipality = m.municipality_name
        and d.department_code = m.department_code;


-- INSERT DATA INTO 'SCHOLARSHIP_LEVEL_RESULT'
insert into scholarship_level_result
    (municipality_code, election_code, elementary_level, high_school_level,
    university_level)
select distinct m.municipality_code,
    e.election_code,
    elementary,
    high_school,
    university_level
from temporal_table
    join countries c on temporal_table.country = c.country_name
    join elections e on temporal_table.election_name = e.election_name
        and e.country_code = c.country_code
    join regions r on temporal_table.region = r.region_name
    join departments d on temporal_table.department = d.department_name
        and d.region_code = r.region_code
    join municipalities m
    on temporal_table.municipality = m.municipality_name
        and d.department_code = m.department_code;




-- Insert into 'POLITICAL_RESULT' table
insert into political_result
    (municipality_code, election_code, political_party_code)
select m.municipality_code,
    e.election_code,
    pp.pol_party_code
from temporal_table
    join countries c on temporal_table.country = c.country_name
    join elections e on temporal_table.election_name = e.election_name
        and e.country_code = c.country_code
    join regions r on temporal_table.region = r.region_name
    join departments d on temporal_table.department = d.department_name
        and d.region_code = r.region_code
    join municipalities m
    on temporal_table.municipality = m.municipality_name
        and d.department_code = m.department_code
    join politic_party pp on temporal_table.political_party = pp.abbreviate_name;



-- Insert into GENDER_RESULT table
insert into gender_result
    (municipality_code, election_code, gender_code)
select m.municipality_code,
    e.election_code,
    g.gender_code
from temporal_table
    join countries c on temporal_table.country = c.country_name
    join elections e on temporal_table.election_name = e.election_name
        and e.country_code = c.country_code
    join regions r on temporal_table.region = r.region_name
    join departments d on temporal_table.department = d.department_name
        and d.region_code = r.region_code
    join municipalities m
    on temporal_table.municipality = m.municipality_name
        and d.department_code = m.department_code
    join gender g on temporal_table.gender = g.gender_type;


-- Insert into 'RACE_RESULT'
insert into race_result
    (municipality_code, election_code, race_code)
select m.municipality_code,
    e.election_code,
    ra.race_code
from temporal_table
    join countries c on temporal_table.country = c.country_name
    join elections e on temporal_table.election_name = e.election_name
        and e.country_code = c.country_code
    join regions r on temporal_table.region = r.region_name
    join departments d on temporal_table.department = d.department_name
        and d.region_code = r.region_code
    join municipalities m
    on temporal_table.municipality = m.municipality_name
        and d.department_code = m.department_code
    join race ra on temporal_table.race = ra.race_name;

*/

insert into election_results
    (election_code, municipality_code, gender_code, race_code, pp_code, illiterate_voters,
    literate_voters, elementary_lvl_voters, high_school_lvl_voters, university_level_voters)
select e.election_code,
    m.municipality_code,
    g.gender_code,
    rac.race_code,
    pp.pol_party_code,
    illiterate,
    literate,
    elementary,
    high_school,
    university_level
from temporal_table
    join countries c on temporal_table.country = c.country_name
    join elections e on temporal_table.election_name = e.election_name
        and e.country_code = c.country_code
    join regions r on temporal_table.region = r.region_name
    join departments d on temporal_table.department = d.department_name
        and d.region_code = r.region_code
    join municipalities m
    on temporal_table.municipality = m.municipality_name
        and d.department_code = m.department_code
    join gender g on temporal_table.gender = g.gender_type
    join race rac on temporal_table.race = rac.race_name
    join politic_party pp on temporal_table.political_party = pp.abbreviate_name;