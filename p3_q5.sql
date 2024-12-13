-- Assuming the following structure for the emp table
-- CREATE TABLE emp (
--     empno NUMBER PRIMARY KEY,
--     ename VARCHAR2(50),
--     job VARCHAR2(50),
--     mgr NUMBER,
--     hiredate DATE,
--     sal NUMBER,
--     comm NUMBER,
--     deptno NUMBER
-- );

-- Assuming the following structure for the dept table
-- CREATE TABLE dept (
--     deptno NUMBER PRIMARY KEY,
--     dname VARCHAR2(50),
--     loc VARCHAR2(50)
-- );

-- Assuming the following structure for the employee's manager data
-- This can be part of the emp table or another table that keeps manager info

-- Create a user-defined exception for salary validation
CREATE OR REPLACE PROCEDURE add_employee(
    p_empno IN emp.empno%TYPE,
    p_ename IN emp.ename%TYPE,
    p_job IN emp.job%TYPE,
    p_mgr IN emp.mgr%TYPE,
    p_hiredate IN emp.hiredate%TYPE,
    p_sal IN emp.sal%TYPE,
    p_comm IN emp.comm%TYPE,
    p_deptno IN emp.deptno%TYPE
) IS
    e_invalid_deptno EXCEPTION;
    e_invalid_mgr EXCEPTION;
    e_invalid_salary EXCEPTION;
    v_mgr_sal emp.sal%TYPE;
BEGIN
    -- Check if department number is valid
    IF NOT EXISTS (SELECT 1 FROM dept WHERE deptno = p_deptno) THEN
        RAISE e_invalid_deptno;
    END IF;

    -- Check if manager number is valid
    IF p_mgr IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM emp WHERE empno = p_mgr) THEN
            RAISE e_invalid_mgr;
        ELSE
            SELECT sal INTO v_mgr_sal FROM emp WHERE empno = p_mgr;
            -- Validate salary
            IF p_sal > v_mgr_sal THEN
                RAISE e_invalid_salary;
            END IF;
        END IF;
    END IF;

    -- Insert employee details
    INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
    VALUES (p_empno, p_ename, p_job, p_mgr, p_hiredate, p_sal, p_comm, p_deptno);

    DBMS_OUTPUT.PUT_LINE('Employee added successfully.');

EXCEPTION
    WHEN e_invalid_deptno THEN
        DBMS_OUTPUT.PUT_LINE('Error: Invalid department number.');
    WHEN e_invalid_mgr THEN
        DBMS_OUTPUT.PUT_LINE('Error: Invalid manager number.');
    WHEN e_invalid_salary THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee salary cannot be greater than manager salary.');
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Duplicate employee number.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred: ' || SQLERRM);
END;
/

-- Test the procedure
BEGIN
    add_employee(101, 'John Doe', 'Developer', 100, SYSDATE, 5000, NULL, 10);
END;
/
