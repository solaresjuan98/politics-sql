
/*
    12. Desplegar el nombre del país, el porcentaje de votos de ese país en el que
        han votado mayor porcentaje de analfabetas. (tip: solo desplegar un nombre
        de país, el de mayor porcentaje).

*/

select c.country_name,
    -- (sum(illiterate_voters)) total_votes,
    -- cvc.total_sum,
    (sum(illiterate_voters) / cvc.total_sum) * 100 as percentage
from election_results
    join municipalities m on election_results.municipality_code = m.municipality_code
    join departments d on m.department_code = d.department_code
    join regions r on d.region_code = r.region_code
    join countries c on c.country_code = r.country_code
    join race r2 on election_results.race_code = r2.race_code
    join countries_votes_count cvc on c.country_name = cvc.country_name
group by country_name
order by percentage desc
limit 1;