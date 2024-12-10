DECLARE
    CURSOR ecur IS 
        SELECT e1.*, d1.dname
        FROM emp e1, dept d1
        WHERE e1.deptno = d1.deptno;

    CURSOR custcur (emp_id emp.empno%TYPE) IS
        SELECT * FROM customer WHERE repid = emp_id;

    CURSOR ordcur (cust_id customer.custid%TYPE) IS
        SELECT ordid, orderdate, total AS OrderAmount
        FROM ord
        WHERE custid = cust_id;

    v_total_amount NUMBER;

BEGIN
    FOR i IN ecur
    LOOP
        dbms_output.put_line(i.empno || ' ' || i.deptno || ' ' || i.dname);
        
        FOR j IN custcur(i.empno)
        LOOP
            dbms_output.put_line(' ' || j.custid || ' ' || j.name || ' ' || j.city);
            
            v_total_amount := 0;
            
            FOR k IN ordcur(j.custid)
            LOOP
                dbms_output.put_line(k.ordid || ' ' || k.orderdate || ' ' || k.OrderAmount);
                v_total_amount := v_total_amount + k.OrderAmount;
            END LOOP;
			
            dbms_output.put_line('Total Amount: ' || v_total_amount);
        END LOOP;
    END LOOP;
END;
/
