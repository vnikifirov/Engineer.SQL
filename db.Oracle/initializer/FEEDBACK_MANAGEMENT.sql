--------------------------------------------------------
--  DDL for Package FEEDBACK_MANAGEMENT
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "FEEDBACK_MANAGEMENT" is
    
  type tbl_feedback_ids is table of feedback_request.feedback_request_id%type
    index by binary_integer;
    
  type tbl_permission_request_ids is table of feedback_permission.feedback_permission_id%type
    index by binary_integer;    
      
  procedure GET_FEEDBACK_REQUESTS(
    P_FEEDBACK_STATUS_ID  in feedback_request.feedback_status_id%type,
    P_DATA                out sys_refcursor);
    
  procedure GET_FEEDBACK_REQUEST_IMAGE(
    P_ID    in feedback_request.feedback_request_id%type,
    P_IMAGE out feedback_request.image%type); 
    
  procedure INSERT_FEEDBACK_REQUEST(
    P_CREATED_BY          in  feedback_request.created_by%type,
    P_SUBJECT             in  feedback_request.subject%type,
    P_DESCRIPTION         in  feedback_request.description%type,
    P_URL                 in  feedback_request.url%type,
    P_IMAGE               in  feedback_request.image%type); 
    
  procedure UPDATE_FEEDBACK_REQUEST(
    P_ID                  in  feedback_request.feedback_request_id%type,
    P_STATUS              in  feedback_request.feedback_status_id%type,
    P_RESPONSE            in  feedback_request.response%type);
    
  procedure DELETE_FEEDBACK_REQUESTS(
    P_IDS                 in  tbl_feedback_ids); 
    
  procedure GET_FEEDBACK_REQUEST(
    P_ID                  in  feedback_request.feedback_request_id%type,
    P_DATA                out sys_refcursor);
    
  procedure GET_FEEDBACK_PERMISSIONS(
    P_FEEDBACK_STATUS_ID  in feedback_permission.feedback_status_id%type,
    P_DATA                out sys_refcursor);
    
  procedure INSERT_FEEDBACK_PERMISSION(
    P_CREATED_BY          in  feedback_permission.created_by%type,
    P_PERMISSION          in  feedback_permission.permission%type,
    P_REASON              in  feedback_permission.reason%type);  
    
  procedure UPDATE_FEEDBACK_PERMISSION(
    P_ID                  in  feedback_permission.feedback_permission_id%type,
    P_STATUS              in  feedback_permission.feedback_status_id%type,
    P_RESPONSE            in  feedback_permission.response%type);
    
  procedure DELETE_FEEDBACK_PERMISSIONS(
    P_IDS                 in  tbl_permission_request_ids); 
    
  procedure GET_FEEDBACK_PERMISSION(
    P_ID                  in  feedback_permission.feedback_permission_id%type,
    P_DATA                out sys_refcursor);             

end FEEDBACK_MANAGEMENT;

/
