--------------------------------------------------------
--  Ref Constraints for Table DATA_LOCK_QUOTA
--------------------------------------------------------

  ALTER TABLE "DATA_LOCK_QUOTA" ADD CONSTRAINT "DATA_LOCK_QUOTA_FK1" FOREIGN KEY ("DATA_LOCK_ID")
	  REFERENCES "DATA_LOCK" ("ID") ON DELETE CASCADE ENABLE;
