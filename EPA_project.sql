/* Create a database */
CREATE DATABASE EPA_Project;

USE EPA_Project;

/* Create Tables: Category, Supplier, Product, Sales, Inventory, Transactions */
CREATE TABLE Category(
    CategoryID VARCHAR(4) NOT NULL, 
    CategoryName CHAR(50) NOT NULL,
    PRIMARY KEY (CategoryID)
);

CREATE TABLE Supplier(
    SupplierID VARCHAR(4) NOT NULL,
    SupplierName CHAR(50) NOT NULL,
    ContactName CHAR(25) NOT NULL,
    PhoneNumber NUMERIC(10) NOT NULL,
    Email VARCHAR(50) NOT NULL, 
    Address VARCHAR(100) NOT NULL, 
    City CHAR(50) NOT NULL, 
    State CHAR(2) NOT NULL, 
    Zip CHAR(5) NOT NULL, 
    PRIMARY KEY (SupplierID)
);

CREATE TABLE Product(
    ProductID VARCHAR(50) NOT NULL,
    ProductName VARCHAR(100) NOT NULL, 
    CategoryID VARCHAR(4) NOT NULL, 
    SupplierID VARCHAR(4) NOT NULL, 
    ProductPrice DECIMAL(10,2) NOT NULL, 
    ProductDescription TEXT,
    PRIMARY KEY (ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE Transactions (
    TransactionID VARCHAR(4) NOT NULL PRIMARY KEY,
    TransactionDate DATETIME NOT NULL
);

CREATE TABLE Sales(
    TransactionID VARCHAR(4) NOT NULL,
    ProductID VARCHAR(50) NOT NULL,
    QuantitySold SMALLINT NOT NULL, 
    SalePrice DECIMAL(10,2) NOT NULL, 
    PRIMARY KEY (TransactionID, ProductID), -- Composite primary key
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Inventory(
    InventoryID VARCHAR(4) NOT NULL,
    ProductID VARCHAR(50) NOT NULL,
    StockLevel SMALLINT NOT NULL, 
    ReorderLevel SMALLINT NOT NULL,
    LastUpdated DATE NOT NULL, 
    PRIMARY KEY (InventoryID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

/* Insert Data */
INSERT INTO Category (CategoryID, CategoryName) 
VALUES 
    ('C001', 'Hydroexcavation'),
    ('C002', 'Air Movers'),
    ('C003', 'Confined Spaces');
Select * from Category;

INSERT INTO Supplier (SupplierID, SupplierName, ContactName, PhoneNumber, Email, Address, City, State, Zip)
VALUES
    ('S001', 'North American Pressure Washer Outlet', 'Alice Smith', 1234567890, 'alice@northamericanpressurewasheroutlet.com', '123 Main St', 'Atlanta', 'GA', '30033'),
    ('S002', 'Hydrovac Store', 'Bob Brown', 2345678901, 'bob@hyrdovacstore.com', '456 Broad St', 'Boston', 'MA', '02118'),
    ('S003', 'Jetter Depot', 'Clara Jones', 3456789012, 'claraj@jetterdepot.com', '789 Elm Ave', 'Seattle', 'WA', '98039');
Select * from Supplier;

INSERT INTO Product (ProductID, ProductName, CategoryID, SupplierID, ProductPrice, ProductDescription)
VALUES 
    ('PW 300680050', '1/2" Black Linear Hydroexcavation Gun', 'C001', 'S001', 100.00, 'High Flow 32 GPM Straight Rear Entry Spray Gun for Hydro Excavation'),
    ('P AFU0824HD', '8" Flange * 8" HydroVac Crown Tube', 'C002', 'S002', 150.00, '8" Flange Heavy Duty Tube  (0.125") W/ Hydrovac Crown * 24"'),
    ('MHRSN', 'Manhole Roller', 'C003', 'S003', 99.00, 'Standard Duty (Angle Iron) with Nylon Roller');
Select * from Product;

INSERT INTO Transactions (TransactionID, TransactionDate)
VALUES
    ('T001', '2024-12-01 14:00:00'),
    ('T002', '2024-12-02 09:15:00'),
    ('T003', '2024-12-02 14:23:06');
Select * from Transactions;

INSERT INTO Sales (TransactionID, ProductID, QuantitySold, SalePrice)
VALUES
    ('T001', 'PW 300680050', 2, 249.84),
    ('T002', 'P AFU0824HD', 1, 349.50),
    ('T002', 'MHRSN', 5, 224.94),
    ('T003', 'MHRSN', 1, 224.94);
Select * from Sales;

Describe Inventory;
/*Update the StockLevel column to UNSIGNED SMALLINT*/
ALTER TABLE Inventory
MODIFY StockLevel SMALLINT UNSIGNED NOT NULL;
ALTER TABLE Inventory
MODIFY ReorderLevel SMALLINT UNSIGNED NOT NULL;
/*------------*/
INSERT INTO Inventory (InventoryID, ProductID, StockLevel, ReorderLevel, LastUpdated)
VALUES
	('I001','PW 300680050', 500, 100, '2023-12-01'),
    ('I002','P AFU0824HD', 50000,20000,'2023-10-25'),
    ('I003','MHRSN',2500,500,'2024-01-03');
Select * from Inventory;

/*Adding additoinal data*/
INSERT INTO Supplier (SupplierID, SupplierName, ContactName, PhoneNumber, Email, Address, City, State, Zip)
VALUES
    ('S004', 'Piranha Vendor', 'Derek Lee', 5678901234, 'derek@piranhavendor.com', '101 Industrial Pkwy', 'Nashville', 'TN', '37214'),
    ('S005', 'Hurco Equipment Co.', 'Elaine Carter', 6789012345, 'elaine@hurcoequipment.com', '222 Equipment St', 'Denver', 'CO', '80202');

INSERT INTO Product (ProductID, ProductName, CategoryID, SupplierID, ProductPrice, ProductDescription)
VALUES 
    ('JHP1225400', '3/4" * 400\' Orange Piranha 2500 PSI Vendor', 'C001', 'S004', 960.84, '3/4" Piranha 2500PSI, Male * Male NPT'),
    ('JHP1225500', '3/4" * 500\' Orange Piranha 2500 PSI Vendor', 'C001', 'S004', 1199.84, '3/4" Piranha 2500PSI, Male * Male NPT'),
    ('H RG0832', '8" * 32" Red Gum Vacuum Truck Hose', 'C002', 'S002', 221.94, '8" I.D, 9" O.D. 36" Bend radius. 9.26# per foot'),
    ('HR-SMK18LS', 'Hurco Ripcord Smoker 18', 'C003', 'S005', 2154.14, 'Power Smoker, Ripcord Smoker18 (Briggs-Motor) uses Liquid Smoke'),
    ('HR-SMK24-LS', 'Hurco Ripcord Smoker 24', 'C003', 'S005', 3074.14, 'Super Smoker, Ripcord24 (Briggs-Motor) uses Liquid Smoke');

INSERT INTO Transactions (TransactionID, TransactionDate)
VALUES
    ('T004', '2024-12-05 10:30:00'),
    ('T005', '2024-12-06 14:15:00'),
    ('T006', '2024-12-07 16:45:00');
    
INSERT INTO Sales (TransactionID, ProductID, QuantitySold, SalePrice)
VALUES
    ('T004', 'JHP1225400', 3, 960.84),
    ('T004', 'H RG0832', 2, 221.94),
    ('T005', 'JHP1225500', 1, 1199.84),
    ('T005', 'HR-SMK18LS', 1, 2154.14),
    ('T006', 'HR-SMK24-LS', 1, 3074.14);

INSERT INTO Inventory (InventoryID, ProductID, StockLevel, ReorderLevel, LastUpdated)
VALUES
    ('I004', 'JHP1225400', 100, 20, '2023-12-10'),
    ('I005', 'JHP1225500', 80, 15, '2023-12-11'),
    ('I006', 'H RG0832', 50, 10, '2023-12-12'),
    ('I007', 'HR-SMK18LS', 25, 5, '2023-12-13'),
    ('I008', 'HR-SMK24-LS', 20, 5, '2023-12-14');
    
UPDATE Inventory
SET StockLevel = 3
WHERE ProductID = 'HR-SMK24-LS';

SELECT * FROM Category;
SELECT * FROM Supplier;
SELECT * FROM Product;
SELECT * FROM Transactions;
SELECT * FROM Sales;
SELECT * FROM Inventory;


/*SQL STATEMENTS*/
	
/*Which products were sold in transactions that occurred after 2024-12-02 in order?*/
Select T.TransactionDate as TransactionDate, T.TransactionID as TransactionID, P.ProductID as ProductID, P.ProductName as ProductName
From Transactions as T
Join Sales as S on T.TransactionID = S.TransactionID
Join Product as P on S.ProductID = P.ProductID
Where T.TransactionDate > '2024-12-03 00:00:00'
Order by T.TransactionDate Desc;


/*Which top 3 products have generated the highest revenue?*/
Select P.ProductID, P.ProductName, S.SalePrice
From Product as P
Join Sales as S on P.ProductID = S.ProductID
Order by S.SalePrice Desc
Limit 3;

/*Which products are below their reorder level?*/
Select P.ProductID, P.ProductName, I.StockLevel, I.ReorderLevel
From Product as P
Join Inventory as I on P.ProductID = I.ProductID
Where I.StockLevel < I.ReorderLevel;


/*What is the total revenue generated by products in categories containing "Space" or "Hydro," supplied by suppliers located in 'GA', 'MA', or 'WA'?*/    
Select P.ProductID, P.ProductName, C.CategoryName, SU.SupplierName, SU.State, Sum(S.QuantitySold * S.SalePrice) as TotalRevenue
From Category as C
Join Product as P on C.CategoryID = P.CategoryID
Join Supplier as SU on P.SupplierID = SU.SupplierID
Join Sales as S on P.ProductID = S.ProductID
Where (C.CategoryName like '%Space%' or C.CategoryName like '%Hydro%') and SU.State in ('GA','MA','WA')
Group by P.ProductID, P.ProductName, C.CategoryName, SU.SupplierName, SU.State;



