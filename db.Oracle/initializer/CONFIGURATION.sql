--------------------------------------------------------
--  DDL for Package CONFIGURATION
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "CONFIGURATION" as

   target_not_found exception;
   pragma exception_init(target_not_found, - 20001);

   function get_configuration_element (
      p_configuration_set in  varchar2,
      p_document          in  varchar2,
      p_element_path      in  varchar2,
      p_element_body      out clob
   ) return number;

   function set_configuration_element (
      p_configuration_set in varchar2,
      p_document          in varchar2,
      p_element_path      in varchar2,
      p_element_body      in clob
   ) return number;

   function check_active_profile (
      p_configuration_set in varchar2
   ) return number;

   function get_configuration_data_id (
      p_document in configuration_data.name%type
   ) return number;

   procedure get_configuration_data (
      p_id   in  configuration_data.configuration_data_id%type,
      p_data out sys_refcursor);

   procedure get_configuration_data_summary (
      p_data out sys_refcursor);

   procedure insert_configuration_data (
      p_configuration_profile_id in  configuration_data.configuration_profile_id%type,
      p_name                     in  configuration_data.name%type,
      p_body                     in  clob,
      p_scheme                   in  clob,
      p_changed_by               in  configuration_data.changed_by%type,
      p_id                       out configuration_data.configuration_data_id%type);

   procedure update_configuration_data (
      p_id                       in configuration_data.configuration_data_id%type,
      p_name                     in configuration_data.name%type,
      p_body                     in  clob,
      p_scheme                   in  clob,
      p_changed_by               in configuration_data.changed_by%type);

   procedure delete_configuration_data (
      p_id in configuration_data.configuration_data_id%type);

   procedure get_configuration_profile (
      p_id   in  configuration_profile.configuration_profile_id%type,
      p_data out sys_refcursor);

   procedure insert_configuration_profile (
      p_name                 in  configuration_profile.name%type,
      p_configuration_set_id in  configuration_profile.configuration_set_id%type,
      p_id                   out configuration_profile.configuration_profile_id%type);

   procedure update_configuration_profile (
      p_id                   in configuration_profile.configuration_profile_id%type,
      p_name                 in configuration_profile.name%type);

   procedure activate_configuration_profile (
      p_id in configuration_profile.configuration_profile_id%type);

   procedure delete_configuration_profile (
      p_id in configuration_profile.configuration_profile_id%type);

   procedure get_configuration_set (
      p_id   in  configuration_set.configuration_set_id%type,
      p_data out sys_refcursor);

   procedure insert_configuration_set (
      p_name        in  configuration_set.name%type,
      p_description in  configuration_set.description%type,
      p_id          out configuration_set.configuration_set_id%type);

   procedure update_configuration_set (
      p_id          in configuration_set.configuration_set_id%type,
      p_name        in configuration_set.name%type,
      p_description in configuration_set.description%type);

   procedure delete_configuration_set (
      p_id in configuration_set.configuration_set_id%type);

end configuration;

/
