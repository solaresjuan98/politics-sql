/*

    11. Desplegar el total de votos y el porcentaje de votos emitidos por mujeres
        indígenas alfabetas.

*/

select distinct c.country_name, sum(literate_voters) total_literate_voters, sum(literate_voters) / t2.total_sum * 100 percentage
from election_results
    join race r on election_results.race_code = r.race_code
    join gender g on election_results.gender_code = g.gender_code
    join municipalities m on election_results.municipality_code = m.municipality_code
    join departments d on d.department_code = m.department_code
    join regions r2 on d.region_code = r2.region_code
    join countries c on r2.country_code = c.country_code
    join (
    select distinct c.country_name, (sum(literate_voters) + sum(illiterate_voters)) total_sum
    from election_results
        join race r on election_results.race_code = r.race_code
        join gender g on election_results.gender_code = g.gender_code
        join municipalities m on election_results.municipality_code = m.municipality_code
        join departments d on d.department_code = m.department_code
        join regions r2 on d.region_code = r2.region_code
        join countries c on r2.country_code = c.country_code
    group by c.country_name
) t2 on t2.country_name = c.country_name
where gender_type = 'Mujeres'
    and race_name = 'INDIGENAS'
group by c.country_name;