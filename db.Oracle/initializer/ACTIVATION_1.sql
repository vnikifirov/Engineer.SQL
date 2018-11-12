--------------------------------------------------------
--  DDL for Package Body ACTIVATION
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "ACTIVATION" AS

  procedure CREATE_USER_CONFIRMATION(p_user_name SECURITY_USER.USER_NAME%TYPE, P_CONFIRMATION_CODE USER_CONFIRMATION.CONFIRMATION_CODE%TYPE) AS
    v_user_id SECURITY_USER.SECURITY_USER_ID%TYPE;
  BEGIN
    select SECURITY_USER_ID
    into v_user_id
    from SECURITY_USER
    where USER_NAME = p_user_name;
    
    delete from USER_CONFIRMATION where SECURITY_USER_ID = v_user_id;
    
    insert into USER_CONFIRMATION(user_confirmation_id, security_user_id, confirmation_code, request_date)
    values (s_user_confirmation.nextval, v_user_id, P_CONFIRMATION_CODE, sysdate);
  END CREATE_USER_CONFIRMATION;
  
  procedure CHECK_USER_CONFIRMATION(p_user_name SECURITY_USER.USER_NAME%TYPE, 
                                    p_confirmation_code USER_CONFIRMATION.CONFIRMATION_CODE%TYPE, 
                                    p_max_activation_old number, 
                                    out_result out number)
  AS
    v_count number;
    v_user_id SECURITY_USER.SECURITY_USER_ID%TYPE;
  BEGIN
    select SECURITY_USER_ID
    into v_user_id
    from SECURITY_USER
    where USER_NAME = p_user_name;

    select count(1)
    into out_result
    from USER_CONFIRMATION 
    where security_user_id = v_user_id and confirmation_code = p_confirmation_code and request_date > sysdate - p_max_activation_old;
    
  END;


END ACTIVATION;

/
