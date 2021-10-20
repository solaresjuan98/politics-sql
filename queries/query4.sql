select table3.country_name, table3.region_name, table3.max_value
from (
         select table1.country_name, table1.region_name, table1.race_name, max(table1.total_votes) max_value
    from (
                  --
                  select country_name,
            region_name,
            race_name,
            (sum(literate_voters) + sum(illiterate_voters)) total_votes
        from election_results
            join municipalities m on election_results.municipality_code = m.municipality_code
            join departments d on m.department_code = d.department_code
            join regions r on d.region_code = r.region_code
            join countries c on c.country_code = r.country_code
            join race r2 on election_results.race_code = r2.race_code
        group by country_name, region_name, race_name
              ) table1
    group by table1.country_name, table1.region_name) table3
    --
    join (
    -- view
    select country_name, region_name, race_name, (sum(literate_voters) + sum(illiterate_voters)) total_votes
    from election_results
        join municipalities m on election_results.municipality_code = m.municipality_code
        join departments d on m.department_code = d.department_code
        join regions r on d.region_code = r.region_code
        join countries c on c.country_code = r.country_code
        join race r2 on election_results.race_code = r2.race_code
    group by country_name, region_name, race_name
) table2 on table3.country_name = table2.country_name and table2.race_name = 'INDIGENAS' and
        table2.total_votes = table3.max_value
--
group by table2.country_name, table2.region_name, table2.race_name
order by table2.country_name;
;
