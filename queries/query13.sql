/*
    13.Desplegar la lista de departamentos de Guatemala y número de votos
        obtenidos, para los departamentos que obtuvieron más votos que el
        departamento de Guatemala.

 */

select department_name, total_voters
from Guatemala_departments
where total_voters > (
    select distinct sum(literate_voters) + sum(illiterate_voters) as total_voters
from literacy_level_result
    join municipalities m on literacy_level_result.municipality_code = m.municipality_code
    join departments d on d.department_code = m.department_code
    join regions r on d.region_code = r.region_code
    join countries c on r.country_code = c.country_code
where country_name = 'Guatemala'
    and department_name = 'Guatemala'
group by c.country_name, department_name
);
