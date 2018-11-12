--------------------------------------------------------
--  Ref Constraints for Table BUSINESS_VIEW
--------------------------------------------------------

  ALTER TABLE "BUSINESS_VIEW" ADD CONSTRAINT "FK_BUSINESS_VIEW" FOREIGN KEY ("PARENT")
	  REFERENCES "BUSINESS_VIEW" ("BUSINESS_VIEW_ID") ENABLE;
