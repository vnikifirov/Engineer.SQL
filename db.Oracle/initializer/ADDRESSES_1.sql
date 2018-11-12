--------------------------------------------------------
--  DDL for Package Body ADDRESSES
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "ADDRESSES" AS

  procedure GET_COUNTRIES(cur_out out sys_refcursor) AS
  BEGIN
    open cur_out for 
    select * from country where upper(short_name) = 'РОССИЯ'
    union all
    select * from country-- where upper(short_name) <> 'РОССИЯ'
    ;
  END GET_COUNTRIES;

  procedure GET_COUNTRY_REGIONS(p_country_name varchar2, cur_out out sys_refcursor) AS
  BEGIN
    if (upper(p_country_name) = 'РОССИЯ') then
      open cur_out
      for SELECT *
        FROM kladr_kladr
        WHERE code LIKE '__00000000000';
    end if;
  END GET_COUNTRY_REGIONS;

  procedure GET_REGION_DISTRICTS(p_region_code varchar2, cur_out out sys_refcursor) AS
  BEGIN
    open cur_out for
      select *
      from kladr_kladr
      where code <> p_region_code || '00000000000' and
      (code like p_region_code || '___00000000');
  END GET_REGION_DISTRICTS;
  
  procedure GET_REGION_CITIES(p_region_code varchar2, cur_out out sys_refcursor) AS
    v_region_code varchar2(20) := p_region_code;
  BEGIN
    v_region_code := substr(p_region_code, 1, 2);
    open cur_out for
      select *
      from kladr_kladr
      where --code <> v_region_code || '00000000000' and
      (code like v_region_code || '000___00000' or code like v_region_code || '______00000' or code like v_region_code || '000000___00' or code like v_region_code || '___000___00')
      and (code not like v_region_code || '___00000000' or (code = v_region_code || '00000000000' and upper(socr) = 'Г'))
      order by code asc;
  END GET_REGION_CITIES;

  procedure GET_CITY_STREETS(p_region_code varchar2, p_district_code varchar2, p_city_code varchar2, cur_out out sys_refcursor) AS
  BEGIN
    open cur_out for
      select *
      from kladr_Street
      where code like p_region_code || p_district_code || p_city_code || '%';
  END GET_CITY_STREETS;
  
  procedure GET_CITY_STREETS(p_city_full_code varchar2, cur_out out sys_refcursor) AS
  BEGIN
    open cur_out for
      select *
      from kladr_Street
      where code like substr(p_city_full_code, 1, 11) || '%';
  END GET_CITY_STREETS;


  procedure GET_STREET_HOUSES(p_region_code varchar2, p_district_code varchar2, p_city_code varchar2, p_street_code varchar2, cur_out out sys_refcursor) AS
  BEGIN
    open cur_out for 
      select *
      from kladr_doma
      where code like p_region_code || p_district_code || p_city_code || p_street_code || '%';
  END GET_STREET_HOUSES;
  
  procedure GET_STREET_NAME(p_street_code varchar2, cur_out out sys_refcursor)
  as
  begin
    open cur_out for select * from KLADR_STREET where code = p_street_code;
  end;
  
  procedure GET_OBJECT_BY_CODE(p_code varchar2, cur_out out sys_refcursor)
  as
  begin
    open cur_out for select name, code from kladr_kladr where code = p_code;
  end;
  
  procedure GET_STREET_BY_CODE(p_code varchar2, cur_out out sys_refcursor)
  as
  begin
    open cur_out for select name, code from kladr_street where code = p_code;
  end;

END ADDRESSES;

/
