--------------------------------------------------------
--  Ref Constraints for Table CUSTOMER
--------------------------------------------------------

  ALTER TABLE "CUSTOMER" ADD CONSTRAINT "CUSTOMER_FK1" FOREIGN KEY ("SECURITY_USER_ID")
	  REFERENCES "SECURITY_USER" ("SECURITY_USER_ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "CUSTOMER" ADD CONSTRAINT "CUSTOMER_FK2" FOREIGN KEY ("PERSON_ID")
	  REFERENCES "PERSON" ("PERSON_ID") ENABLE;
