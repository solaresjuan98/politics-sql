use proyecto2;
-- 1

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
         order by country_name, voters_percentage desc
     ) temptable
group by election_name, election_year, country_name;


-- 2
select c.country_name,
       department_name,
       (sum(literate_voters) + sum(illiterate_voters))                             as total_voters,
       ((sum(literate_voters) + sum(illiterate_voters)) / tvbc.total_voters) * 100 as percentage
from election_results
         join municipalities m on election_results.municipality_code = m.municipality_code
         join departments d on m.department_code = d.department_code
         join regions r on d.region_code = r.region_code
         join countries c on r.country_code = c.country_code
         join gender g on election_results.gender_code = g.gender_code
         join total_women_voters_by_country tvbc on c.country_name = tvbc.country_name
where g.gender_type = 'Mujeres'
group by country_name, department_name;

-- 3
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

-- 4
select table3.country_name, table3.region_name, table3.max_value as total
from (
         select table1.country_name, table1.region_name, table1.race_name, max(table1.total_votes) max_value
         from (
                  --
                  select country_name,
                         region_name,
                         race_name,
                         (sum(literate_voters) + sum(illiterate_voters)) total_votes
                  from election_results
                           join municipalities m on election_results.municipality_code = m.municipality_code
                           join departments d on m.department_code = d.department_code
                           join regions r on d.region_code = r.region_code
                           join countries c on c.country_code = r.country_code
                           join race r2 on election_results.race_code = r2.race_code
                  group by country_name, region_name, race_name
              ) table1
         group by table1.country_name, table1.region_name) table3
         --
         join (
    -- view
    select country_name, region_name, race_name, (sum(literate_voters) + sum(illiterate_voters)) total_votes
    from election_results
             join municipalities m on election_results.municipality_code = m.municipality_code
             join departments d on m.department_code = d.department_code
             join regions r on d.region_code = r.region_code
             join countries c on c.country_code = r.country_code
             join race r2 on election_results.race_code = r2.race_code
    group by country_name, region_name, race_name
) table2 on table3.country_name = table2.country_name and table2.race_name = 'INDIGENAS' and
            table2.total_votes = table3.max_value
--
group by table2.country_name, table2.region_name, table2.race_name
order by table2.country_name;

-- 5
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
where university_voters > 25p_elemental_voters
  and university_voters < 30p_high_school_voters;

-- 6
select t2.department_name, t2.gender_type, t2.gender_percentage
from (
         select d.department_code,
                d.department_name,
                g.gender_type,
                ((sum(high_school_lvl_voters)) / dvc.total_voters) * 100 gender_percentage
         from election_results
                  join municipalities m on election_results.municipality_code = m.municipality_code
                  join gender g on election_results.gender_code = g.gender_code
                  join departments d on m.department_code = d.department_code
                  join departments_votes_count dvc on d.department_code = dvc.department_code
         where gender_type = 'hombres'
         group by d.department_name, g.gender_type
         order by department_name
     ) t1
         join (
    select d.department_code,
           d.department_name,
           g.gender_type,
           ((sum(high_school_lvl_voters)) / dvc.total_voters) * 100 gender_percentage
    from election_results
             join municipalities m on election_results.municipality_code = m.municipality_code
             join gender g on election_results.gender_code = g.gender_code
             join departments d on m.department_code = d.department_code
             join departments_votes_count dvc on d.department_code = dvc.department_code
    where gender_type = 'mujeres'
    group by d.department_name, g.gender_type
    order by department_name
) t2 on t1.department_code = t2.department_code
where t2.gender_percentage > t1.gender_percentage;

-- 7
select country_name, region_name, total_votes / dbr.num_of_deparments as average_votes
from (
         select c.country_name                                as country,
                r.region_name                                 as region,
                sum(literate_voters) + sum(illiterate_voters) as total_votes
         from election_results
                  join municipalities m on election_results.municipality_code = m.municipality_code
                  join departments d on m.department_code = d.department_code
                  join regions r on d.region_code = r.region_code
                  join countries c on r.country_code = c.country_code
         group by country_name, region_name
     ) temp1
         join departments_by_region dbr on dbr.country_name = temp1.country and dbr.region_name = temp1.region;
;

-- 8
select c.country_name,
       sum(elementary_lvl_voters)      elementary,
       sum(high_school_lvl_voters)     high_school,
       sum(university_level_voters) as university
from election_results
         join elections e on e.election_code = election_results.election_code
         join countries c on c.country_code = e.country_code
group by c.country_name;

-- 9
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

-- 10
select max_values.country_name,
       -- max_values.full_name,
       (max_num_votes - min_num_votes) as difference
-- (max_votes_percetage - min_votes_percentage) as percentage_difference
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


-- 11
select distinct c.country_name,
                sum(literate_voters)                      total_literate_voters,
                sum(literate_voters) / t2.total_sum * 100 percentage
from election_results
         join race r on election_results.race_code = r.race_code
         join gender g on election_results.gender_code = g.gender_code
         join municipalities m on election_results.municipality_code = m.municipality_code
         join departments d on d.department_code = m.department_code
         join regions r2 on d.region_code = r2.region_code
         join countries c on r2.country_code = c.country_code
         join (
    select distinct c.country_name, (sum(literate_voters) + sum(illiterate_voters)) total_sum
    from election_results
             join race r on election_results.race_code = r.race_code
             join gender g on election_results.gender_code = g.gender_code
             join municipalities m on election_results.municipality_code = m.municipality_code
             join departments d on d.department_code = m.department_code
             join regions r2 on d.region_code = r2.region_code
             join countries c on r2.country_code = c.country_code
    group by c.country_name
) t2 on t2.country_name = c.country_name
where gender_type = 'Mujeres'
  and race_name = 'INDIGENAS'
group by c.country_name;

-- 12
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

-- 13
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
