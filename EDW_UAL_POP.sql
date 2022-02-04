SELECT distinct person_id, full_name FROM rpt.work_client_view WHERE new_famid in
(SELECT DISTINCT new_famid FROM rpt.work_client_view
WHERE work_loc IN ( 'IAH', 'NHC', 'HSC', 'HOU', 'HQS', 'HQJ') AND
      union_nm NOT IN ('PT', 'SPT', 'TPT', 'FMT', 'MP', 'PI', 'PL') AND
      /*acp_mbr_flg ='1' AND*/
      group_nm = 'UAL In-Scope'
    AND /*employment_status_cd != '7' AND*/
      medicalplanname not similar to '%Cobra%|%Retiree%')
/*AND acp_mbr_flg ='1'*/
AND group_nm = 'UAL In-Scope';
