-- Create the database
CREATE DATABASE ProductionDensoDB;
GO

-- Use the newly created database
USE ProductionDensoDB;
GO

-- Create the Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(255),
    Address NVARCHAR(255),
    Email NVARCHAR(255),
    Phone NVARCHAR(20)
);

-- Create the Line_information table
CREATE TABLE Line_information (
    LineID INT PRIMARY KEY,
    Name NVARCHAR(255)
);
-- Create the Inspector table
CREATE TABLE Inspector (
    InspectorID INT PRIMARY KEY,
    Name NVARCHAR(255),
    Departments NVARCHAR(255),
    Position NVARCHAR(50),
    Age INT,
    Phone NVARCHAR(20),
    Address NVARCHAR(255)
);
-- Create the Quality_Inspection table
CREATE TABLE Quality_Inspection (
    CheckID INT PRIMARY KEY,
    CheckDate DATE,
    Results NVARCHAR(255),
    InspectorID INT,
    FOREIGN KEY (InspectorID) REFERENCES Inspector(InspectorID)
);


-- Create the Material table
CREATE TABLE Material (
    MaterialID INT PRIMARY KEY,
    Name NVARCHAR(255),
    By_Value INT
);

-- Create the Production table
CREATE TABLE Production (
    ProductID INT PRIMARY KEY,
    Name NVARCHAR(255),
    LineID INT,
    Value DECIMAL(10, 2),
    ProductType NVARCHAR(50),
    Lot_size_pallet INT,
    Lot_size_box INT,
	FOREIGN KEY (LineID) REFERENCES Line_information(LineID)
);

-- Create the Stock_Product_Information table
CREATE TABLE Stock_Product_Information (
    StockID INT,
    ProductID INT,
    Current_Stock INT,
    Update_time DATETIME,
    Expiration_Date DATETIME,
    Location NVARCHAR(255),
    PRIMARY KEY (StockID, ProductID),
    FOREIGN KEY (ProductID) REFERENCES Production(ProductID)
);

-- Create the Stock_Material_Information table
CREATE TABLE Stock_Material_Information (
    StockID INT,
    MaterialID INT,
    Current_Stock INT,
    Update_time DATETIME,
    Expiration_Date DATETIME,
    Location NVARCHAR(255),
    PRIMARY KEY (StockID, MaterialID),
    FOREIGN KEY (MaterialID) REFERENCES Material(MaterialID)
);

-- Create the Material_Production_Link table
CREATE TABLE Material_Production_Link (
    LinkID INT PRIMARY KEY,
    ProductID INT,
    MaterialID INT,
    Material_quantity_need INT,
    FOREIGN KEY (ProductID) REFERENCES Production(ProductID),
    FOREIGN KEY (MaterialID) REFERENCES Material(MaterialID)
);

-- Create the Customer_Order table
CREATE TABLE Customer_Order (
    OrderID INT,
    ProductID INT,
    CustomerID INT,
    Quantity INT,
    Value DECIMAL(10, 2),
    StatusID INT,
    Start_Day DATE,
    End_Day DATE,
    LineID INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (ProductID) REFERENCES Production(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (StatusID) REFERENCES Quality_Inspection(CheckID),
    FOREIGN KEY (LineID) REFERENCES Line_information(LineID)
);

-- Create the Actual_Process_information table
CREATE TABLE Actual_Process_information (
    StatusID INT PRIMARY KEY,
    Status NVARCHAR(50),
    QuantityDone INT,
    QualityID INT,
    Update_time DATETIME,
    ProductID INT,
    OrderID INT,
    FOREIGN KEY (QualityID) REFERENCES Quality_Inspection(CheckID),
    FOREIGN KEY (OrderID,ProductID) REFERENCES Customer_Order(OrderID,ProductID)
);
