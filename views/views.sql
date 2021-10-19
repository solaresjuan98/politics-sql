
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