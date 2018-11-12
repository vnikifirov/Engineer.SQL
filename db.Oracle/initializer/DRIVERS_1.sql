--------------------------------------------------------
--  DDL for Package Body DRIVERS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "DRIVERS" AS

  procedure CREATE_TEMP_DRIVER(
    p_first_name DRIVER.FIRST_NAME%TYPE,
    p_second_name DRIVER.SECOND_NAME%TYPE,
    p_last_name DRIVER.LAST_NAME%TYPE,
    p_birthday DRIVER.BIRTH_DATE%TYPE,
    p_gender DRIVER.GENDER%TYPE,
    p_licence_series DRIVER.LICENSE_SERIAL%TYPE,
    p_licence_no DRIVER.LICENSE_NUMBER%TYPE,
    p_drive_from DRIVER.DRIVE_FROM%TYPE,
    p_id out DRIVER.DRIVER_ID%TYPE) AS
  BEGIN
    insert into DRIVER_TEMP(DRIVER_ID, FIRST_NAME, SECOND_NAME, LAST_NAME, GENDER, BIRTH_DATE, DRIVE_FROM, LICENSE_SERIAL, LICENSE_NUMBER)
    values (S_DRIVER.NEXTVAL, p_first_name, p_second_name, p_last_name, p_gender, p_birthday, p_drive_from, p_licence_series, p_licence_no)
    returning driver_id into p_id;
    commit;
  END CREATE_TEMP_DRIVER;
  
  procedure DELETE_TEMP_DRIVER(p_driver_id DRIVER_TEMP.DRIVER_ID%TYPE)
  as
  begin
    delete from DRIVER_TEMP where driver_id = p_driver_id;
    commit;
  end;
  
  procedure CREATE_DRIVER(
    p_first_name DRIVER.FIRST_NAME%TYPE,
    p_second_name DRIVER.SECOND_NAME%TYPE,
    p_last_name DRIVER.LAST_NAME%TYPE,
    p_birthday DRIVER.BIRTH_DATE%TYPE,
    p_gender DRIVER.GENDER%TYPE,
    p_licence_series DRIVER.LICENSE_SERIAL%TYPE,
    p_licence_no DRIVER.LICENSE_NUMBER%TYPE,
    p_drive_from DRIVER.DRIVE_FROM%TYPE,
    p_id out DRIVER.DRIVER_ID%TYPE) AS
  BEGIN
    insert into DRIVER(DRIVER_ID, FIRST_NAME, SECOND_NAME, LAST_NAME, GENDER, BIRTH_DATE, DRIVE_FROM, LICENSE_SERIAL, LICENSE_NUMBER)
    values (S_DRIVER.NEXTVAL, p_first_name, p_second_name, p_last_name, p_gender, p_birthday, p_drive_from, p_licence_series, p_licence_no)
    returning driver_id into p_id;
    commit;
  END CREATE_DRIVER;
  
  procedure ASSIGN_DRIVER_TO_PERSON(
    p_driver_id PHYSICAL_PERSON.DRIVER_ID%TYPE,
    p_person_id PHYSICAL_PERSON.PERSON_ID%TYPE)
  as
  begin
    update PHYSICAL_PERSON set driver_id = p_driver_id
    where person_id = p_person_id;
    commit;
  end;
  
  procedure GET_DRIVER_OF_PERSON(
    p_person_id PHYSICAL_PERSON.PERSON_ID%TYPE,
    cur_out out sys_refcursor)
  as
  begin
    open cur_out for 
    select * 
    from driver d 
    inner join physical_person p 
      on p.DRIVER_ID = d.DRIVER_ID
    where p.person_id = p_person_id;
  end;
  
  procedure DELETE_DRIVER(p_driver_id DRIVER.DRIVER_ID%TYPE)
  as
  begin
    delete from DRIVER where driver_id = p_driver_id;
    commit;
  end;


END DRIVERS;

/
