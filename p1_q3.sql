DECLARE
	vdeptno dept.deptno%TYPE;
BEGIN
	FOR i IN (
		SELECT * FROM dept
	)
	LOOP
		dbms_output.put_line(i.deptno || ' ' || i.dname || ' ' || i.loc);
		FOR j IN (
			SELECT empno, ename, job, sal
			FROM emp
			WHERE deptno = i.deptno
		)
		LOOP
			dbms_output.put_line(j.empno || ' ' || j.ename || ' '|| j.job || ' ' || j.sal);
		END LOOP;
	END LOOP;
END;
/
