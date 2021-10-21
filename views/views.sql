
-- View country_regions
create view country_regions
as
    select country_name, 'TOTAL', sum(total_raza) as total
    from (
         select distinct country_name, race_name, count(r.race_code), count(*) total_raza
        from countries
            join elections e on countries.country_code = e.country_code
            join race_result rr on e.election_code = rr.election_code
            join race r on rr.race_code = r.race_code
        group by country_name, e.country_code, race_name
        order by country_name
     ) temp
    group by country_name;


-- View Guatemala_departments
create view Guatemala_departments
as
    select distinct c.country_name, department_name, sum(literate_voters) + sum(illiterate_voters) as total_voters
    from literacy_level_result
        join municipalities m on literacy_level_result.municipality_code = m.municipality_code
        join departments d on d.department_code = m.department_code
        join regions r on d.region_code = r.region_code
        join countries c on r.country_code = c.country_code
    where country_name = 'Guatemala'
    group by c.country_name, department_name;



-- View countries_votes_count
create view countries_votes_count
as
    select distinct c.country_name, (sum(literate_voters) + sum(illiterate_voters)) total_sum
    from election_results
        join race r on election_results.race_code = r.race_code
        join gender g on election_results.gender_code = g.gender_code
        join municipalities m on election_results.municipality_code = m.municipality_code
        join departments d on d.department_code = m.department_code
        join regions r2 on d.region_code = r2.region_code
        join countries c on r2.country_code = c.country_code
    group by c.country_name;


-- Get the number of departments  by country
create view departments_by_country
as
    select c.country_name, count(department_code) as num_of_deparments
    from countries c
        join regions r on c.country_code = r.country_code
        join departments d on r.region_code = d.region_code
    group by country_name;


-- Get the number of departments by region
create view departments_by_region
as
    select c.country_name, r.region_name, count(department_name) as num_of_deparments
    from countries c
        join regions r on c.country_code = r.country_code
        join departments d on r.region_code = d.region_code
    group by country_name, region_name;

-- Get the number of woman voters by country
create view total_women_voters_by_country as
select country_name, sum(sub_total) as total_voters
from (
         select distinct country_name, (sum(literate_voters) + sum(illiterate_voters)) as sub_total
         from election_results
                  join municipalities m on election_results.municipality_code = m.municipality_code
                  join departments d on m.department_code = d.department_code
                  join regions r on d.region_code = r.region_code
                  join countries c on r.country_code = c.country_code
                  join gender g on election_results.gender_code = g.gender_code
         where gender_type = 'Mujeres'
         group by country_name, department_name
     ) temp
group by country_name;


-- get total votes by department
create view departments_votes_count as
select d.department_code, d.department_name, sum(literate_voters) + sum(illiterate_voters) as total_voters
from election_results
         join municipalities m on election_results.municipality_code = m.municipality_code
         join departments d on m.department_code = d.department_code
group by d.department_name;
