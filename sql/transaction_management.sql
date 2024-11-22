BEGIN
    SAVEPOINT sp1;
    UPDATE Products 
      SET Book_Quantity = Book_Quantity - 1 
      WHERE Product_ID = 1;

    IF Book_Quantity < 0 THEN
        ROLLBACK TO sp1;
        RAISE_APPLICATION_ERROR(-20002, 'Insufficient quantity.');
    END IF;

    COMMIT;
END;
