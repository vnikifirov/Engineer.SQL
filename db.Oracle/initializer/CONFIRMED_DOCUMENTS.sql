--------------------------------------------------------
--  DDL for Package CONFIRMED_DOCUMENTS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "CONFIRMED_DOCUMENTS" AS 

  procedure CHECK_DOCUMENT_CONFIRM(
    p_document_type   in CONFIRMED_DOCUMENT.DOC_TYPE_ID%TYPE,
    p_document_series in CONFIRMED_DOCUMENT.DOC_SERIES%TYPE,
    p_document_number in CONFIRMED_DOCUMENT.DOC_NUMBER%TYPE,
    check_result      out number
  );

END CONFIRMED_DOCUMENTS;

/
