DECLARE
	CURSOR dcur IS SELECT * FROM dept;
	vdept dept%ROWTYPE;
	CURSOR ecur (vdeptno dept.deptno%TYPE) IS
		SELECT *
		FROM emp
		WHERE deptno = vdeptno;
	vemp emp%ROWTYPE;
BEGIN
	OPEN dcur;
		LOOP
			FETCH dcur INTO vdept;
			EXIT WHEN dcur%NOTFOUND;
			dbms_output.put_line(vdept.deptno || vdept.dname || vdept.loc);
			OPEN ecur(vdept.deptno);
			LOOP
				FETCH ecur INTO vemp;
				EXIT WHEN ecur%NOTFOUND;
				dbms_output.put_line(vemp.empno || vemp.ename || vemp.job || vemp.sal);
			END LOOP;
			CLOSE ecur;
		END LOOP;
	CLOSE dcur;
END;
/
