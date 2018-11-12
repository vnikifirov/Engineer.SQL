--------------------------------------------------------
--  DDL for Package ACTIVATION
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "ACTIVATION" AS 
  procedure CREATE_USER_CONFIRMATION(p_user_name SECURITY_USER.USER_NAME%TYPE, P_CONFIRMATION_CODE USER_CONFIRMATION.CONFIRMATION_CODE%TYPE);
  procedure CHECK_USER_CONFIRMATION(p_user_name SECURITY_USER.USER_NAME%TYPE, p_confirmation_code USER_CONFIRMATION.CONFIRMATION_CODE%TYPE, p_max_activation_old number, out_result out number);

END ACTIVATION;

/
