/*
    9. Desplegar el nombre del país y el porcentaje de votos por raza.
*/


select distinct countries.country_name, race_name, count(r.race_code) /cr.total * 100 as votes_percentage
from countries
         join elections e on countries.country_code = e.country_code
         join race_result rr on e.election_code = rr.election_code
         join race r on rr.race_code = r.race_code
         join country_regions cr on countries.country_name = cr.country_name
group by country_name, e.country_code, race_name
order by country_name;
