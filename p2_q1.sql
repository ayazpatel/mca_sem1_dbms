DECLARE
	vempno	emp.empno%TYPE;
	vemp	emp%ROWTYPE;
	count	NUMBER;
BEGIN
	SELECT * INTO vemp 
	FROM emp 
	WHERE empno = &vempno;
	IF vempno = vemp.empno THEN
		dbms_output.put_line('Record Found!');
	ELSE
		dbms_output.put_line('Record Not Found!');
	END IF;
END;
/
