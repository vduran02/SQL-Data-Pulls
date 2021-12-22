
------------------------------------------ Chris Stevens UAL In-Scope pcp visit
select plantypedesc, count(distinct dw_member_id), count(plantypedesc)
from membermonths
where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
and udf16id = 'In-Scope'
group by plantypedesc;

select count(distinct dw_member_id)
from utilization
where udf16 = 'In-Scope'
--and primaryorspecialityofficevisit != 'Primary Care Office Visit'
and date_part(year,startdate) = 2020
--group by dw_member_id
--order by startdate
;


select case when date_part(year,startdate) = 2018 then '2018' when date_part(year,startdate) = 2019 then '2019' when date_part(year,startdate) = 2020 then '2020' when date_part(year,startdate) = 2021 then '2021' end as years, count(distinct dw_member_id) as mem_cnt
from utilization
where udf16 = 'In-Scope'
and udf17 = 'Active'
--and primaryorspecialityofficevisit != 'Primary Care Office Visit'
and date_part(year,startdate) in (2018,2020,2019,2021)
/*group by years*/
--group by dw_member_id
--order by startdate
;

select count(*) from (
select distinct dw_member_id
from utilization
where udf16 = 'In-Scope'
and primaryorspecialityofficevisit = 'Primary Care Office Visit'
and date_part(year,startdate) = 2021
and dw_member_id IN (
    select distinct dw_member_id
from membermonths
where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
and udf16id = 'In-Scope'
    )
--group by dw_member_id
--order by startdate
);


select count(distinct dw_member_id) from (
select distinct dw_member_id, primaryorspecialityofficevisit
from utilization
where (dw_member_id NOT IN (
    select distinct dw_member_id
from utilization
where udf16 = 'In-Scope'
and primaryorspecialityofficevisit = 'Primary Care Office Visit'
and date_part(year,startdate) = 2021
and dw_member_id IN (
    select distinct dw_member_id
from membermonths
where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
and udf16id = 'In-Scope'
    )
    )
AND dw_member_id IN (
    select distinct dw_member_id
from membermonths
where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
and udf16id = 'In-Scope'
    ))
and udf16 = 'In-Scope'
--and primaryorspecialityofficevisit = 'Primary Care Office Visit'
and date_part(year,startdate) = 2021);


select distinct dw_member_id, mbr_age_range, membergenderid--,udf18id
from membermonths
where dw_member_id IN (
    select distinct dw_member_id
from utilization
where (dw_member_id NOT IN (
    select distinct dw_member_id
from utilization
where udf16 = 'In-Scope'
and primaryorspecialityofficevisit = 'Primary Care Office Visit'
and date_part(year,startdate) = 2021
and dw_member_id IN (
    select distinct dw_member_id
from membermonths
where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
and udf16id = 'In-Scope'
    )
    )
AND dw_member_id IN (
    select distinct dw_member_id
from membermonths
where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
and udf16id = 'In-Scope'
    ))
and udf16 = 'In-Scope'
--and primaryorspecialityofficevisit = 'Primary Care Office Visit'
and date_part(year,startdate) = 2021)
and date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
and udf16id = 'In-Scope';



select distinct dw_member_id, mbr_age_range, membergenderid--,udf18id
from membermonths
where dw_member_id NOT IN (
    select distinct dw_member_id
from utilization
where (dw_member_id NOT IN (
    select distinct dw_member_id
from utilization
where udf16 = 'In-Scope'
and primaryorspecialityofficevisit = 'Primary Care Office Visit'
and date_part(year,startdate) = 2021
and dw_member_id IN (
    select distinct dw_member_id
from membermonths
where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
and udf16id = 'In-Scope'
    )
    )
AND dw_member_id IN (
    select distinct dw_member_id
from membermonths
where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
and udf16id = 'In-Scope'
    ))
and udf16 = 'In-Scope'
--and primaryorspecialityofficevisit = 'Primary Care Office Visit'
and date_part(year,startdate) = 2021
UNION ALL
select distinct dw_member_id
from utilization
where udf16 = 'In-Scope'
and primaryorspecialityofficevisit = 'Primary Care Office Visit'
and date_part(year,startdate) = 2021
and dw_member_id IN (
    select distinct dw_member_id
from membermonths
where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
and udf16id = 'In-Scope'
    ))
and date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
and udf16id = 'In-Scope';

select distinct primaryorspecialityofficevisit, utilizationcategory, utilizationtype
from utilization;

---- vPCP by month by state

select date_part(month,startdate) as start_date, count(distinct dw_member_id)
from utilization
where (dw_member_id IN (
    select distinct dw_member_id
from utilization
where udf16 = 'In-Scope'
and primaryorspecialityofficevisit = 'Primary Care Office Visit'
--and date_part(year,startdate) = 2021
and dw_member_id IN (
    select distinct dw_member_id
from membermonths
--where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
where udf16id = 'In-Scope'
    )
    )
AND dw_member_id IN (
    select distinct dw_member_id
from membermonths
--where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
where udf16id = 'In-Scope'
    ))
and udf16 = 'In-Scope'
--and primaryorspecialityofficevisit = 'Primary Care Office Visit'
and date_part(year,startdate) = 2021;




select to_date(date_trunc('month',startdate), 'YYYY-MM') as start_date,memberstate, count(distinct dw_member_id) as member_cnt, count(distinct visitid) as visit_cnt
from utilization
where udf16 = 'In-Scope'
and relationshipcode = 'E'
and primaryorspecialityofficevisit = 'Primary Care Office Visit'
--and utilizationtype IN ('Mental Health Office Visits', 'Substance Abuse Office Visits')
--and date_part(year,startdate) = 2021
and dw_member_id IN (
    select distinct dw_member_id
from membermonths
--where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) IN (2021)
where udf16id = 'In-Scope'
    )
group by memberstate, date_trunc('month',startdate)
order by memberstate, date_trunc('month',startdate);



------------------------------------------------------- UAL Utilization
--find active members
select top 15 distinct dw_member_id
from stage1_acl_una_extract.membermonths
where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) between 2018 and 2021
and dw_member_id NOT IN (select dw_member_id from active_mem);

create temp table active_mem as
select distinct dw_member_id
from stage1_acl_una_extract.membermonths
where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) between 2018 and 2021
and udf17id = 'Active';

---find cnt of membermonths
select date_part(year,to_date(activemonth,'YYYY/MM/DD')) as years, count(distinct dw_member_id) as member_months
from stage1_acl_una_extract.membermonths
where date_part(year,to_date(activemonth, 'YYYY/MM/DD')) between 2018 and 2021
and udf17id = 'Active'
group by years;

select distinct primaryorspecialityofficevisit from stage1_acl_una_extract.utilization;
----- find visits
drop table if exists visit_cnts;
create temp table visit_cnts as
select date_part(year,to_date(startdate,'YYYY/MM/DD')) as years,utilization.dw_member_id, case when primaryorspecialityofficevisit = 'Primary Care Office Visit' then 'pcp' when
primaryorspecialityofficevisit = 'Specialist Office Visit' then 'specialist' else 'other' end as doc_type, count(concat(utilization.dw_member_id,visitid)) as visit_cnt,
       primarydiagnosisgrouperdesc as icd_desc, mbr_age_range as age_rng, memberstate, prv_specialty_2_desc as prov_type, case when (udf16 = 'In-Scope' AND
          udf21 IN ('IAH', 'NHC', 'HSC', 'HOU', 'HQS', 'HQJ') AND
          NOT (udf23 ilike 'pilot')) then 'Pilot' else 'No' end as pilot
from stage1_acl_una_extract.utilization
where dw_member_id IN (select dw_member_id from active_mem)
and doc_type != 'other'
and date_part(year,to_date(startdate, 'YYYY/MM/DD')) between 2018 and 2021
and udf17 = 'Active'
group by years, utilization.dw_member_id,doc_type,icd_desc, age_rng, memberstate,prov_type,pilot
order by dw_member_id,years;

drop table if exists no_visit_cnts;
create temp table no_visit_cnts as
select date_part(year,to_date(activemonth,'YYYY/MM/DD')) as years,dw_member_id, memberstate, udf119 as age_rng, 0 as visit_cnt, NULL as doc_type, NULL as icd_desc, NULL as prov_type, case when udf21id = 'IAH' then 'Pilot' else 'No' end as pilot
from stage1_acl_una_extract.membermonths
where (dw_member_id IN (select dw_member_id from active_mem)
AND dw_member_id NOT IN (select dw_member_id from visit_cnts))
AND date_part(year,to_date(activemonth, 'YYYY/MM/DD')) between 2018 and 2021
group by years, dw_member_id, doc_type, icd_desc, age_rng, memberstate,pilot,prov_type;

create temp table UAL_visits as
select years, dw_member_id, doc_type, visit_cnt, icd_desc, age_rng, memberstate, prov_type, pilot
from visit_cnts
UNION ALL
select years, dw_member_id, doc_type, visit_cnt, icd_desc, age_rng, memberstate, prov_type, pilot
from no_visit_cnts;



select *
from visit_cnts;

------------ find pcp vs spec
drop table if exists visit_cnts_new;
create temp table visit_cnts_new as
select date_part(year,to_date(startdate,'YYYY/MM/DD')) as years,utilization.dw_member_id, case when primaryorspecialityofficevisit = 'Primary Care Office Visit' then 'pcp' when
primaryorspecialityofficevisit = 'Specialist Office Visit' then 'specialist' else 'other' end as doc_type, count(concat(utilization.dw_member_id,visitid)) as visit_cnt, case when (udf16 = 'In-Scope' AND
          udf21 IN ('IAH', 'NHC', 'HSC', 'HOU', 'HQS', 'HQJ') AND
          NOT (udf23 ilike 'pilot')) then 'Pilot' else 'No' end as pilot
from stage1_acl_una_extract.utilization
where dw_member_id IN (select dw_member_id from active_mem)
and doc_type != 'other'
and date_part(year,to_date(startdate, 'YYYY/MM/DD')) between 2018 and 2021
and udf17 = 'Active'
group by years, utilization.dw_member_id,doc_type,pilot
order by dw_member_id,years;


select *
from visit_cnts_new;