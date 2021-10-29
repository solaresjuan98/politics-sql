/*

    1.  Desplegar para cada elección el país y el partido político que obtuvo mayor
        porcentaje de votos en su país. Debe desplegar el nombre de la elección, el
        año de la elección, el país, el nombre del partido político y el porcentaje que
        obtuvo de votos en su país.

*/
select election_name, election_year, country_name, full_name, max(voters_percentage)
from (
         select election_name,
        election_year,
        c.country_name,
        pp.full_name,
        ((sum(literate_voters) + sum(illiterate_voters)) / cvc.total_sum) * 100 as voters_percentage
    from election_results
        join elections e on election_results.election_code = e.election_code
        join countries c on e.country_code = c.country_code
        join politic_party pp on election_results.pp_code = pp.pol_party_code
        join countries_votes_count cvc on c.country_name = cvc.country_name
    group by election_name, election_year, c.country_name, pp.full_name
    order by country_name,  voters_percentage desc
     ) temptable
group by election_name, election_year, country_name;


