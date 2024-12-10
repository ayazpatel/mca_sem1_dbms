CREATE VIEW emp_dept_view AS
SELECT e.empno, e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

CREATE OR REPLACE TRIGGER insted_of_update_emp_dept_view
	INSTEAD OF UPDATE
	ON emp_dept
BEGIN
	UPDATE emp_dept
		SET ename =:NEW.ename
		WHERE empno =:OLD.empno;
END;