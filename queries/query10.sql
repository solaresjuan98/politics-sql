/*
    10. Desplegar el nombre del país en el cual las elecciones han sido más
        peleadas. Para determinar esto se debe calcular la diferencia de porcentajes
        de votos entre el partido que obtuvo más votos y el partido que obtuvo menos
        votos
*/


select max_values.country_name,
    max_values.full_name,
    (max_num_votes - min_num_votes)              as difference,
    (max_votes_percetage - min_votes_percentage) as percentage_difference
from (
         -- Max values
         select country_name, full_name, max(num_votes) as max_num_votes, max(votes_percentage) as max_votes_percetage
    from (
                  select c.country_name,
            pp.full_name,
            sum(literate_voters) + sum(illiterate_voters)                           as num_votes,
            ((sum(literate_voters) + sum(illiterate_voters)) / cvc.total_sum) * 100 as votes_percentage
        from election_results
            join municipalities m on m.municipality_code = election_results.municipality_code
            join departments d on m.department_code = d.department_code
            join regions r on d.region_code = r.region_code
            join countries c on r.country_code = c.country_code
            join politic_party pp on election_results.pp_code = pp.pol_party_code
            join countries_votes_count cvc on c.country_name = cvc.country_name
        group by country_name, pp.full_name
              ) table1
    group by country_name
     ) max_values
    join (
    -- Min values
    select country_name, full_name, min(num_votes) as min_num_votes, min(votes_percentage) as min_votes_percentage
    from (
             select c.country_name,
            pp.full_name,
            sum(literate_voters) + sum(illiterate_voters)                           as num_votes,
            ((sum(literate_voters) + sum(illiterate_voters)) / cvc.total_sum) * 100 as votes_percentage
        from election_results
            join municipalities m on m.municipality_code = election_results.municipality_code
            join departments d on m.department_code = d.department_code
            join regions r on d.region_code = r.region_code
            join countries c on r.country_code = c.country_code
            join politic_party pp on election_results.pp_code = pp.pol_party_code
            join countries_votes_count cvc on c.country_name = cvc.country_name
        group by country_name, pp.full_name
         ) table2
    group by country_name
) min_values on max_values.country_name = min_values.country_name
order by difference
limit 1;
