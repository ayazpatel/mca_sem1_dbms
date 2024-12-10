DECLARE
	vemp emp%ROWTYPE;
BEGIN
	FOR i IN (
		SELECT e1.empno, e1.ename, e1.job, e1.sal, e2.ename AS manager_name
		FROM EMP e1, EMP e2
		WHERE e1.empno = e2.mgr
	)
	LOOP
		dbms_output.put_line(i.empno || ' ' || i.ename || ' ' || i.job || ' ' || i.sal || ' ' || i.manager_name);
	END LOOP;
END;
/
