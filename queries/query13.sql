/*
    13.Desplegar la lista de departamentos de Guatemala y número de votos
        obtenidos, para los departamentos que obtuvieron más votos que el
        departamento de Guatemala.

 */

select department_name, total_voters
from guatemala_departments
where total_voters > (
    select sum(literate_voters) + sum(illiterate_voters)
from election_results
    join municipalities m on m.municipality_code = election_results.municipality_code
    join departments d on m.department_code = d.department_code
    join regions r on d.region_code = r.region_code
    join countries c on r.country_code = c.country_code
where c.country_name = 'Guatemala'
    and d.department_name = 'Guatemala'
group by c.country_name, d.department_name
);
