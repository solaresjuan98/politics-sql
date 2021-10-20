/*
    7. Desplegar el nombre del país, la región y el promedio de votos por
    departamento. Por ejemplo: si la región tiene tres departamentos, se debe
    sumar todos los votos de la región y dividirlo dentro de tres (número de
    departamentos de la región).

*/

select country_name, region_name, total_votes / dbr.num_of_deparments as average_votes
from (
         select c.country_name                                as country,
        r.region_name                                 as region,
        sum(literate_voters) + sum(illiterate_voters) as total_votes
    from election_results
        join municipalities m on election_results.municipality_code = m.municipality_code
        join departments d on m.department_code = d.department_code
        join regions r on d.region_code = r.region_code
        join countries c on r.country_code = c.country_code
    group by country_name, region_name
     ) temp1
    join departments_by_region dbr on dbr.country_name = temp1.country and dbr.region_name = temp1.region;
;