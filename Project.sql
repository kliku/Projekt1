CREATE TABLE customer (
    ID NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    FirstName VARCHAR2(100),
    LastName VARCHAR2(100),
    Address VARCHAR2(255),
    City VARCHAR2(100),
    State VARCHAR2(100),
    PostalCode VARCHAR2(20),
    Phone VARCHAR2(20)
);

CREATE TABLE product (
    ID NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Title VARCHAR2(255),
    Author VARCHAR2(100),
    Price NUMBER(10,2),
    Availability VARCHAR2(50)
);

CREATE TABLE ord (
    ID NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Customer_ID NUMBER(10) NOT NULL,
    Product_ID NUMBER(10) NOT NULL,
    Shop_ID NUMBER(10) NOT NULL,
    Employee_ID NUMBER(10) NOT NULL,
    DateOrdered DATE,
    DateShipped DATE,
    Total NUMBER(10,2),
    PaymentType VARCHAR2(50),
    OrderFilled CHAR(1), 
    FOREIGN KEY (Customer_ID) REFERENCES Customer(ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(ID),
    FOREIGN KEY (Shop_ID) REFERENCES Shop(ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(ID)
);

CREATE TABLE employee (
    ID NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    FirstName VARCHAR2(100),
    LastName VARCHAR2(100),
    Salary NUMBER(10,2),
    Shop_ID NUMBER(10) NOT NULL,
    FOREIGN KEY (Shop_ID) REFERENCES Shop(ID)
);

CREATE TABLE shop (
    ID NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Name VARCHAR2(100),
    Location VARCHAR2(255)
);

CREATE TABLE ProcedureLog (
    LogID          NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ProcedureName  VARCHAR2(100),
    Action         VARCHAR2(50),
    TimeStamp      TIMESTAMP,
    Details        VARCHAR2(4000),
    ErrorMessage   VARCHAR2(4000)
);


INSERT INTO Customer (FirstName, LastName, Address, City, State, PostalCode, Phone)
VALUES ('Adam', 'Kowalski', 'Ulica Polna 5', 'Warszawa', 'Mazowieckie', '00-001', '123456789');
INSERT INTO Customer (FirstName, LastName, Address, City, State, PostalCode, Phone)
VALUES ('Anna', 'Nowakowska', 'Ulica Wy¿ynna 10', 'Warszawa', 'Mazowieckie', '00-002', '987654321');
INSERT INTO Customer (FirstName, LastName, Address, City, State, PostalCode, Phone)
VALUES ('Pawe³', 'Wdowiak', 'Ulica Ametystowa 3, Apt 2', 'Kraków', 'Ma³opolskie', '00-003', '234567890');
INSERT INTO Customer (FirstName, LastName, Address, City, State, PostalCode, Phone)
VALUES ('Katarzyna', 'Maj', 'Ulica Witosa 15', 'Wroc³aw', 'Dolnoœl¹skie', '00-004', '345678901');
INSERT INTO Customer (FirstName, LastName, Address, City, State, PostalCode, Phone)
VALUES ('Marek', 'Przybyszewski', 'Ulica Bojarczuka 20', 'Gdañsk', 'Pomorskie', '00-005', '456789012');

    
INSERT INTO Product (Title, Author, Price, Availability) 
VALUES ('W³adca Pierœcieni', 'J.R.R. Tolkien', 59.89, 'In Stock');
INSERT INTO Product (Title, Author, Price, Availability) 
VALUES ('Hobbit', 'J.R.R. Tolkien', 39.99, 'In Stock');
INSERT INTO Product (Title, Author, Price, Availability)
VALUES ('Harry Potter', 'J.K. Rowling', 49.99, 'In Stock');
INSERT INTO Product (Title, Author, Price, Availability)
VALUES ('Gra o Tron', 'George R.R. Martin', 69.99, 'Out of Stock');
INSERT INTO Product (Title, Author, Price, Availability) 
VALUES ('1984', 'George Orwell', 49.99, 'In Stock');


INSERT INTO ord (Customer_ID, Product_ID, Shop_ID, Employee_ID, DateOrdered, DateShipped, Total, PaymentType, OrderFilled) 
VALUES (1, 1, 1, 1, TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2023-11-03', 'YYYY-MM-DD'), 49.99, 'Credit Card', 'Y');
INSERT INTO ord (Customer_ID, Product_ID, Shop_ID, Employee_ID, DateOrdered, DateShipped, Total, PaymentType, OrderFilled) 
VALUES (2, 3, 1, 2, TO_DATE('2023-11-02', 'YYYY-MM-DD'), TO_DATE('2023-11-04', 'YYYY-MM-DD'), 39.99, 'PayPal', 'N');
INSERT INTO ord (Customer_ID, Product_ID, Shop_ID, Employee_ID, DateOrdered, DateShipped, Total, PaymentType, OrderFilled) 
VALUES (3, 2, 2, 3, TO_DATE('2023-11-03', 'YYYY-MM-DD'), TO_DATE('2023-11-05', 'YYYY-MM-DD'), 35.99, 'Credit Card', 'Y');
INSERT INTO ord (Customer_ID, Product_ID, Shop_ID, Employee_ID, DateOrdered, DateShipped, Total, PaymentType, OrderFilled) 
VALUES (4, 5, 2, 4, TO_DATE('2023-11-04', 'YYYY-MM-DD'), TO_DATE('2023-11-06', 'YYYY-MM-DD'), 29.99, 'Cash', 'Y');
INSERT INTO ord (Customer_ID, Product_ID, Shop_ID, Employee_ID, DateOrdered, DateShipped, Total, PaymentType, OrderFilled) 
VALUES (5, 4, 3, 5, TO_DATE('2023-11-05', 'YYYY-MM-DD'), NULL, 59.99, 'Credit Card', 'N');

INSERT INTO Employee ( FirstName, LastName, Salary, Shop_ID) 
VALUES ('Anna', 'Kowalska', 4200.00, 1);
INSERT INTO Employee ( FirstName, LastName, Salary, Shop_ID) 
VALUES ('Piotr', 'Kowalski', 4400.00, 1);
INSERT INTO Employee ( FirstName, LastName, Salary, Shop_ID) 
VALUES ('£ukasz', 'Mazurek', 4000.00, 2);
INSERT INTO Employee ( FirstName, LastName, Salary, Shop_ID) 
VALUES ('Magdalena', 'Kaczmarek', 4500.00, 3);
INSERT INTO Employee ( FirstName, LastName, Salary, Shop_ID) 
VALUES ('Marcin', 'Gwarda', 4300.00, 4);
       
INSERT INTO Shop (Name, Location) 
VALUES ('Ksiêgarnia Centrum', 'Warszawa, Centrum');
INSERT INTO Shop (Name, Location) 
VALUES ('Ksiêgarnia Miejska', 'Kraków, Kazimierz');
INSERT INTO Shop (Name, Location) 
VALUES ('Ksiêgarnia Miejska', 'Lublin, Stare Miasto');
INSERT INTO Shop (Name, Location) 
VALUES ('Ksiêgarnia Literacka', 'Gdañsk, G³ówne Miasto');
INSERT INTO Shop (Name, Location) 
VALUES ('Ksiêgarnia Akademicka', 'Poznañ, Centrum');
       
--Procedury
CREATE OR REPLACE PROCEDURE LogProcedureActivity(
    p_ProcedureName IN VARCHAR2,
    p_Action        IN VARCHAR2,
    p_Details       IN VARCHAR2 DEFAULT NULL,
    p_ErrorMessage  IN VARCHAR2 DEFAULT NULL
) AS
BEGIN
    INSERT INTO ProcedureLog (ProcedureName, Action, TimeStamp, Details, ErrorMessage)
    VALUES (p_ProcedureName, p_Action, CURRENT_TIMESTAMP, p_Details, p_ErrorMessage);
END;

CREATE OR REPLACE PROCEDURE AddCustomer (
    c_firstName IN Customer.FirstName%TYPE,
    c_lastName IN Customer.LastName%TYPE,
    c_address IN Customer.Address%TYPE,
    c_city IN Customer.City%TYPE,
    c_state IN Customer.State%TYPE,
    c_postalCode IN Customer.PostalCode%TYPE,
    c_phone IN Customer.Phone%TYPE
) AS 
BEGIN
    LogProcedureActivity('AddCustomer', 'Start');

    INSERT INTO Customer (FirstName, LastName, Address, City, State, PostalCode, Phone) 
    VALUES (c_firstName, c_lastName, c_address, c_city, c_state, c_postalCode, c_phone);

    LogProcedureActivity('AddCustomer', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('AddCustomer', 'B³¹d', NULL, SQLERRM);
        RAISE;
END;

CREATE OR REPLACE PROCEDURE UpdateCustomer (
    c_id IN Customer.ID%TYPE,
    c_firstName IN Customer.FirstName%TYPE,
    c_lastName IN Customer.LastName%TYPE,
    c_address IN Customer.Address%TYPE,
    c_city IN Customer.City%TYPE,
    c_state IN Customer.State%TYPE,
    c_postalCode IN Customer.PostalCode%TYPE,
    c_phone IN Customer.Phone%TYPE
) AS 
BEGIN
    LogProcedureActivity('UpdateCustomer', 'Start');

    UPDATE Customer
    SET FirstName = c_firstName, 
        LastName = c_lastName, 
        Address = c_address, 
        City = c_city, 
        State = c_state, 
        PostalCode = c_postalCode, 
        Phone = c_phone
    WHERE ID = c_id;

    LogProcedureActivity('UpdateCustomer', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('UpdateCustomer', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE DeleteCustomer (c_id IN Customer.ID%TYPE) AS 
BEGIN
    LogProcedureActivity('DeleteCustomer', 'Start');

    UPDATE ord SET Customer_ID = NULL WHERE Customer_ID = c_id;
    LogProcedureActivity('DeleteCustomer', 'AktualizacjaORD');

    DELETE FROM Customer WHERE ID = c_id;
    LogProcedureActivity('DeleteCustomer', 'UsuniêcieKlienta');

EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('DeleteCustomer', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;


CREATE OR REPLACE PROCEDURE AddProduct (
    p_title IN Product.Title%TYPE,
    p_author IN Product.Author%TYPE,
    p_price IN Product.Price%TYPE,
    p_availability IN Product.Availability%TYPE
) AS 
BEGIN
    LogProcedureActivity('AddProduct', 'Start');

    INSERT INTO Product (Title, Author, Price, Availability) 
    VALUES (p_title, p_author, p_price, p_availability);

    LogProcedureActivity('AddProduct', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('AddProduct', 'B³¹d', NULL, SQLERRM);
        RAISE;
END;

CREATE OR REPLACE PROCEDURE UpdateProduct (
    p_id IN Product.ID%TYPE,
    p_title IN Product.Title%TYPE,
    p_author IN Product.Author%TYPE,
    p_price IN Product.Price%TYPE,
    p_availability IN Product.Availability%TYPE
) AS 
BEGIN
    LogProcedureActivity('UpdateProduct', 'Start');

    UPDATE Product
    SET Title = p_title,
        Author = p_author,
        Price = p_price,
        Availability = p_availability
    WHERE ID = p_id;

    LogProcedureActivity('UpdateProduct', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('UpdateProduct', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE DeleteProduct (p_id IN Product.ID%TYPE) AS 
BEGIN
    LogProcedureActivity('DeleteProduct', 'Start');

    UPDATE ord SET Product_ID = NULL WHERE Product_ID = p_id;
    LogProcedureActivity('DeleteProduct', 'AktualizacjaORD');

    DELETE FROM Product WHERE ID = p_id;
    LogProcedureActivity('DeleteProduct', 'UsuniêcieProduktu');

EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('DeleteProduct', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE AddOrder (
    p_Customer_ID IN ord.Customer_ID%TYPE,
    p_Product_ID IN ord.Product_ID%TYPE,
    p_Shop_ID IN ord.Shop_ID%TYPE,
    p_Employee_ID IN ord.Employee_ID%TYPE,
    p_DateOrdered IN ord.DateOrdered%TYPE,
    p_DateShipped IN ord.DateShipped%TYPE,
    p_Total IN ord.Total%TYPE,
    p_PaymentType IN ord.PaymentType%TYPE,
    p_OrderFilled IN ord.OrderFilled%TYPE
) AS 
BEGIN
    LogProcedureActivity('AddOrder', 'Start');

    INSERT INTO ord (Customer_ID, Product_ID, Shop_ID, Employee_ID, DateOrdered, DateShipped, Total, PaymentType, OrderFilled) 
    VALUES (p_Customer_ID, p_Product_ID, p_Shop_ID, p_Employee_ID, p_DateOrdered, p_DateShipped, p_Total, p_PaymentType, p_OrderFilled);

    LogProcedureActivity('AddOrder', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('AddOrder', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE UpdateOrder (
    p_ID IN ord.ID%TYPE,
    p_Customer_ID IN ord.Customer_ID%TYPE,
    p_Product_ID IN ord.Product_ID%TYPE,
    p_Shop_ID IN ord.Shop_ID%TYPE,
    p_Employee_ID IN ord.Employee_ID%TYPE,
    p_DateOrdered IN ord.DateOrdered%TYPE,
    p_DateShipped IN ord.DateShipped%TYPE,
    p_Total IN ord.Total%TYPE,
    p_PaymentType IN ord.PaymentType%TYPE,
    p_OrderFilled IN ord.OrderFilled%TYPE
) AS 
BEGIN
    LogProcedureActivity('UpdateOrder', 'Start');

    UPDATE ord
    SET Customer_ID = p_Customer_ID, 
        Product_ID = p_Product_ID,
        Shop_ID = p_Shop_ID,
        Employee_ID = p_Employee_ID,
        DateOrdered = p_DateOrdered,
        DateShipped = p_DateShipped,
        Total = p_Total,
        PaymentType = p_PaymentType,
        OrderFilled = p_OrderFilled
    WHERE ID = p_ID;

    LogProcedureActivity('UpdateOrder', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('UpdateOrder', 'B³¹d', NULL, SQLERRM);
        RAISE;
END;

CREATE OR REPLACE PROCEDURE DeleteOrder (p_ID IN ord.ID%TYPE) AS 
BEGIN
    LogProcedureActivity('DeleteOrder', 'Start');

    DELETE FROM ord WHERE ID = p_ID;

    LogProcedureActivity('DeleteOrder', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('DeleteOrder', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE AddEmployee (
    p_FirstName IN employee.FirstName%TYPE,
    p_LastName IN employee.LastName%TYPE,
    p_Salary IN employee.Salary%TYPE,
    p_Shop_ID IN employee.Shop_ID%TYPE
) AS 
BEGIN
    LogProcedureActivity('AddEmployee', 'Start');

    INSERT INTO employee (FirstName, LastName, Salary, Shop_ID) 
    VALUES (p_FirstName, p_LastName, p_Salary, p_Shop_ID);

    LogProcedureActivity('AddEmployee', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('AddEmployee', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE UpdateEmployee (
    p_ID IN employee.ID%TYPE,
    p_FirstName IN employee.FirstName%TYPE,
    p_LastName IN employee.LastName%TYPE,
    p_Salary IN employee.Salary%TYPE,
    p_Shop_ID IN employee.Shop_ID%TYPE
) AS 
BEGIN
    LogProcedureActivity('UpdateEmployee', 'Start');

    UPDATE employee
    SET FirstName = p_FirstName, 
        LastName = p_LastName, 
        Salary = p_Salary, 
        Shop_ID = p_Shop_ID
    WHERE ID = p_ID;

    LogProcedureActivity('UpdateEmployee', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('UpdateEmployee', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE DeleteEmployee (p_ID IN employee.ID%TYPE) AS 
BEGIN
    LogProcedureActivity('DeleteEmployee', 'Start');

    UPDATE ord SET Employee_ID = NULL WHERE Employee_ID = p_ID;
    LogProcedureActivity('DeleteEmployee', 'AktualizacjaORD');

    DELETE FROM employee WHERE ID = p_ID;
    LogProcedureActivity('DeleteEmployee', 'UsuniêciePracownika');

EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('DeleteEmployee', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE AddShop (
    p_Name IN shop.Name%TYPE,
    p_Location IN shop.Location%TYPE
) AS 
BEGIN
    LogProcedureActivity('AddShop', 'Start');

    INSERT INTO shop (Name, Location) 
    VALUES (p_Name, p_Location);

    LogProcedureActivity('AddShop', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('AddShop', 'B³¹d', NULL, SQLERRM);
        RAISE;
END;

CREATE OR REPLACE PROCEDURE UpdateShop (
    p_ID IN shop.ID%TYPE,
    p_Name IN shop.Name%TYPE,
    p_Location IN shop.Location%TYPE
) AS 
BEGIN
    LogProcedureActivity('UpdateShop', 'Start');

    UPDATE shop
    SET Name = p_Name, 
        Location = p_Location
    WHERE ID = p_ID;

    LogProcedureActivity('UpdateShop', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('UpdateShop', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE DeleteShop (p_ID IN shop.ID%TYPE) AS 
BEGIN
    LogProcedureActivity('DeleteShop', 'Start');

    UPDATE ord SET Shop_ID = NULL WHERE Shop_ID = p_ID;
    LogProcedureActivity('DeleteShop', 'AktualizacjaORD');

    DELETE FROM shop WHERE ID = p_ID;
    LogProcedureActivity('DeleteShop', 'UsuniêcieSklepu');

EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('DeleteShop', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE MergeCustomer (
    p_firstName IN Customer.FirstName%TYPE,
    p_lastName IN Customer.LastName%TYPE,
    p_address IN Customer.Address%TYPE,
    p_city IN Customer.City%TYPE,
    p_state IN Customer.State%TYPE,
    p_postalCode IN Customer.PostalCode%TYPE,
    p_phone IN Customer.Phone%TYPE
) AS
BEGIN
    LogProcedureActivity('MergeCustomer', 'Start');

    MERGE INTO Customer C
    USING (SELECT p_firstName, p_lastName FROM DUAL) F
    ON (C.FirstName = F.p_firstName AND C.LastName = F.p_lastName)
    WHEN MATCHED THEN
        UPDATE SET C.Address = p_address, C.City = p_city, C.State = p_state, C.PostalCode = p_postalCode, C.Phone = p_phone
    WHEN NOT MATCHED THEN
        INSERT (FirstName, LastName, Address, City, State, PostalCode, Phone)
        VALUES (p_firstName, p_lastName, p_address, p_city, p_state, p_postalCode, p_phone);

    LogProcedureActivity('MergeCustomer', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('MergeCustomer', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE MergeProduct (
    p_title IN Product.Title%TYPE,
    p_author IN Product.Author%TYPE,
    p_price IN Product.Price%TYPE,
    p_availability IN Product.Availability%TYPE
) AS
BEGIN
    LogProcedureActivity('MergeProduct', 'Start');

    MERGE INTO Product P
    USING (SELECT p_title FROM DUAL) F
    ON (P.Title = F.p_title)
    WHEN MATCHED THEN
        UPDATE SET P.Author = p_author, P.Price = p_price, P.Availability = p_availability
    WHEN NOT MATCHED THEN
        INSERT (Title, Author, Price, Availability)
        VALUES (p_title, p_author, p_price, p_availability);

    LogProcedureActivity('MergeProduct', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('MergeProduct', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE MergeOrder (
    p_Customer_ID IN ord.Customer_ID%TYPE,
    p_Product_ID IN ord.Product_ID%TYPE,
    p_DateOrdered IN ord.DateOrdered%TYPE,
    p_Shop_ID IN ord.Shop_ID%TYPE,
    p_Employee_ID IN ord.Employee_ID%TYPE,
    p_DateShipped IN ord.DateShipped%TYPE,
    p_Total IN ord.Total%TYPE,
    p_PaymentType IN ord.PaymentType%TYPE,
    p_OrderFilled IN ord.OrderFilled%TYPE
) AS
BEGIN
    LogProcedureActivity('MergeOrder', 'Start');

    MERGE INTO ord O
    USING (SELECT p_Customer_ID, p_Product_ID, p_DateOrdered FROM DUAL) F
    ON (O.Customer_ID = F.p_Customer_ID AND O.Product_ID = F.p_Product_ID AND O.DateOrdered = F.p_DateOrdered)
    WHEN MATCHED THEN
        UPDATE SET O.Shop_ID = p_Shop_ID, O.Employee_ID = p_Employee_ID, O.DateShipped = p_DateShipped, O.Total = p_Total, O.PaymentType = p_PaymentType, O.OrderFilled = p_OrderFilled
    WHEN NOT MATCHED THEN
        INSERT (Customer_ID, Product_ID, DateOrdered, Shop_ID, Employee_ID, DateShipped, Total, PaymentType, OrderFilled)
        VALUES (p_Customer_ID, p_Product_ID, p_DateOrdered, p_Shop_ID, p_Employee_ID, p_DateShipped, p_Total, p_PaymentType, p_OrderFilled);

    LogProcedureActivity('MergeOrder', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('MergeOrder', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE MergeEmployee (
    p_FirstName IN employee.FirstName%TYPE,
    p_LastName IN employee.LastName%TYPE,
    p_Salary IN employee.Salary%TYPE,
    p_Shop_ID IN employee.Shop_ID%TYPE
) AS
BEGIN
    LogProcedureActivity('MergeEmployee', 'Start');

    MERGE INTO employee E
    USING (SELECT p_FirstName, p_LastName FROM DUAL) F
    ON (E.FirstName = F.p_FirstName AND E.LastName = F.p_LastName)
    WHEN MATCHED THEN
        UPDATE SET E.Salary = p_Salary, E.Shop_ID = p_Shop_ID
    WHEN NOT MATCHED THEN
        INSERT (FirstName, LastName, Salary, Shop_ID)
        VALUES (p_FirstName, p_LastName, p_Salary, p_Shop_ID);

    LogProcedureActivity('MergeEmployee', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('MergeEmployee', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

CREATE OR REPLACE PROCEDURE MergeShop (
    p_name IN Shop.Name%TYPE,
    p_location IN Shop.Location%TYPE
) AS
BEGIN
    LogProcedureActivity('MergeShop', 'Start');

    MERGE INTO Shop S
    USING (SELECT p_name FROM DUAL) F
    ON (S.Name = F.p_name)
    WHEN MATCHED THEN
        UPDATE SET S.Location = p_location
    WHEN NOT MATCHED THEN
        INSERT (Name, Location)
        VALUES (p_name, p_location);

    LogProcedureActivity('MergeShop', 'Koniec');
EXCEPTION
    WHEN OTHERS THEN
        LogProcedureActivity('MergeShop', 'B³¹d', NULL, SQLERRM);
        RAISE; 
END;

--funkcje
CREATE OR REPLACE FUNCTION calculate_order_total(order_id IN NUMBER)
RETURN NUMBER IS
    total_cost NUMBER(10,2) := 0;
BEGIN
    SELECT SUM(p.Price)
    INTO total_cost
    FROM ord o
    JOIN product p ON o.Product_ID = p.ID
    WHERE o.ID = order_id;

    RETURN total_cost;
END;

CREATE OR REPLACE FUNCTION average_order_value(customer_id IN NUMBER)
RETURN NUMBER IS
    average_value NUMBER(10,2);
BEGIN
    SELECT AVG(Total)
    INTO average_value
    FROM ord
    WHERE Customer_ID = customer_id;

    RETURN average_value;
END;

CREATE OR REPLACE FUNCTION check_order_status(order_id IN NUMBER)
RETURN VARCHAR2 IS
    order_status CHAR(1);
BEGIN
    SELECT OrderFilled
    INTO order_status
    FROM ord
    WHERE ID = order_id;

    IF order_status = 'Y' THEN
        RETURN 'Zrealizowane';
    ELSE
        RETURN 'Nie zrealizowane';
    END IF;
END;

CREATE OR REPLACE FUNCTION total_sales_for_shop(shop_id IN NUMBER)
RETURN NUMBER IS
    total_sales NUMBER(10,2);
BEGIN
    SELECT SUM(Total)
    INTO total_sales
    FROM ord
    WHERE Shop_ID = shop_id;

    RETURN total_sales;
END;

CREATE OR REPLACE FUNCTION find_available_products
RETURN SYS_REFCURSOR IS
    available_products_cursor SYS_REFCURSOR;
BEGIN
    OPEN available_products_cursor FOR
        SELECT * FROM product WHERE Availability = 'Available';
    RETURN available_products_cursor;
END;

--widoki
CREATE VIEW customer_orders_view AS
SELECT o.ID AS OrderID, c.ID AS CustomerID, c.FirstName, c.LastName, o.DateOrdered, o.Total
FROM ord o
JOIN customer c ON o.Customer_ID = c.ID;

CREATE VIEW order_details_view AS
SELECT o.ID AS OrderID, p.ID AS ProductID, p.Title, p.Author, p.Price, o.DateOrdered, o.DateShipped
FROM ord o
JOIN product p ON o.Product_ID = p.ID;

CREATE VIEW shop_sales_view AS
SELECT s.ID AS ShopID, s.Name, SUM(o.Total) AS TotalSales
FROM ord o
JOIN shop s ON o.Shop_ID = s.ID
GROUP BY s.ID, s.Name;

--PODZAPYTANIA
SELECT * FROM customer c
WHERE EXISTS (
    SELECT 1 FROM ord o
    WHERE o.Customer_ID = c.ID AND o.Product_ID = 1
);


SELECT * FROM product p
WHERE NOT EXISTS (
    SELECT 1 FROM ord o
    WHERE o.Product_ID = p.ID
);


SELECT e.* FROM employee e
WHERE EXISTS (
    SELECT 1 FROM ord o
    WHERE o.Employee_ID = e.ID AND o.Total > 40
);


SELECT * FROM customer c
WHERE EXISTS (
    SELECT 1 FROM ord o
    WHERE o.Customer_ID = c.ID AND o.DateOrdered > TO_DATE('2022-01-01', 'YYYY-MM-DD')
);


SELECT * FROM product p
WHERE EXISTS (
    SELECT 1 FROM ord o
    WHERE o.Product_ID = p.ID
    GROUP BY o.Shop_ID
    HAVING COUNT(DISTINCT o.Shop_ID) > 1
);


SELECT * FROM ord
WHERE Customer_ID = 2
AND DateOrdered BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') AND TO_DATE('2023-12-31', 'YYYY-MM-DD');


SELECT * FROM shop s
WHERE NOT EXISTS (
    SELECT 1 FROM ord o
    WHERE o.Shop_ID = s.ID AND o.DateOrdered BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') AND TO_DATE('2023-12-31', 'YYYY-MM-DD')
);


SELECT p.*, o.OrderCount
FROM product p
LEFT JOIN (
    SELECT Product_ID, COUNT(*) AS OrderCount
    FROM ord
    GROUP BY Product_ID
) o ON p.ID = o.Product_ID
ORDER BY o.OrderCount DESC;


SELECT * FROM employee e
WHERE NOT EXISTS (
    SELECT 1 FROM ord o
    WHERE o.Employee_ID = e.ID
);

SELECT * FROM customer c
WHERE NOT EXISTS (
    SELECT 1 FROM product p
    WHERE NOT EXISTS (
        SELECT 1 FROM ord o
        WHERE o.Customer_ID = c.ID AND o.Product_ID = p.ID
    )
);


WITH AveragePrice AS (
    SELECT AVG(Price) AS AvgPrice FROM product
)
SELECT * FROM product
WHERE Price > (SELECT AvgPrice FROM AveragePrice);


WITH ShopOrders AS (
    SELECT Shop_ID, COUNT(*) AS NumberOfOrders
    FROM ord
    GROUP BY Shop_ID
)
SELECT s.*, so.NumberOfOrders
FROM shop s
JOIN ShopOrders so ON s.ID = so.Shop_ID;


WITH EmployeeOrders AS (
    SELECT Employee_ID, COUNT(*) AS OrdersHandled
    FROM ord
    GROUP BY Employee_ID
)
SELECT e.*, eo.OrdersHandled
FROM employee e
JOIN EmployeeOrders eo ON e.ID = eo.Employee_ID
ORDER BY eo.OrdersHandled DESC;


WITH MaxOrder AS (
    SELECT Customer_ID, MAX(Total) AS MaxTotal
    FROM ord
    GROUP BY Customer_ID
)
SELECT c.*, mo.MaxTotal
FROM customer c
JOIN MaxOrder mo ON c.ID = mo.Customer_ID;

--£¹czenie tabel
SELECT o.ID AS OrderID, c.FirstName, c.LastName, o.DateOrdered
FROM ord o
INNER JOIN customer c ON o.Customer_ID = c.ID;

SELECT c.FirstName, c.LastName, o.ID AS OrderID, o.DateOrdered
FROM customer c
LEFT JOIN ord o ON c.ID = o.Customer_ID;

SELECT c.FirstName, c.LastName, o.ID AS OrderID, o.DateOrdered
FROM ord o
RIGHT JOIN customer c ON o.Customer_ID = c.ID;

SELECT o.ID AS OrderID, p.Title, p.Author, o.DateOrdered
FROM ord o
INNER JOIN product p ON o.Product_ID = p.ID;

SELECT p.Title, p.Author, o.ID AS OrderID, o.DateOrdered
FROM product p
LEFT JOIN ord o ON p.ID = o.Product_ID;

SELECT s.Name AS ShopName, s.Location, e.FirstName, e.LastName
FROM shop s
INNER JOIN employee e ON s.ID = e.Shop_ID;

SELECT s.Name AS ShopName, s.Location, e.FirstName, e.LastName
FROM shop s
LEFT JOIN employee e ON s.ID = e.Shop_ID;

SELECT o.ID AS OrderID, e.FirstName, e.LastName, o.DateOrdered
FROM ord o
INNER JOIN employee e ON o.Employee_ID = e.ID;

SELECT o.ID AS OrderID, c.FirstName AS CustomerFirstName, c.LastName AS CustomerLastName, 
       p.Title AS ProductTitle, e.FirstName AS EmployeeFirstName, e.LastName AS EmployeeLastName, 
       o.DateOrdered, o.Total
FROM ord o
INNER JOIN customer c ON o.Customer_ID = c.ID
INNER JOIN product p ON o.Product_ID = p.ID
INNER JOIN employee e ON o.Employee_ID = e.ID;

SELECT o.ID AS OrderID, s.Name AS ShopName, s.Location, 
       c.FirstName AS CustomerName, p.Title AS ProductTitle, 
       o.DateOrdered, o.Total
FROM ord o
INNER JOIN shop s ON o.Shop_ID = s.ID
INNER JOIN customer c ON o.Customer_ID = c.ID
INNER JOIN product p ON o.Product_ID = p.ID;

SELECT e.FirstName, e.LastName, AVG(o.Total) AS AvgOrderValue
FROM employee e
INNER JOIN ord o ON e.ID = o.Employee_ID
GROUP BY e.FirstName, e.LastName;

SELECT p.Title, p.Author, o.ID AS OrderID, o.DateOrdered
FROM product p
INNER JOIN ord o ON p.ID = o.Product_ID
WHERE o.DateShipped IS NULL;

SELECT s.Name AS ShopName, COUNT(o.ID) AS NumberOfOrders
FROM shop s
LEFT JOIN ord o ON s.ID = o.Shop_ID AND o.OrderFilled = 'Y'
GROUP BY s.Name
ORDER BY NumberOfOrders DESC;

SELECT o.ID AS OrderID, p.Title, p.Author, p.Availability, COUNT(p.ID) AS AvailableProductsCount
FROM ord o
INNER JOIN product p ON o.Product_ID = p.ID
GROUP BY o.ID, p.Title, p.Author, p.Availability;

SELECT c.FirstName, c.LastName, p.Title, COUNT(o.ID) AS NumberOfOrders, SUM(o.Total) AS TotalSpent
FROM ord o
INNER JOIN customer c ON o.Customer_ID = c.ID
INNER JOIN product p ON o.Product_ID = p.ID
WHERE o.DateOrdered > TO_DATE('2022-01-01', 'YYYY-MM-DD') AND p.Price > 50
GROUP BY c.FirstName, c.LastName, p.Title
HAVING COUNT(o.ID) >= 1
ORDER BY TotalSpent DESC;

SELECT o.ID AS OrderID, c.FirstName AS CustomerFirstName, c.LastName AS CustomerLastName, 
       p.Title AS ProductTitle, p.Author AS ProductAuthor, 
       e.FirstName AS EmployeeFirstName, e.LastName AS EmployeeLastName,
       o.DateOrdered, o.Total
FROM ord o
INNER JOIN customer c ON o.Customer_ID = c.ID
INNER JOIN product p ON o.Product_ID = p.ID
INNER JOIN employee e ON o.Employee_ID = e.ID
WHERE o.Total > 40 AND o.DateShipped IS NULL
ORDER BY o.DateOrdered DESC;

SELECT s.Name AS ShopName, e.FirstName, e.LastName, 
       COUNT(DISTINCT o.ID) AS OrdersHandled, 
       AVG(o.Total) AS AverageOrderValue, 
       MAX(o.Total) AS MaxOrderValue
FROM shop s
INNER JOIN employee e ON s.ID = e.Shop_ID
LEFT JOIN ord o ON e.ID = o.Employee_ID
GROUP BY s.Name, e.FirstName, e.LastName
HAVING COUNT(DISTINCT o.ID) >= 1
ORDER BY AverageOrderValue DESC;

SELECT p.Title, p.Author, COUNT(o.ID) AS OrderCount, AVG(o.Total) AS AverageOrderValue
FROM product p
LEFT JOIN ord o ON p.ID = o.Product_ID
GROUP BY p.Title, p.Author
HAVING COUNT(o.ID) >= 1
ORDER BY AverageOrderValue DESC, OrderCount DESC;

SELECT c.FirstName, c.LastName, o.ID AS OrderID, o.DateOrdered, 
       (SELECT COUNT(*) FROM ord WHERE Customer_ID = c.ID) AS TotalOrdersByCustomer
FROM ord o
INNER JOIN customer c ON o.Customer_ID = c.ID
WHERE o.DateOrdered BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') AND TO_DATE('2023-12-31', 'YYYY-MM-DD')
AND EXISTS (SELECT 1 FROM product p WHERE o.Product_ID = p.ID AND p.Price > 40)
ORDER BY TotalOrdersByCustomer DESC, o.DateOrdered;

SELECT s.Name AS ShopName, p.Title AS ProductTitle, SUM(o.Total) AS TotalSalesValue
FROM ord o
INNER JOIN shop s ON o.Shop_ID = s.ID
INNER JOIN product p ON o.Product_ID = p.ID
GROUP BY s.Name, p.Title
HAVING SUM(o.Total) > 40
ORDER BY TotalSalesValue DESC;