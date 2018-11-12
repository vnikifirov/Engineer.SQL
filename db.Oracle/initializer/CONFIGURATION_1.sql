--------------------------------------------------------
--  DDL for Package Body CONFIGURATION
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "CONFIGURATION" as

   function get_configuration_element (
      p_configuration_set  in  varchar2,
      p_document       in  varchar2,
      p_element_path     in  varchar2,
      p_element_body     out clob
   ) return number is
      v_active_profile_id number;
      v_element_body      xmltype;

      invalid_xpath exception;
      pragma exception_init(invalid_xpath, -31013);
   begin
      begin
         select cp.configuration_profile_id
         into v_active_profile_id
         from configuration_profile cp
         inner join configuration_set app on app.configuration_set_id = cp.configuration_set_id and
            upper(app.name) = upper(p_configuration_set)
         where cp.active = 1;

      exception
         when no_data_found then
            return 1;

         when too_many_rows then
            return 1;
      end;

      begin
         select  cd.body.extract(p_element_path)
         into v_element_body
         from configuration_data cd
         where cd.body.existsnode(p_element_path) = 1
            and upper(cd.name) = upper(p_document)
            and cd.configuration_profile_id = v_active_profile_id;

      exception
         when no_data_found then
            return 2;

         when invalid_xpath then
            return 3;
      end;

      p_element_body := v_element_body.getclobval();

      return 0;
   end get_configuration_element;

   function set_configuration_element (
      p_configuration_set  in varchar2,
      p_document       in varchar2,
      p_element_path     in varchar2,
      p_element_body     in clob
   ) return number is
      v_active_profile_id number;
      v_element_body      xmltype;

      invalid_xpath exception;
      pragma exception_init(invalid_xpath, -31013);
   begin
      v_element_body := xmltype(p_element_body);

      begin
         select cp.configuration_profile_id
         into v_active_profile_id
         from configuration_profile cp
         inner join configuration_set app on app.configuration_set_id = cp.configuration_set_id and
            upper(app.name) = upper(p_configuration_set)
         where cp.active = 1;

      exception
         when no_data_found then
            return 1;

         when too_many_rows then
            return 1;
      end;

      begin
         update configuration_data cd
         set cd.body = updatexml(cd.body, p_element_path, v_element_body)
         where cd.body.existsnode(p_element_path) = 1 and
            upper(cd.name) = upper(p_document) and
            cd.configuration_profile_id = v_active_profile_id;

      exception
         when no_data_found then
            return 2;

         when invalid_xpath then
            return 3;
      end;

      return 0;
   end set_configuration_element;

   function check_active_profile (
      p_configuration_set in varchar2
   ) return number is
      v_active_profile_id number;
   begin
      begin
         select cp.configuration_profile_id
         into v_active_profile_id
         from configuration_profile cp
         inner join configuration_set app on app.configuration_set_id = cp.configuration_set_id and
            upper(app.name) = upper(p_configuration_set)
         where cp.active = 1;

      exception
         when no_data_found then
            return 1;

         when too_many_rows then
            return 1;
      end;

      return 0;
   end check_active_profile;

   function get_configuration_data_id (
      p_document in configuration_data.name%type
   ) return number is
      v_configuration_data_id number;
   begin
      select cd.configuration_data_id
      into v_configuration_data_id
      from configuration_data cd
      inner join configuration_profile cp on cp.configuration_profile_id = cd.configuration_profile_id
      where cp.active = 1 and
         upper(p_document) = upper(cd.name);

      return v_configuration_data_id;

   exception
      when no_data_found then
         return 0;
   end get_configuration_data_id;

   procedure get_configuration_data (
      p_id   in  configuration_data.configuration_data_id%type,
      p_data out sys_refcursor)
   is
   begin
      open p_data for
         select cd.configuration_data_id,
            cd.name,
            cp.configuration_profile_id,
            cp.name as configuration_profile_name,
            cs.configuration_set_id,
            cs.name as configuration_set_name,
            cd.body.getclobval() as body,
            cd.scheme,
            cd.changed,
            cd.changed_by
         from configuration_data cd
         inner join configuration_profile cp on cp.configuration_profile_id = cd.configuration_profile_id
         inner join configuration_set cs on cs.configuration_set_id = cp.configuration_set_id
         where cd.configuration_data_id = p_id;
   end get_configuration_data;

   procedure get_configuration_data_summary (
      p_data out sys_refcursor)
   is
   begin
      open p_data for
         select cd.configuration_data_id,
            cd.name,
            cp.configuration_profile_id,
            cp.name as configuration_profile_name,
            cs.configuration_set_id,
            cs.name as configuration_set_name,
            cd.changed,
            cd.changed_by
         from configuration_data cd
         inner join configuration_profile cp on cp.configuration_profile_id = cd.configuration_profile_id
         inner join configuration_set cs on cs.configuration_set_id = cp.configuration_set_id;
   end get_configuration_data_summary;

   procedure insert_configuration_data (
      p_configuration_profile_id in  configuration_data.configuration_profile_id%type,
      p_name                     in  configuration_data.name%type,
      p_body                     in  clob,
      p_scheme                   in  clob,
      p_changed_by               in  configuration_data.changed_by%type,
      p_id                       out configuration_data.configuration_data_id%type)
   is
   begin
      insert into configuration_data (
         configuration_data_id,
         configuration_profile_id,
         name,
         body,
         scheme,
         changed,
         changed_by)
      values (s_configuration_data.nextval,
         p_configuration_profile_id,
         p_name,
         xmltype.createxml(p_body),
         nvl2(p_scheme, xmltype.createxml(p_scheme), null),
         sysdate,
         p_changed_by)
      returning configuration_data_id into p_id;
   end insert_configuration_data;

   procedure update_configuration_data (
      p_id                       in configuration_data.configuration_data_id%type,
      p_name                     in configuration_data.name%type,
      p_body                     in clob,
      p_scheme                   in clob,
      p_changed_by               in configuration_data.changed_by%type)
   is
   begin
      update configuration_data
      set name = p_name,
         body = xmltype.createxml(p_body),
         scheme = nvl2(p_scheme, xmltype.createxml(p_scheme), null),
         changed = sysdate,
         changed_by = p_changed_by
      where configuration_data_id = p_id;

      if (sql%rowcount = 0) then
         raise_application_error(-20001, 'Configuration with Id = ' || p_id || ' was not found.');
      end if;
   end update_configuration_data;

   procedure delete_configuration_data (
      p_id in configuration_data.configuration_data_id%type)
   is
   begin
      delete from configuration_data
      where configuration_data_id = p_id;

      if (sql%rowcount = 0) then
         raise_application_error(-20001, 'Configuration with Id = ' || p_id || ' was not found.');
      end if;
   end delete_configuration_data;

   procedure get_configuration_profile (
      p_id   in  configuration_profile.configuration_profile_id%type,
      p_data out sys_refcursor)
   is
   begin
      open p_data for
         select cp.configuration_profile_id,
            cp.name,
            cs.configuration_set_id,
            cs.name as configuration_set_name,
            cp.active
         from configuration_profile cp
         inner join configuration_set cs on cs.configuration_set_id = cp.configuration_set_id
         where (configuration_profile_id = p_id or p_id is null);
   end get_configuration_profile;

   procedure insert_configuration_profile (
      p_name                 in  configuration_profile.name%type,
      p_configuration_set_id in  configuration_profile.configuration_set_id%type,
      p_id                   out configuration_profile.configuration_profile_id%type)
   is
   begin
      insert into configuration_profile (
         configuration_profile_id,
         name,
         active,
         configuration_set_id)
      values (s_configuration_profile.nextval,
         p_name,
         0,
         p_configuration_set_id)
      returning configuration_profile_id into p_id;
   end insert_configuration_profile;

   procedure update_configuration_profile (
      p_id                   in configuration_profile.configuration_profile_id%type,
      p_name                 in configuration_profile.name%type)
   is
   begin
      update configuration_profile
      set name = p_name
      where configuration_profile_id = p_id;

      if (sql%rowcount = 0) then
         raise_application_error(-20001, 'Configuration Profile with Id = ' || p_id || ' was not found.');
      end if;
   end update_configuration_profile;

   procedure activate_configuration_profile (
      p_id in configuration_profile.configuration_profile_id%type)
   is
      v_cnt number;
   begin
      select count(1)
      into v_cnt
      from configuration_profile
      where configuration_profile_id = p_id;

      if (v_cnt = 1) then
         update configuration_profile cp
         set cp.active = 0
         where cp.configuration_set_id = (
               select configuration_set_id
               from configuration_profile
               where configuration_profile_id = p_id);

         update configuration_profile cp
         set cp.active = 1
         where cp.configuration_profile_id = p_id;
      else
         raise_application_error(-20001, 'Configuration Profile with Id = ' || p_id || ' was not found.');
      end if;
   end activate_configuration_profile;

   procedure delete_configuration_profile (
      p_id in configuration_profile.configuration_profile_id%type)
   is
   begin
      delete from configuration_profile
      where configuration_profile_id = p_id;

      if (sql%rowcount = 0) then
         raise_application_error(-20001, 'Configuration Profile with Id = ' || p_id || ' was not found.');
      end if;
   end delete_configuration_profile;

   procedure get_configuration_set (
      p_id   in  configuration_set.configuration_set_id%type,
      p_data out sys_refcursor)
   is
   begin
      open p_data for
         select configuration_set_id,
            name,
            description
         from configuration_set
         where (configuration_set_id = p_id or p_id is null);
   end get_configuration_set;

   procedure insert_configuration_set (
      p_name        in  configuration_set.name%type,
      p_description in  configuration_set.description%type,
      p_id          out configuration_set.configuration_set_id%type)
   is
   begin
      insert into configuration_set (
         configuration_set_id,
         name,
         description)
      values (s_configuration_set.nextval,
         p_name,
         p_description)
      returning configuration_set_id into p_id;
   end insert_configuration_set;

   procedure update_configuration_set (
      p_id          in configuration_set.configuration_set_id%type,
      p_name        in configuration_set.name%type,
      p_description in configuration_set.description%type)
   is
   begin
      update configuration_set
      set name = p_name,
      description = p_description
      where configuration_set_id = p_id;

      if (sql%rowcount = 0) then
         raise_application_error(-20001, 'Configuration Set with Id = ' || p_id || ' was not found.');
      end if;
   end update_configuration_set;

   procedure delete_configuration_set (
      p_id in configuration_set.configuration_set_id%type)
   is
   begin
      delete from configuration_set
      where configuration_set_id = p_id;

      if (sql%rowcount = 0) then
         raise_application_error(-20001, 'Configuration Set with Id = ' || p_id || ' was not found.');
      end if;
   end delete_configuration_set;

end configuration;

/
