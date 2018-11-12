--------------------------------------------------------
--  Ref Constraints for Table AUTO_INS_LOG
--------------------------------------------------------

  ALTER TABLE "AUTO_INS_LOG" ADD CONSTRAINT "AUTO_INS_LOG_FK1" FOREIGN KEY ("AUTO_INS_LOG_ENTITY_ID")
	  REFERENCES "AUTO_INS_LOG_ENTITY" ("ID") ON DELETE CASCADE ENABLE;
