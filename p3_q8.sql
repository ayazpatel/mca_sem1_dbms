CREATE OR REPLACE TRIGGER conditional_updates_on_emp
	BEFORE UPDATE ON emp
	FOR EACH ROW
BEGIN
	IF TO_CHAR(SYSDATE, 'HH24') < '09' OR TO_CHAR(SYSDATE, ''HH24) >= '21' THEN
		RAISE_APPLICATION_ERROR(-20004, 'Insertions are only allowed between 9 AM and 5 PM.');
	END IF;
END;
/