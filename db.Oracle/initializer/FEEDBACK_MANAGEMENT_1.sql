--------------------------------------------------------
--  DDL for Package Body FEEDBACK_MANAGEMENT
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "FEEDBACK_MANAGEMENT" is

  procedure GET_FEEDBACK_REQUESTS(
    P_FEEDBACK_STATUS_ID  in feedback_request.feedback_status_id%type,
    P_DATA                out sys_refcursor)
  is
  begin
    
    open p_data for
    select fr.feedback_request_id,
           fr.created_by,
           fr.created,
           fr.subject,
           fr.description,
           fr.feedback_status_id,
           nvl2(fr.url, 1, 0) as has_url,
           decode(dbms_lob.getlength(fr.image), 0, 0, 1) as has_image,
           nvl2(fr.response, 1, 0) as has_response
    from feedback_request fr
    where P_FEEDBACK_STATUS_ID is null or 
          fr.feedback_status_id = P_FEEDBACK_STATUS_ID;
        
  end GET_FEEDBACK_REQUESTS;
  
  procedure GET_FEEDBACK_REQUEST_IMAGE(
    P_ID    in feedback_request.feedback_request_id%type,
    P_IMAGE out feedback_request.image%type)
  is
    v_count number;
  begin
  
    select count(*) into v_count
    from feedback_request fr
    where fr.feedback_request_id = p_id;
    
    if (v_count = 0) then
      raise_application_error(-20001, 'Feedback request with Id = ' || P_ID || ' does not found.'); 
    end if;
    
    select fr.image 
    into p_image
    from feedback_request fr
    where fr.feedback_request_id = p_id; 
  
  end GET_FEEDBACK_REQUEST_IMAGE;  
  
  procedure INSERT_FEEDBACK_REQUEST(
    P_CREATED_BY          in  feedback_request.created_by%type,
    P_SUBJECT             in  feedback_request.subject%type,
    P_DESCRIPTION         in  feedback_request.description%type,
    P_URL                 in  feedback_request.url%type,
    P_IMAGE               in  feedback_request.image%type)
  is 
  begin
      
    insert into feedback_request(
                    feedback_request_id,
                    created_by,
                    created,
                    subject,
                    description,
                    url,
                    image,
                    feedback_status_id)
    values (s_feedback_request.nextval,
            P_CREATED_BY,
            sysdate,
            P_SUBJECT,
            P_DESCRIPTION,
            P_URL,
            P_IMAGE,
            1);                  
  
  end INSERT_FEEDBACK_REQUEST;
  
  procedure UPDATE_FEEDBACK_REQUEST(
    P_ID                  in  feedback_request.feedback_request_id%type,
    P_STATUS              in  feedback_request.feedback_status_id%type,
    P_RESPONSE            in  feedback_request.response%type)  
  is
    v_count number;   
  begin
    
    select count(*) into v_count
    from feedback_request fr
    where fr.feedback_request_id = p_id;
    
    if (v_count = 0) then
      raise_application_error(-20001, 'Feedback request with Id = ' || P_ID || ' does not found.'); 
    end if;  
    
    update feedback_request fr
    set fr.feedback_status_id = P_STATUS,
        fr.response = P_RESPONSE
    where fr.feedback_request_id = P_ID;        
  
  end UPDATE_FEEDBACK_REQUEST; 
  
  procedure DELETE_FEEDBACK_REQUESTS(
    P_IDS                 in  tbl_feedback_ids)
  is
    v_feedback_ids table_of_number := table_of_number();
    v_feedback_id feedback_request.feedback_request_id%type;
    v_cnt number := 0;  
  begin
    
    for i in P_IDS.first..P_IDS.last loop
      v_feedback_ids.extend();
      v_feedback_ids(i) := P_IDS(i);
    end loop;
     
    select count(ids.column_value), min(ids.column_value)
    into v_cnt, v_feedback_id
    from feedback_request fr
    inner join (select * from table(v_feedback_ids)) ids on ids.column_value = fr.feedback_request_id
    where fr.feedback_request_id is null;

    if (v_cnt > 0) then
       raise_application_error(-20001, 'Feedback request with Id = ' || v_feedback_id || ' does not found.');
    end if;
     
    delete from feedback_request
    where feedback_request_id in (select * from table (v_feedback_ids));
    
  end DELETE_FEEDBACK_REQUESTS;   
  
  procedure GET_FEEDBACK_REQUEST(
    P_ID                  in  feedback_request.feedback_request_id%type,
    P_DATA                out sys_refcursor)
  is 
  begin
        
    open p_data for 
    select fr.feedback_request_id,
           fr.created_by,
           fr.created,
           fr.subject,
           fr.description,
           fr.url,
           fr.image,
           fr.response,
           fr.feedback_status_id
    from feedback_request fr
    where fr.feedback_request_id = p_id;  
  
  end GET_FEEDBACK_REQUEST;  
  
  procedure GET_FEEDBACK_PERMISSIONS(
    P_FEEDBACK_STATUS_ID  in feedback_permission.feedback_status_id%type,
    P_DATA                out sys_refcursor)
  is
  begin
    
    open p_data for 
    select fp.feedback_permission_id,
           fp.created_by,
           fp.created,
           fp.permission,
           fp.reason,
           fp.response,
           fp.feedback_status_id 
    from feedback_permission fp
    where P_FEEDBACK_STATUS_ID is null or
          P_FEEDBACK_STATUS_ID = fp.feedback_status_id;    
  
  end GET_FEEDBACK_PERMISSIONS;
  
  procedure INSERT_FEEDBACK_PERMISSION(
    P_CREATED_BY          in  feedback_permission.created_by%type,
    P_PERMISSION          in  feedback_permission.permission%type,
    P_REASON              in  feedback_permission.reason%type)
  is
  begin
    
    insert into feedback_permission(
                          feedback_permission_id,
                          created_by,
                          created,
                          permission,
                          reason,
                          feedback_status_id)
    values(s_feedback_permission.nextval,
           P_CREATED_BY,
           sysdate,
           P_PERMISSION,
           P_REASON,
           1);                     
     
  end INSERT_FEEDBACK_PERMISSION; 
  
  procedure UPDATE_FEEDBACK_PERMISSION(
    P_ID                  in  feedback_permission.feedback_permission_id%type,
    P_STATUS              in  feedback_permission.feedback_status_id%type,
    P_RESPONSE            in  feedback_permission.response%type)
  is 
    v_count number;
  begin
    
    select count(*) into v_count
    from feedback_permission fp
    where fp.feedback_permission_id = p_id;
    
    if (v_count = 0) then
      raise_application_error(-20001, 'Feedback permission with Id = ' || P_ID || ' does not found.'); 
    end if;
    
    update feedback_permission fp
    set fp.feedback_status_id = P_STATUS,
        fp.response = P_RESPONSE
    where fp.feedback_permission_id = P_ID;    
    
  end UPDATE_FEEDBACK_PERMISSION;
  
  procedure DELETE_FEEDBACK_PERMISSIONS(
    P_IDS                 in  tbl_permission_request_ids)
  is
    v_feedback_ids table_of_number := table_of_number();
    v_feedback_id feedback_permission.feedback_permission_id%type;
    v_cnt number := 0;
  begin
    
    for i in P_IDS.first..P_IDS.last loop
      v_feedback_ids.extend();
      v_feedback_ids(i) := P_IDS(i);
    end loop;
      
    select count(ids.column_value), min(ids.column_value)
    into v_cnt, v_feedback_id
    from feedback_permission fp
    inner join (select * from table(v_feedback_ids)) ids on ids.column_value = fp.feedback_permission_id
    where fp.feedback_permission_id is null;
    
    if (v_cnt > 0) then
      raise_application_error(-20001, 'Feedback permission with Id = ' || v_feedback_id || ' does not found.');
    end if;
    
    delete from feedback_permission fp
    where fp.feedback_permission_id in (select * from table (v_feedback_ids));
     
  end DELETE_FEEDBACK_PERMISSIONS; 
  
  procedure GET_FEEDBACK_PERMISSION(
    P_ID                  in  feedback_permission.feedback_permission_id%type,
    P_DATA                out sys_refcursor)
  is
  begin
    
    open p_data for 
    select fp.feedback_permission_id,
           fp.created_by,
           fp.created,
           fp.permission,
           fp.reason,
           fp.response,
           fp.feedback_status_id
    from feedback_permission fp
    where fp.feedback_permission_id = p_id; 
  
  end GET_FEEDBACK_PERMISSION;                                
    
end FEEDBACK_MANAGEMENT;

/
