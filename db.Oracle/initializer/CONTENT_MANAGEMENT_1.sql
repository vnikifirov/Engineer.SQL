--------------------------------------------------------
--  DDL for Package Body CONTENT_MANAGEMENT
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "CONTENT_MANAGEMENT" is

   procedure GET_BUSINESS_VIEW(CUR_OUT out SYS_REFCURSOR) as
   begin
      open CUR_OUT for
      select BUSINESS_VIEW_ID,
         CODE,
         PATH,
         SECURITY_GROUP,
         PARENT,
         VISIBLE,
         ICON_PATH
      from BUSINESS_VIEW
      order by BUSINESS_VIEW_ID;
   end GET_BUSINESS_VIEW;

end CONTENT_MANAGEMENT;

/
