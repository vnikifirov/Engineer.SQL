--------------------------------------------------------
--  DDL for Package ADDRESSES
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "ADDRESSES" AS 

  procedure GET_COUNTRIES(cur_out out sys_refcursor);
  procedure GET_COUNTRY_REGIONS(p_country_name varchar2, cur_out out sys_refcursor);
  procedure GET_REGION_CITIES(p_region_code varchar2, cur_out out sys_refcursor);
  procedure GET_CITY_STREETS(p_region_code varchar2, p_district_code varchar2, p_city_code varchar2, cur_out out sys_refcursor);
  procedure GET_CITY_STREETS(p_city_full_code varchar2, cur_out out sys_refcursor);
  procedure GET_STREET_HOUSES(p_region_code varchar2, p_district_code varchar2, p_city_code varchar2, p_street_code varchar2, cur_out out sys_refcursor);
  procedure GET_STREET_NAME(p_street_code varchar2, cur_out out sys_refcursor);
  procedure GET_OBJECT_BY_CODE(p_code varchar2, cur_out out sys_refcursor);
  procedure GET_STREET_BY_CODE(p_code varchar2, cur_out out sys_refcursor);

END ADDRESSES;

/
