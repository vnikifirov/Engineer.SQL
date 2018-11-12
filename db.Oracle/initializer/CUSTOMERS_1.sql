--------------------------------------------------------
--  DDL for Package Body CUSTOMERS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "CUSTOMERS" AS

  procedure GET_PERSONAL_DOCUMENT_TYPES(cur_out out sys_refcursor) AS
  BEGIN
    open cur_out for 
    select * from PERSONAL_DOCUMENT_TYPE;
  END GET_PERSONAL_DOCUMENT_TYPES;
  
  procedure GET_CUSTOMER_BY_MSISDN(p_msisdn varchar2, cur_out out sys_refcursor)
  AS
  BEGIN
    open cur_out for
    select *
    from CUSTOMER c
    inner join SECURITY_USER su on su.SECURITY_USER_ID = c.SECURITY_USER_ID
    where su.USER_NAME = p_msisdn;
  END;
  
  procedure GET_PERSON(p_person_id PERSON.PERSON_ID%TYPE, cur_out out sys_refcursor)
  AS
  BEGIN
    open cur_out for
    select * from PERSON
    where person_id = p_person_id;
  END;
  
  procedure GET_PHYSICAL_PERSON(p_person_id PHYSICAL_PERSON.PERSON_ID%TYPE, cur_out out sys_refcursor)
  AS
  begin
    open cur_out for
      select * from PHYSICAL_PERSON where person_id = p_person_id;
  end;
  
  procedure GET_JURIDICAL_PERSON(p_person_id JURIDICAL_PERSON.PERSON_ID%TYPE, cur_out out sys_refcursor)
  AS
  begin
    open cur_out for
      select * from JURIDICAL_PERSON where person_id = p_person_id;
  end;
  
  procedure GET_PERSONAL_DOCUMENT(p_personal_document_id PERSONAL_DOCUMENT.PERSONAL_DOCUMENT_ID%TYPE, cur_out out sys_refcursor)
  AS
  BEGIN
    open cur_out for
    select * from PERSONAL_DOCUMENT
    where PERSONAL_DOCUMENT_ID = p_personal_document_id;
  END;

  procedure GET_PERSONAL_DOCUMENT_TYPE(p_personal_document_type_id PERSONAL_DOCUMENT_TYPE.ID%TYPE, cur_out out sys_refcursor)
  AS
  BEGIN
    open cur_out for
    select * from PERSONAL_DOCUMENT_TYPE
    where ID = p_personal_document_type_id;
  END;
  
  procedure GET_PERSON_REGISTRATION(p_person_registration_id PERSON_REGISTRATION.PERSON_REGISTRATION_ID%TYPE, cur_out out sys_refcursor)
  AS
  BEGIN
    open cur_out for
    select * from PERSON_REGISTRATION
    where PERSON_REGISTRATION_ID = p_person_registration_id;
  END;
  
  PROCEDURE CREATE_PHYSICAL_PERSON(
    p_person_id PHYSICAL_PERSON.PERSON_ID%TYPE,
    p_first_name PHYSICAL_PERSON.FIRST_NAME%TYPE,
    p_second_name PHYSICAL_PERSON.SECOND_NAME%TYPE,
    p_last_name PHYSICAL_PERSON.LAST_NAME%TYPE,
    p_birth_day PHYSICAL_PERSON.BIRTH_DAY%TYPE,
    p_citizenship PHYSICAL_PERSON.CITIZENSHIP%TYPE,
    p_gender PHYSICAL_PERSON.GENDER%TYPE,
    p_is_entrepreneur PHYSICAL_PERSON.IS_ENTREPRENEUR%TYPE,
    p_personal_document_id PHYSICAL_PERSON.PERSONAL_DOCUMENT_ID%TYPE)
  IS
  BEGIN
    insert into PHYSICAL_PERSON (
      PERSON_ID,
      FIRST_NAME,
      SECOND_NAME,
      LAST_NAME,
      IS_ENTREPRENEUR,
      GENDER,
      CITIZENSHIP,
      BIRTH_DAY,
      PERSONAL_DOCUMENT_ID
    )
    VALUES
    (
      p_person_id,
      p_first_name,
      p_second_name,
      p_last_name,
      p_is_entrepreneur,
      p_gender,
      p_citizenship,
      p_birth_day,
      p_personal_document_id      
    );
    commit;
  END;
  
  PROCEDURE CREATE_JURIDICAL_PERSON(
    p_person_id JURIDICAL_PERSON.PERSON_ID%TYPE,
    p_is_resident JURIDICAL_PERSON.IS_RESIDENT%TYPE,
    p_organization_name JURIDICAL_PERSON.ORGANIZATION_NAME%TYPE,
    p_doc_series JURIDICAL_PERSON.DOC_SERIES%TYPE,
    p_doc_number JURIDICAL_PERSON.DOC_NUMBER%TYPE,
    p_vatin JURIDICAL_PERSON.VATIN%TYPE)
  as
  begin
    insert into JURIDICAL_PERSON (
      PERSON_ID,
      IS_RESIDENT,
      ORGANIZATION_NAME,
      DOC_SERIES,
      DOC_NUMBER,
      VATIN)
    values (
      p_person_id,
      p_is_resident,
      p_organization_name,
      p_doc_series,
      p_doc_number,
      p_vatin);
    commit;
  end;

  
  PROCEDURE CREATE_PERSON(
    p_person_type PERSON.PERSON_TYPE%TYPE,
    p_email PERSON.EMAIL%TYPE,
    p_person_registration_id PERSON.PERSON_REGISTRATION_ID%TYPE,
    p_id out PERSON.PERSON_ID%TYPE)
  IS
  BEGIN
    insert into PERSON (
      PERSON_ID,
      PERSON_TYPE,
      EMAIL,
      PERSON_REGISTRATION_ID)
    VALUES
    (
      S_PERSON.NEXTVAL,
      p_person_type,
      p_email,
      p_person_registration_id    
    ) returning person_id into p_id;
  END;

  PROCEDURE CREATE_PERSON_REGISTRATION(
    p_start_date PERSON_REGISTRATION.START_DATE%TYPE,
    p_end_date PERSON_REGISTRATION.END_DATE%TYPE,
    p_country_id PERSON_REGISTRATION.COUNTRY_ID%TYPE,
    p_region_code PERSON_REGISTRATION.REGION_CODE%TYPE,
    p_city_code PERSON_REGISTRATION.CITY_CODE%TYPE,
    p_street_code PERSON_REGISTRATION.STREET_CODE%TYPE,
    p_building PERSON_REGISTRATION.BUILDING%TYPE,
    p_housing PERSON_REGISTRATION.HOUSING%TYPE,
    p_appartment PERSON_REGISTRATION.APT%TYPE,
    out_registration_id out PERSON_REGISTRATION.PERSON_REGISTRATION_ID%TYPE)
  IS
  BEGIN
    insert into PERSON_REGISTRATION(
      PERSON_REGISTRATION_ID, 
      START_DATE,
      END_DATE,
      COUNTRY_ID,
      REGION_CODE,
      CITY_CODE,
      STREET_CODE,
      BUILDING,
      HOUSING,
      APT
    )
    values (
    S_PERSON_REGISTRATION.NEXTVAL,
    p_start_date,
    p_end_date,
    p_country_id,
    p_region_code,
    p_city_code,
    p_street_code,
    p_building,
    p_housing,
    p_appartment)
    returning PERSON_REGISTRATION_ID into out_registration_id;
    commit;
  END;
    
  PROCEDURE CREATE_PERSONAL_DOCUMENT(
    p_doc_number PERSONAL_DOCUMENT.DOC_NUMBER%TYPE,
    p_doc_series PERSONAL_DOCUMENT.DOC_SERIES%TYPE,
    p_doc_type_id PERSONAL_DOCUMENT.PERSONAL_DOCUMENT_TYPE_ID%TYPE,
    p_issue_date PERSONAL_DOCUMENT.ISSUE_DATE%TYPE,
    out_doc_id out PERSONAL_DOCUMENT.PERSONAL_DOCUMENT_ID%TYPE)
  IS
  BEGIN
    insert into PERSONAL_DOCUMENT(
      PERSONAL_DOCUMENT_ID,
      PERSONAL_DOCUMENT_TYPE_ID,
      DOC_SERIES,
      DOC_NUMBER,
      ISSUE_DATE)
    values (
      S_PERSONAL_DOCUMENT.NEXTVAL, 
      p_doc_type_id,
      p_doc_series,
      p_doc_number,
      p_issue_date)
    returning PERSONAL_DOCUMENT_ID into out_doc_id;
    commit;
  END;
  
PROCEDURE CREATE_PERSONAL_DOCUMENT(
    p_doc_number PERSONAL_DOCUMENT.DOC_NUMBER%TYPE,
    p_doc_series PERSONAL_DOCUMENT.DOC_SERIES%TYPE,
    p_doc_type_id PERSONAL_DOCUMENT.PERSONAL_DOCUMENT_TYPE_ID%TYPE,
    p_issue_date PERSONAL_DOCUMENT.ISSUE_DATE%TYPE,
    p_doc_issuer PERSONAL_DOCUMENT.DOC_ISSUER%TYPE,
    out_doc_id out PERSONAL_DOCUMENT.PERSONAL_DOCUMENT_ID%TYPE)
  IS
  BEGIN
    insert into PERSONAL_DOCUMENT(
      PERSONAL_DOCUMENT_ID,
      PERSONAL_DOCUMENT_TYPE_ID,
      DOC_SERIES,
      DOC_NUMBER,
      ISSUE_DATE,
      DOC_ISSUER)
    values (
      S_PERSONAL_DOCUMENT.NEXTVAL, 
      p_doc_type_id,
      p_doc_series,
      p_doc_number,
      p_issue_date,
      p_doc_issuer)
    returning PERSONAL_DOCUMENT_ID into out_doc_id;
    commit;
  END;
  
  PROCEDURE ASSIGN_VEHICLE_TO_CUSTOMER(
    p_customer_id CUSTOMER.CUSTOMER_ID%TYPE,
    p_vehicle_id VEHICLE.ID%TYPE)
  AS
  BEGIN
    update CUSTOMER_VEHICLE
    set end_date = sysdate
    where VEHICLE_ID = p_vehicle_id;
    
    insert into CUSTOMER_VEHICLE(customer_id, vehicle_id)
    values (p_customer_id, p_vehicle_id);
    commit;
  END;
  
  procedure SET_CUSTOMER_PERSONAL(
    p_customer_id CUSTOMER.CUSTOMER_ID%TYPE,  
    p_person_id PERSON.PERSON_ID%TYPE)
  as
  begin
    update CUSTOMER set PERSON_ID = p_person_id where CUSTOMER_ID = p_customer_id;
    commit;
  end;
  
  PROCEDURE UPDATE_PERSON(
    p_person_id PERSON.PERSON_ID%TYPE,
    p_email PERSON.EMAIL%TYPE)
  as
  begin
    update person set email = p_email
    where person_id = p_person_id and UPPER(email) <> UPPER(p_email);
    commit;
  end;

  PROCEDURE UPDATE_PHYSICAL_PERSON(
    p_person_id PHYSICAL_PERSON.PERSON_ID%TYPE,
    p_first_name PHYSICAL_PERSON.FIRST_NAME%TYPE,
    p_second_name PHYSICAL_PERSON.SECOND_NAME%TYPE,
    p_last_name PHYSICAL_PERSON.LAST_NAME%TYPE,
    p_birth_day PHYSICAL_PERSON.BIRTH_DAY%TYPE,
    p_citizenship PHYSICAL_PERSON.CITIZENSHIP%TYPE,
    p_gender PHYSICAL_PERSON.GENDER%TYPE,
    p_is_entrepreneur PHYSICAL_PERSON.IS_ENTREPRENEUR%TYPE)
  as
  begin
    update PHYSICAL_PERSON
    set
      first_name = p_first_name,
      second_name = p_second_name,
      last_name = p_last_name,
      birth_day = p_birth_day,
      citizenship = p_citizenship,
      gender = p_gender,
      IS_ENTREPRENEUR = p_is_entrepreneur
    where person_id = p_person_id
      and (upper(first_name) <> upper(p_first_name)
      or upper(second_name) <> upper(p_second_name)
      or upper(last_name) <> upper(p_last_name)
      or birth_day <> p_birth_day
      or upper(citizenship) <> upper(p_citizenship)
      or gender <> p_gender
      or IS_ENTREPRENEUR <> p_is_entrepreneur);
    commit;
  end;

  PROCEDURE UPDATE_PERSONAL_DOCUMENT(
    p_personal_document_id PERSONAL_DOCUMENT.PERSONAL_DOCUMENT_ID%TYPE,
    p_doc_number PERSONAL_DOCUMENT.DOC_NUMBER%TYPE,
    p_doc_series PERSONAL_DOCUMENT.DOC_SERIES%TYPE,
    p_doc_type_id PERSONAL_DOCUMENT.PERSONAL_DOCUMENT_TYPE_ID%TYPE,
    p_issue_date PERSONAL_DOCUMENT.ISSUE_DATE%TYPE,
    p_doc_issuer PERSONAL_DOCUMENT.DOC_ISSUER%TYPE)
  as
  begin
    update PERSONAL_DOCUMENT
    set
      DOC_NUMBER = p_doc_number,
      DOC_SERIES = p_doc_series,
      PERSONAL_DOCUMENT_TYPE_ID = p_doc_type_id,
      ISSUE_DATE = p_issue_date,
      DOC_ISSUER = p_doc_issuer
    where 
      PERSONAL_DOCUMENT_ID = p_personal_document_id
      and 
      (upper(DOC_NUMBER) <> upper(p_doc_number)
      or upper(DOC_SERIES) <> upper(p_doc_series)
      or PERSONAL_DOCUMENT_TYPE_ID <> p_doc_type_id
      or ISSUE_DATE <> p_issue_date
      or DOC_ISSUER <> p_doc_issuer
      or (DOC_ISSUER is null and p_doc_issuer is not null));
      commit;
  end;
  
  PROCEDURE UPDATE_PERSONAL_DOCUMENT(
    p_personal_document_id PERSONAL_DOCUMENT.PERSONAL_DOCUMENT_ID%TYPE,
    p_doc_number PERSONAL_DOCUMENT.DOC_NUMBER%TYPE,
    p_doc_series PERSONAL_DOCUMENT.DOC_SERIES%TYPE,
    p_doc_type_id PERSONAL_DOCUMENT.PERSONAL_DOCUMENT_TYPE_ID%TYPE,
    p_issue_date PERSONAL_DOCUMENT.ISSUE_DATE%TYPE)
  as
  begin
    update PERSONAL_DOCUMENT
    set
      DOC_NUMBER = p_doc_number,
      DOC_SERIES = p_doc_series,
      PERSONAL_DOCUMENT_TYPE_ID = p_doc_type_id,
      ISSUE_DATE = p_issue_date
    where 
      PERSONAL_DOCUMENT_ID = p_personal_document_id
      and 
      (upper(DOC_NUMBER) <> upper(p_doc_number)
      or upper(DOC_SERIES) <> upper(p_doc_series)
      or PERSONAL_DOCUMENT_TYPE_ID <> p_doc_type_id
      or ISSUE_DATE <> p_issue_date);
      commit;
  end;
    
  PROCEDURE UPDATE_PERSON_REGISTRATION(
    p_person_registration_id PERSON_REGISTRATION.PERSON_REGISTRATION_ID%TYPE,
    p_start_date PERSON_REGISTRATION.START_DATE%TYPE,
    p_end_date PERSON_REGISTRATION.END_DATE%TYPE,
    p_country_id PERSON_REGISTRATION.COUNTRY_ID%TYPE,
    p_region_code PERSON_REGISTRATION.REGION_CODE%TYPE,
    p_city_code PERSON_REGISTRATION.CITY_CODE%TYPE,
    p_street_code PERSON_REGISTRATION.STREET_CODE%TYPE,
    p_building PERSON_REGISTRATION.BUILDING%TYPE,
    p_housing PERSON_REGISTRATION.HOUSING%TYPE,
    p_appartment PERSON_REGISTRATION.APT%TYPE)
  as
  begin
    update PERSON_REGISTRATION
    set
      START_DATE = p_start_date,
      END_DATE = p_end_date,
      COUNTRY_ID = p_country_id,
      REGION_code = p_region_code,
      CITY_code = p_city_code,
      STREET_CODE = p_street_code,
      BUILDING = p_building,
      HOUSING = p_housing,
      APT = p_appartment
    where PERSON_REGISTRATION_ID = p_person_registration_id and
    (
      START_DATE <> p_start_date
      or END_DATE <> p_end_date
      or COUNTRY_ID <> p_country_id
      or upper(REGION_code) <> upper(p_region_code)
      or (REGION_code is null and p_region_code is not null)
      or upper(CITY_code) <> upper(p_city_code)
      or (CITY_code is null and p_city_code is not null)
      or upper(STREET_CODE) <> upper(p_street_code)
      or (STREET_CODE is null and p_street_code is not null)
      or upper(BUILDING) <> upper(p_building)
      or upper(HOUSING) <> upper(p_housing)
      or APT <> p_appartment
    );
    commit;
  end;
  
  PROCEDURE GET_USERNAME_BY_NAME_ID(
    p_first_name PHYSICAL_PERSON.FIRST_NAME%TYPE,
    p_second_name PHYSICAL_PERSON.SECOND_NAME%TYPE,
    p_last_name PHYSICAL_PERSON.LAST_NAME%TYPE,
    p_series PERSONAL_DOCUMENT.DOC_SERIES%TYPE,
    p_number PERSONAL_DOCUMENT.DOC_NUMBER%TYPE,
    cur_out out sys_refcursor)
  is
  begin
    open cur_out for
    select *
    from SECURITY_USER su
    inner join CUSTOMER c
      on c.security_user_id = su.security_user_id
    inner join PHYSICAL_PERSON pp
      on pp.person_id = c.person_id
    inner join PERSONAL_DOCUMENT pd
      on pd.personal_document_id = pp.personal_document_id
    where upper(pp.FIRST_NAME) = upper(p_first_name) and
      upper(pp.SECOND_NAME) = upper(p_second_name) and
      upper(pp.LAST_NAME) = upper(p_last_name) and
      upper(pd.DOC_SERIES) = upper(p_series) and
      upper(pd.DOC_NUMBER) = upper(p_number);
  end;
  
  procedure GET_SECURITY_USER(p_customer_id in number, cur_out out sys_refcursor)
  as
  s_user_id number;
  begin
    open cur_out
    for
    select su.security_user_id, su.user_name
    from security_user su
    inner join customer c on
     c.security_user_id = su.security_user_id
    where c.customer_id = p_customer_id;
  end;
  
  PROCEDURE GET_USERNAME_BY_EMAIL(
    p_email PHYSICAL_PERSON.FIRST_NAME%TYPE,
    cur_out out sys_refcursor)
  is
  begin
    open cur_out for
    select *
    from SECURITY_USER su
    inner join CUSTOMER c
      on c.security_user_id = su.security_user_id
    inner join PERSON p
      on p.person_id = c.person_id
    where upper(p.EMAIL) = upper(p_email);    
  end;

procedure CLEAR_INVALID_PASSPORTS is 
begin 
    execute immediate 'truncate table invalid_passports';   
end;

procedure GET_COUNT_INVALID_PASSPORTS(cnt_rows out NUMBER)
is
begin
   select count(*) into cnt_rows from INVALID_PASSPORTS;
end;

 procedure Get_InvalidPassport(p_serial INVALID_PASSPORTS.PASS_SERIES%TYPE, p_number INVALID_PASSPORTS.PASS_NUMBER%TYPE, cur_out out sys_refcursor)
 IS
 BEGIN
     open cur_out for SELECT * FROM INVALID_PASSPORTS WHERE PASS_SERIES = p_serial and PASS_NUMBER = p_number;
 END;

END CUSTOMERS;

/
