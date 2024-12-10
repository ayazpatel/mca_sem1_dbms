DECLARE
    -- Custom record type including manager field
    TYPE emp_record IS RECORD (
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        job emp.job%TYPE,
        sal emp.sal%TYPE,
        manager emp.ename%TYPE
    );

    etable emp_record;

    CURSOR cur IS 
        SELECT e1.empno, e1.ename, e1.job, e1.sal, e2.ename AS manager
        FROM emp e1, emp e2
        WHERE e1.mgr = e2.empno;

BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO etable;
        EXIT WHEN cur%NOTFOUND;
        dbms_output.put_line(etable.empno || ' ' || etable.ename || ' ' || etable.job || ' ' || etable.sal || ' ' || etable.manager);
    END LOOP;
    CLOSE cur;
END;
/
