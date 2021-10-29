/*
    9. Desplegar el nombre del país y el porcentaje de votos por raza.
*/

select distinct c.country_name,
    r.race_name,
    -- sum(election_results.illiterate_voters + election_results.literate_voters) as sub_total,
    -- cvc.total_sum,
    ((sum(election_results.illiterate_voters + election_results.literate_voters) / cvc.total_sum) *
                 100) as race_pct
from election_results
    join elections e on election_results.election_code = e.election_code
    join race r on election_results.race_code = r.race_code
    join countries c on c.country_code = e.country_code
    join countries_votes_count cvc on c.country_name = cvc.country_name
group by c.country_name, r.race_name
order by country_name, race_pct;