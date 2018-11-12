--------------------------------------------------------
--  DDL for View AUTO_INS_LOG_DISPLAY
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "AUTO_INS_LOG_DISPLAY" ("OPERATION_CODE", "NAME", "ENTITY_ID", "DATE_OPERATION", "TEXT_ERROR", "ID") AS 
  select
operation_code,
aile.NAME,
ail.ENTITY_ID,
to_char(date_operation, 'dd.mm.yyyy hh24:mi:ss') date_operation,
text_error,
ail.id
from auto_ins_log ail
inner join auto_ins_log_entity aile on aile.ID = ail.AUTO_INS_LOG_ENTITY_ID
order by ail.id desc;
