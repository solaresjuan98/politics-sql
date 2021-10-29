/*
3. Desplegar el nombre del país, nombre del partido político y número de
alcaldías de los partidos políticos que ganaron más alcaldías por país.

 */

select cntry_name, p_name, max(elections_won)
from (
         select temp_tabl2.country_name as cntry_name, temp_tabl2.full_name as p_name, count(*) as elections_won
    from (
                  select temp_table1.country_name      as country_n,
            temp_table1.department_name   as dep,
            -- temp_table1.full_name,
            temp_table1.municipality_name as muni,
            max(temp_table1.votes_earned) as total_votes
        from (
                           select c.country_name,
                d.department_name,
                pp.pol_party_code,
                pp.full_name,
                municipality_name,
                sum(literate_voters) + sum(illiterate_voters) votes_earned
            from election_results
                join municipalities m on m.municipality_code = election_results.municipality_code
                join departments d on m.department_code = d.department_code
                join regions r on d.region_code = r.region_code
                join countries c on r.country_code = c.country_code
                join politic_party pp on election_results.pp_code = pp.pol_party_code
            group by c.country_name, d.department_name, municipality_name, pp.pol_party_code,
                                    pp.full_name
                       ) temp_table1
        group by temp_table1.country_name, temp_table1.department_name,
                           temp_table1.municipality_name) temporal3
        join
        (
                  select c.country_name,
            d.department_name,
            pp.pol_party_code,
            pp.full_name,
            municipality_name,
            sum(literate_voters) + sum(illiterate_voters) votes_earned
        from election_results
            join municipalities m on m.municipality_code = election_results.municipality_code
            join departments d on m.department_code = d.department_code
            join regions r on d.region_code = r.region_code
            join countries c on r.country_code = c.country_code
            join politic_party pp on election_results.pp_code = pp.pol_party_code
        group by c.country_name, d.department_name, pp.pol_party_code, pp.full_name, municipality_name
              ) temp_tabl2
        on temporal3.country_n = temp_tabl2.country_name and
            temporal3.dep = temp_tabl2.department_name and
            temporal3.total_votes = temp_tabl2.votes_earned and
            temporal3.muni = temp_tabl2.municipality_name
    group by temp_tabl2.country_name, temp_tabl2.full_name
    order by country_name, elections_won desc) temporal4
group by cntry_name;