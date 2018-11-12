--------------------------------------------------------
--  Ref Constraints for Table CONFIGURATION_PROFILE
--------------------------------------------------------

  ALTER TABLE "CONFIGURATION_PROFILE" ADD CONSTRAINT "FK_CONFIGURATION_PROFILE" FOREIGN KEY ("CONFIGURATION_SET_ID")
	  REFERENCES "CONFIGURATION_SET" ("CONFIGURATION_SET_ID") ON DELETE CASCADE ENABLE;
