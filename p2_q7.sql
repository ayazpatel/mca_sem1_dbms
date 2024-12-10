DECLARE
	CURSOR dcur IS SELECT * FROM dept;
	CURSOR ecur (vdeptno dept.deptno%TYPE) IS
		SELECT *
		FROM emp
		WHERE deptno = vdeptno;
BEGIN
	FOR i IN dcur
	LOOP
		dbms_output.put_line(i.deptno || i.dname || i.loc);
		FOR j IN ecur(i.deptno)
		LOOP
			dbms_output.put_line(j.empno || j.deptno);
		END LOOP;
	END LOOP;
END;
/
