--------------------------------------------------------
--  DDL for Package Body CONFIRMED_DOCUMENTS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "CONFIRMED_DOCUMENTS" AS

  procedure CHECK_DOCUMENT_CONFIRM(
    p_document_type   in CONFIRMED_DOCUMENT.DOC_TYPE_ID%TYPE,
    p_document_series in CONFIRMED_DOCUMENT.DOC_SERIES%TYPE,
    p_document_number in CONFIRMED_DOCUMENT.DOC_NUMBER%TYPE,
    check_result      out number
  ) AS
  BEGIN
    select count(1)
    into check_result
    from CONFIRMED_DOCUMENT
    where DOC_TYPE_ID = p_document_type and DOC_SERIES = trim(upper(p_document_series)) and DOC_NUMBER = trim(upper(p_document_number));
  END CHECK_DOCUMENT_CONFIRM;

END CONFIRMED_DOCUMENTS;

/
