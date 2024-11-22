CREATE OR REPLACE PROCEDURE Secure_Insert(p_first_name IN VARCHAR2, p_email IN VARCHAR2) AS
BEGIN
    EXECUTE IMMEDIATE 'INSERT INTO Customers (First_Name, Email_Office) VALUES (:1, :2)' USING p_first_name, p_email;
END;
