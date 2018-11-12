--------------------------------------------------------
--  Ref Constraints for Table CONFIGURATION_DATA
--------------------------------------------------------

  ALTER TABLE "CONFIGURATION_DATA" ADD CONSTRAINT "FK_CONFIGURATION_DATA" FOREIGN KEY ("CONFIGURATION_PROFILE_ID")
	  REFERENCES "CONFIGURATION_PROFILE" ("CONFIGURATION_PROFILE_ID") ON DELETE CASCADE ENABLE;
