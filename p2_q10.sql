DECLARE
	vcust customer%ROWTYPE;
	vcustid customer.custid%TYPE := &vcustid;
	CURSOR ocur(cust_id customer.custid%TYPE) IS 
		SELECT ordid, orderdate, total
		FROM ord
		WHERE custid = cust_id;
	vtotalAmount ord.total%TYPE := 0;
BEGIN
	SELECT * INTO vcust
	FROM customer
	WHERE custid = vcustid;
	dbms_output.put_line('CustID: ' || vcust.custid);
	dbms_output.put_line('Name: ' || vcust.name);
	dbms_output.put_line('City: ' || vcust.city);
	FOR rec IN ocur(vcust.custid) LOOP
		dbms_output.put_line(rec.ordid || ' ' || rec.orderdate || ' ' || rec.total);
		vtotalAmount := vtotalAmount + rec.total;
	END LOOP; 
	dbms_output.put_line('Total Amount: ' || vtotalAmount);
END;
/
