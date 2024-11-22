DECLARE
    TYPE CustomerTableType IS TABLE OF Customers%ROWTYPE;
    CustomerList CustomerTableType;

    TYPE ProductTableType IS TABLE OF Products%ROWTYPE;
    ProductList ProductTableType;
BEGIN
    -- Bulk Collect Customers
    SELECT * BULK COLLECT INTO CustomerList FROM Customers WHERE Email_Office IS NOT NULL;

    -- Process each customer
    FOR i IN CustomerList.FIRST .. CustomerList.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('Processing Customer: ' || CustomerList(i).First_Name || ' ' || CustomerList(i).Last_Name);
    END LOOP;

    -- Bulk Insert Products
    ProductList := ProductTableType();
    ProductList.EXTEND(3);

    ProductList(1) := Products%ROWTYPE(Product_ID => NULL, Book_Title => 'New Book 1', Book_Price => 19.99, Book_Quantity => 50);
    ProductList(2) := Products%ROWTYPE(Product_ID => NULL, Book_Title => 'New Book 2', Book_Price => 29.99, Book_Quantity => 30);
    ProductList(3) := Products%ROWTYPE(Product_ID => NULL, Book_Title => 'New Book 3', Book_Price => 39.99, Book_Quantity => 20);

    FORALL i IN ProductList.FIRST .. ProductList.LAST
        INSERT INTO Products (Book_Title, Book_Price, Book_Quantity)
        VALUES (ProductList(i).Book_Title, ProductList(i).Book_Price, ProductList(i).Book_Quantity);

    DBMS_OUTPUT.PUT_LINE('Bulk insert of products completed.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/
