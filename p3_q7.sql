CREATE TABLE DEPTLOG (
    username VARCHAR2(50),
    log_date DATE,
    event VARCHAR2(10),
    old_deptno NUMBER,
    old_dname VARCHAR2(50),
    old_loc VARCHAR2(50),
    new_deptno NUMBER,
    new_dname VARCHAR2(50),
    new_loc VARCHAR2(50)
);


CREATE OR REPLACE TRIGGER dept_log_trigger
AFTER INSERT OR UPDATE OR DELETE ON dept
FOR EACH ROW
DECLARE
    v_username VARCHAR2(50);
BEGIN
    -- Get the current user
    SELECT USER INTO v_username FROM dual;

    -- Insert log for INSERT operation
    IF INSERTING THEN
        INSERT INTO DEPTLOG (username, log_date, event, new_deptno, new_dname, new_loc)
        VALUES (v_username, SYSDATE, 'INSERT', :NEW.deptno, :NEW.dname, :NEW.loc);
    END IF;

    -- Insert log for UPDATE operation
    IF UPDATING THEN
        INSERT INTO DEPTLOG (username, log_date, event, old_deptno, old_dname, old_loc, new_deptno, new_dname, new_loc)
        VALUES (v_username, SYSDATE, 'UPDATE', :OLD.deptno, :OLD.dname, :OLD.loc, :NEW.deptno, :NEW.dname, :NEW.loc);
    END IF;

    -- Insert log for DELETE operation
    IF DELETING THEN
        INSERT INTO DEPTLOG (username, log_date, event, old_deptno, old_dname, old_loc)
        VALUES (v_username, SYSDATE, 'DELETE', :OLD.deptno, :OLD.dname, :OLD.loc);
    END IF;
END;
