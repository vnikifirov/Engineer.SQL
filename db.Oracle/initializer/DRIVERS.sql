--------------------------------------------------------
--  DDL for Package DRIVERS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "DRIVERS" AS 

  procedure CREATE_TEMP_DRIVER(
    p_first_name DRIVER.FIRST_NAME%TYPE,
    p_second_name DRIVER.SECOND_NAME%TYPE,
    p_last_name DRIVER.LAST_NAME%TYPE,
    p_birthday DRIVER.BIRTH_DATE%TYPE,
    p_gender DRIVER.GENDER%TYPE,
    p_licence_series DRIVER.LICENSE_SERIAL%TYPE,
    p_licence_no DRIVER.LICENSE_NUMBER%TYPE,
    p_drive_from DRIVER.DRIVE_FROM%TYPE,
    p_id out DRIVER.DRIVER_ID%TYPE);
    
  procedure CREATE_DRIVER(
    p_first_name DRIVER.FIRST_NAME%TYPE,
    p_second_name DRIVER.SECOND_NAME%TYPE,
    p_last_name DRIVER.LAST_NAME%TYPE,
    p_birthday DRIVER.BIRTH_DATE%TYPE,
    p_gender DRIVER.GENDER%TYPE,
    p_licence_series DRIVER.LICENSE_SERIAL%TYPE,
    p_licence_no DRIVER.LICENSE_NUMBER%TYPE,
    p_drive_from DRIVER.DRIVE_FROM%TYPE,
    p_id out DRIVER.DRIVER_ID%TYPE);

    
  procedure DELETE_TEMP_DRIVER(
    p_driver_id DRIVER_TEMP.DRIVER_ID%TYPE);

  procedure ASSIGN_DRIVER_TO_PERSON(
    p_driver_id PHYSICAL_PERSON.DRIVER_ID%TYPE,
    p_person_id PHYSICAL_PERSON.PERSON_ID%TYPE);

  procedure GET_DRIVER_OF_PERSON(
    p_person_id PHYSICAL_PERSON.PERSON_ID%TYPE,
    cur_out out sys_refcursor);

  procedure DELETE_DRIVER(p_driver_id DRIVER.DRIVER_ID%TYPE);

END DRIVERS;

/
