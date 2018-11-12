--------------------------------------------------------
--  DDL for Package AUTO_INS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "AUTO_INS" AS 
  
  procedure GET_AUTO_INS_LOG_BY_ENTITY(p_entity_name  AUTO_INS_LOG_ENTITY.NAME%TYPE, p_entity_id  AUTO_INS_LOG_ENTITY.ID%TYPE, cur_out out sys_refcursor);
  
  procedure GET_AUTO_INS_LOG_ENTITY_ID(p_name AUTO_INS_LOG_ENTITY.NAME%TYPE, cur_out out sys_refcursor);

procedure CREATE_AUTO_INS_LOG_ENTITY(p_name AUTO_INS_LOG_ENTITY.NAME%TYPE, p_id out AUTO_INS_LOG_ENTITY.ID%TYPE);

  procedure CREATE_AUTO_INS_LOG( 
    p_entity_id AUTO_INS_LOG.AUTO_INS_LOG_ENTITY_ID%TYPE,
    p_object_id AUTO_INS_LOG.ENTITY_ID%TYPE,
    p_operation_code AUTO_INS_LOG.OPERATION_CODE%TYPE,
    p_operation_date DATE,
    p_xml_request AUTO_INS_LOG.XML_REQUEST%TYPE,
    p_id out AUTO_INS_LOG.ID%TYPE
  );
  procedure UPDATE_AUTO_INS_LOG( 
    p_id AUTO_INS_LOG.ID%TYPE,
    p_xml_response AUTO_INS_LOG.XML_RESPONSE%TYPE,
    p_text_error AUTO_INS_LOG.TEXT_ERROR%TYPE
  );
  procedure GET_DRIVER_KBM(p_driver_id KBM.DRIVER_ID%TYPE, cur_out out sys_refcursor);
  procedure GET_POLICY_KBM(p_policy_id KBM.POLICY_ID%TYPE, cur_out out sys_refcursor);
  procedure GET_PERSON_KBM(p_person_id PERSON.PERSON_ID%TYPE, cur_out out sys_refcursor);
  procedure SAVE_KBM(
    p_driver_id KBM.DRIVER_ID%TYPE,
    p_policy_id KBM.POLICY_ID%TYPE,
    p_kbm_ratio KBM.RATIO%TYPE,
    p_kbm_calc_date KBM.CALC_DATE%TYPE,
    p_kbm_calc_code KBM.CALC_CODE%TYPE,
    p_kbm_class KBM.CLASS%TYPE,
    p_loss_count KBM.LOSS_COUNT%TYPE,
    p_id out KBM.ID%TYPE
  );
  procedure SAVE_DRIVER_KBM(
    p_driver_id KBM.DRIVER_ID%TYPE,
    p_kbm_ratio KBM.RATIO%TYPE,
    p_kbm_calc_date KBM.CALC_DATE%TYPE,
    p_kbm_calc_code KBM.CALC_CODE%TYPE,
    p_kbm_class KBM.CLASS%TYPE,
    p_id out KBM.ID%TYPE
  );
  
  procedure UPDATE_PERSON_KBM (
    p_person_id PERSON.PERSON_ID%TYPE,
    p_kbm_id PERSON.KBM_ID%TYPE
  );
  
    procedure GET_KBM(p_kbm_id KBM.ID%TYPE, cur_out out sys_refcursor);
END AUTO_INS;

/
