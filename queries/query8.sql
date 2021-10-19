/*
    8. Desplegar el total de votos de cada nivel de escolaridad (primario, medio,
        universitario) por país, sin importar raza o sexo.
*/


select distinct country_name,
    sum(elementary_level)     elementary_level_total,
    sum(high_school_level) as high_school_total,
    sum(university_level)  as university_level_total
from scholarship_level_result
    join elections e on e.election_code = scholarship_level_result.election_code
    join countries c on e.country_code = c.country_code
group by country_name;