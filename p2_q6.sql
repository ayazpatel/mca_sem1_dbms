DECLARE
    CURSOR cur IS 
        SELECT e1.empno, e1.ename, e1.job, e1.sal, e2.ename AS manager_name
        FROM emp e1, emp e2
        WHERE e1.mgr = e2.empno;
BEGIN
	FOR i IN cur
	LOOP
		dbms_output.put_line(i.empno || i.ename || i.job || i.manager_name);
	END LOOP;
END;
/
