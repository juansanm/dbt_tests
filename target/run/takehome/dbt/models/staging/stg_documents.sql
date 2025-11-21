
  
  create view "takehome"."dev_staging"."stg_documents__dbt_tmp" as (
    select
    document_id,
    patient_id,
    visit_id,
    document_line,
    document_text
from "takehome"."raw"."documents"
  );
