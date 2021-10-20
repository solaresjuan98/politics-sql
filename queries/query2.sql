/*
    2. Desplegar total de votos y porcentaje de votos de mujeres por departamento
    y país. El ciento por ciento es el total de votos de mujeres por país. (Tip:
    Todos los porcentajes por departamento de un país deben sumar el 100%)
*/


select c.country_name,
    department_name,
    -- (sum(literate_voters) + sum(illiterate_voters)) as sub_total,
    -- total_voters,
    ((sum(literate_voters) + sum(illiterate_voters)) / tvbc.total_voters) * 100 as percentage
from election_results
    join municipalities m on election_results.municipality_code = m.municipality_code
    join departments d on m.department_code = d.department_code
    join regions r on d.region_code = r.region_code
    join countries c on r.country_code = c.country_code
    join gender g on election_results.gender_code = g.gender_code
    join total_women_voters_by_country tvbc on c.country_name = tvbc.country_name
where g.gender_type = 'Mujeres'
group by country_name, department_name;