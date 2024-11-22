BEGIN
    IF LENGTH(:First_Name) < 2 THEN
        RAISE_APPLICATION_ERROR(-20001, 'First name is too short.');
    END IF;

    INSERT INTO Customers (First_Name, Last_Name, Email_Office) VALUES (:First_Name, :Last_Name, :Email_Office);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
