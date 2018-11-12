--------------------------------------------------------
--  DDL for Package Body AUTO_INS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "AUTO_INS" AS

procedure GET_AUTO_INS_LOG_BY_ENTITY(p_entity_name  AUTO_INS_LOG_ENTITY.NAME%TYPE, p_entity_id  AUTO_INS_LOG_ENTITY.ID%TYPE, cur_out out sys_refcursor)
AS
BEGIN
  open cur_out for select * from AUTO_INS_LOG where p_entity_id = ENTITY_ID and AUTO_INS_LOG_ENTITY_ID IN (select ID from AUTO_INS_LOG_ENTITY where LOWER(p_entity_name) = LOWER(AUTO_INS_LOG_ENTITY.NAME))
  order by DATE_OPERATION desc;
END;

procedure CREATE_AUTO_INS_LOG_ENTITY(p_name AUTO_INS_LOG_ENTITY.NAME%TYPE, p_id out AUTO_INS_LOG_ENTITY.ID%TYPE)
AS
BEGIN
  insert into AUTO_INS_LOG_ENTITY(ID, NAME) 
  values(S_AUTO_INS_LOG_ENTITY.NEXTVAL, p_name)
  returning ID into p_id;
  commit;
END;

procedure GET_AUTO_INS_LOG_ENTITY_ID(p_name AUTO_INS_LOG_ENTITY.NAME%TYPE, cur_out out sys_refcursor)
AS
BEGIN
  open cur_out for select ID from AUTO_INS_LOG_ENTITY where LOWER(p_name) = LOWER(AUTO_INS_LOG_ENTITY.NAME);
END;

procedure CREATE_AUTO_INS_LOG( 
    p_entity_id AUTO_INS_LOG.AUTO_INS_LOG_ENTITY_ID%TYPE,
    p_object_id AUTO_INS_LOG.ENTITY_ID%TYPE,
    p_operation_code AUTO_INS_LOG.OPERATION_CODE%TYPE,
    p_operation_date DATE,
    p_xml_request AUTO_INS_LOG.XML_REQUEST%TYPE,
    p_id out AUTO_INS_LOG.ID%TYPE
  )
  AS
  begin
    insert into AUTO_INS_LOG(ID, AUTO_INS_LOG_ENTITY_ID, ENTITY_ID, OPERATION_CODE, DATE_OPERATION, XML_REQUEST, TEXT_ERROR, XML_RESPONSE)
    values (S_AUTO_INS_LOG.NEXTVAL, p_entity_id, p_object_id, p_operation_code, p_operation_date, p_xml_request, '','loading')
    returning id into p_id;
    commit;
  end;

  procedure UPDATE_AUTO_INS_LOG( 
    p_id AUTO_INS_LOG.ID%TYPE,
    p_xml_response AUTO_INS_LOG.XML_RESPONSE%TYPE,
    p_text_error AUTO_INS_LOG.TEXT_ERROR%TYPE
  )
  AS
  begin
    update AUTO_INS_LOG set AUTO_INS_LOG.XML_RESPONSE = p_xml_response, AUTO_INS_LOG.TEXT_ERROR = p_text_error where AUTO_INS_LOG.ID = p_id;
    commit;
  end;

  procedure GET_DRIVER_KBM(p_driver_id KBM.DRIVER_ID%TYPE, cur_out out sys_refcursor) AS
  BEGIN
    open cur_out for select * from KBM where driver_id = p_driver_id;
  END GET_DRIVER_KBM;
  
  procedure GET_POLICY_KBM(p_policy_id KBM.POLICY_ID%TYPE, cur_out out sys_refcursor)
  as
  BEGIN
    open cur_out for select * from KBM where policy_id = p_policy_id;
  END GET_POLICY_KBM;
  
  procedure GET_PERSON_KBM(p_person_id PERSON.PERSON_ID%TYPE, cur_out out sys_refcursor)
  as
  BEGIN
    open cur_out for
    select * from KBM k
    inner join PERSON p
      on p.kbm_id = k.id
    where p.PERSON_ID = p_person_id;
  END GET_PERSON_KBM;

  
  procedure SAVE_KBM( 
    p_driver_id KBM.DRIVER_ID%TYPE,
    p_policy_id KBM.POLICY_ID%TYPE,
    p_kbm_ratio KBM.RATIO%TYPE,
    p_kbm_calc_date KBM.CALC_DATE%TYPE,
    p_kbm_calc_code KBM.CALC_CODE%TYPE,
    p_kbm_class KBM.CLASS%TYPE,
    p_loss_count KBM.LOSS_COUNT%TYPE,
    p_id out KBM.ID%TYPE
  )
  AS
  begin
    insert into KBM(ID, DRIVER_ID, RATIO, CALC_DATE, CALC_CODE, CLASS, loss_count, policy_id)
    values (S_KBM.NEXTVAL, p_driver_id, p_kbm_ratio, p_kbm_calc_date, p_kbm_calc_code, p_kbm_class, p_loss_count, p_policy_id)
    returning id into p_id;
    commit;
  end;
  
  procedure SAVE_DRIVER_KBM(
    p_driver_id KBM.DRIVER_ID%TYPE,
    p_kbm_ratio KBM.RATIO%TYPE,
    p_kbm_calc_date KBM.CALC_DATE%TYPE,
    p_kbm_calc_code KBM.CALC_CODE%TYPE,
    p_kbm_class KBM.CLASS%TYPE,
    p_id out KBM.ID%TYPE
  )
  AS
  begin
    SAVE_KBM(p_driver_id, null, p_kbm_ratio, p_kbm_calc_date, p_kbm_calc_code, p_kbm_class, 0, p_id);
  end;

  procedure UPDATE_PERSON_KBM (
    p_person_id PERSON.PERSON_ID%TYPE,
    p_kbm_id PERSON.KBM_ID%TYPE
  )
  AS
  BEGIN
    update PERSON set kbm_id = p_kbm_id where person_id = p_person_id;
    commit;
  END;
  
  procedure GET_KBM(p_kbm_id KBM.ID%TYPE, cur_out out sys_refcursor)
  as
  begin
    open cur_out for select * from KBM where id = p_kbm_id;
  end;


END AUTO_INS;

/
