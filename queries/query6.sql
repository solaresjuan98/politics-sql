
/*
    6.  Desplegar el porcentaje de mujeres universitarias y hombres universitarios
        que votaron por departamento, donde las mujeres universitarias que votaron
        fueron más que los hombres universitarios que votaron.

*/

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