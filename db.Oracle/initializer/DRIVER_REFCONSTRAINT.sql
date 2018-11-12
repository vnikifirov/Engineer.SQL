--------------------------------------------------------
--  Ref Constraints for Table DRIVER
--------------------------------------------------------

  ALTER TABLE "DRIVER" ADD CONSTRAINT "DRIVER_FK1" FOREIGN KEY ("ADD_AGREEMENT_ID")
	  REFERENCES "OSAGO_POLICY_ADD_AGREEMENT" ("ID") ENABLE;
  ALTER TABLE "DRIVER" ADD CONSTRAINT "DRIVER_FK2" FOREIGN KEY ("DELETE_AGREEMENT_ID")
	  REFERENCES "OSAGO_POLICY_ADD_AGREEMENT" ("ID") ENABLE;
