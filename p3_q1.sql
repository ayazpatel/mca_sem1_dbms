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

    v_total_salary NUMBER := 0;
    v_highest_salary NUMBER := 0;
    v_lowest_salary NUMBER := NULL;

    v_total_commission NUMBER := 0;
    v_highest_commission NUMBER := 0;
    v_lowest_commission NUMBER := NULL;

    v_total_earnings NUMBER := 0;
    v_highest_earnings NUMBER := 0;
    v_lowest_earnings NUMBER := NULL;
BEGIN
    OPEN dept_exist(param_deptno);
    FETCH dept_exist INTO vdept;
    IF vdept.deptno = param_deptno THEN    
        dbms_output.put_line('Deptno:' || vdept.deptno || ' ' || 'Department Name: ' || vdept.dname || ' ' || 'Location: ' || vdept.loc);
        dbms_output.put_line(' ');
        dbms_output.put_line('Empno' || ' ' || 'Name' || ' ' || 'Designation' || ' ' || 'Salary' || ' ' || 'Commission' || ' ' || 'Earnings');
        dbms_output.put_line('---------------------------------------------------');
        FOR i IN emp_det(param_deptno) LOOP
            dbms_output.put_line(i.empno || ' ' || i.ename || ' ' || i.job || ' ' || i.sal || ' ' || i.comm || ' ' || i.earnings);

            -- Update salary metrics
            v_total_salary := v_total_salary + i.sal;
            IF v_lowest_salary IS NULL OR i.sal < v_lowest_salary THEN
                v_lowest_salary := i.sal;
            END IF;
            IF i.sal > v_highest_salary THEN
                v_highest_salary := i.sal;
            END IF;

            -- Update commission metrics
            v_total_commission := v_total_commission + NVL(i.comm, 0);
            IF v_lowest_commission IS NULL OR NVL(i.comm, 0) < v_lowest_commission THEN
                v_lowest_commission := NVL(i.comm, 0);
            END IF;
            IF NVL(i.comm, 0) > v_highest_commission THEN
                v_highest_commission := NVL(i.comm, 0);
            END IF;

            -- Update earnings metrics
            v_total_earnings := v_total_earnings + i.earnings;
            IF v_lowest_earnings IS NULL OR i.earnings < v_lowest_earnings THEN
                v_lowest_earnings := i.earnings;
            END IF;
            IF i.earnings > v_highest_earnings THEN
                v_highest_earnings := i.earnings;
            END IF;
        END LOOP;
        dbms_output.put_line('---------------------------------------------------');
        dbms_output.put_line('Total Salary: ' || v_total_salary || ' ' || v_total_commission || ' ' || v_total_earnings);
        dbms_output.put_line('Highest Salary: ' || v_highest_salary || ' ' || v_highest_commission || ' ' || v_highest_earnings);
        dbms_output.put_line('Lowest Salary: ' || v_lowest_salary || ' ' || v_lowest_commission || ' ' || v_lowest_earnings);
    ELSE
        dbms_output.put_line('Not Found');
        RETURN;
    END IF;
    CLOSE dept_exist;
END;
/
