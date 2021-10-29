/*
    8. Desplegar el total de votos de cada nivel de escolaridad (primario, medio,
        universitario) por país, sin importar raza o sexo.
*/


select c.country_name, sum(elementary_lvl_voters) elementary, sum(high_school_lvl_voters) high_school, sum(university_level_voters) as university
from election_results
         join elections e on e.election_code = election_results.election_code
         join countries c on c.country_code = e.country_code
group by c.country_name;