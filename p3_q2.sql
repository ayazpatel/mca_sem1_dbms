CREATE OR REPLACE FUNCTION emp_exist(
	emp_no IN emp.empno%TYPE
	) 
	RETURN CHAR IS 
		found CHAR(1);
BEGIN
	SELECT 'Y' INTO found 
	FROM emp
	WHERE empno = emp_no;
	RETURN 'Y';
EXCEPTION
	WHEN no_data_found THEN
	RETURN 'N';
END;

DECLARE
	vempno emp.empno%TYPE := 7839;
	vgot CHAR(1);
BEGIN
	vgot := emp_exist(vempno);
	dbms_output.put_line(vgot);
END;
/
