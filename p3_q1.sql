-- To Create a Stored Procedure
CREATE OR REPLACE PROCEDURE department_report(
	param_deptno IN OUT dept.deptno%TYPE
) IS 
	CURSOR dept_exist(dept_no dept.deptno%TYPE) IS
		SELECT *
		FROM dept d
		WHERE d.deptno = param_deptno;
    vdept dept%ROWTYPE;
	CURSOR emp_det(dept_no dept.deptno%TYPE) IS
		SELECT empno, ename, job, sal, comm, (sal + NVL(comm, 0)) as earnings
		FROM emp
		WHERE deptno = dept_no;
BEGIN
	OPEN dept_exist(param_deptno);
        FETCH dept_exist INTO vdept;
        IF vdept.deptno = param_deptno THEN
            FOR i IN emp_det(param_deptno) LOOP
                dbms_output.put_line(i.empno || ' ' || i.ename || ' ' || i.job || ' ' || i.sal || ' ' || i.comm || ' ' || i.earnings);
            END LOOP;
        ELSE
            dbms_output.put_line('Not Found');
            RETURN;
        END IF;
	CLOSE dept_exist;
END;
/

-- To Run Procedure
DECLARE
	vdeptno dept.deptno%TYPE := 10;
BEGIN
	department_report(vdeptno);
END;
/
