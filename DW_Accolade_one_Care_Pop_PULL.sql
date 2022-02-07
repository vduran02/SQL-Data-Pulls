------ UAL Accolade One Population
SELECT DISTINCT dw_member_id FROM stage1_acl_una_extract.member WHERE
          udf16 = 'In-Scope' AND
          udf21 IN ('IAH', 'NHC', 'HSC', 'HOU', 'HQS', 'HQJ') AND
          udf23 not ilike '%pilot%' AND
        udf17 ilike 'Active'
        and (udf17 not ilike '%COBRA%' and udf17 not ilike '%Retiree%')
        and (currentstatus = 'Active' or (currentstatus = 'Termed'
        and terminationdate >= '2022-01-01'))



-------Metasource Accolade One Population
SELECT DISTINCT dw_member_id FROM stage1_acl_msr_extract.member
WHERE terminationdate >= '2021-12-31'
    ---and memberage >= 18
