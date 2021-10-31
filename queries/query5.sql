/*
    5.  Desplegar el nombre del país, el departamento, el municipio y la cantidad de
        votos universitarios de todos aquellos municipios en donde la cantidad de
        votos de universitarios sea mayor que el 25% de votos de primaria y menor
        que el 30% de votos de nivel medio. Ordene sus resultados de mayor a
        menor.

*/


select country, department, municipality, university_voters
from (
         select c.country_name                     country,
        d.department_name                  department,
        m.municipality_name                municipality,
        sum(university_level_voters)       university_voters,
        sum(elementary_lvl_voters) * 0.25  25p_elemental_voters,
        sum(high_school_lvl_voters) * 0.30 30p_high_school_voters
    from election_results
        join elections e on e.election_code = election_results.election_code
        join municipalities m on m.municipality_code = election_results.municipality_code
        join departments d on m.department_code = d.department_code
        join regions r on d.region_code = r.region_code
        join countries c on e.country_code = c.country_code
    group by d.department_name, m.municipality_name
     ) temp1
where university_voters > 25
p_elemental_voters
  and university_voters < 30p_high_school_voters;