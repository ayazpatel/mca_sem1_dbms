DECLARE
	CURSOR repcur IS 
		SELECT e.empno, e.ename, e.deptno, d.dname
		FROM emp e, dept d
		WHERE e.deptno = d.deptno;
	CURSOR custdet IS
		SELECT c.custid, c.name, SUM(o.total) as total_order_amount, COUNT(o.ordid) as total_orders
		FROM customer c, ord o
		WHERE o.custid = c.custid
		GROUP BY c.custid, c.name;
	vTotalOrder NUMBER;
BEGIN
	FOR i IN repcur
	LOOP
		dbms_output.put_line(i.empno || i.ename || i.deptno || i.dname);
		FOR j IN custdet
		LOOP
			dbms_output.put_line(j.custid || ' ' || j.name || ' ' || j.total_orders || ' ' || j.total_order_amount);
		END LOOP;
	END LOOP;
END;
/
