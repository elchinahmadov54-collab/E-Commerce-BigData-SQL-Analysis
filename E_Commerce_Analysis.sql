
DROP TABLE IF EXISTS Order_Items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Country VARCHAR(50),
    Signup_Date DATE
);

CREATE TABLE Products (
    Product_ID SERIAL PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Order_Date DATE,
    Total_Amount DECIMAL(10,2)
);

INSERT INTO Customers (Name, Country, Signup_Date)
SELECT 
    'Customer_' || generate_series, -
    (ARRAY['Azerbaijan', 'Poland', 'USA', 'Germany', 'Turkey'])[floor(random()*5)+1], 
FROM generate_series(1, 1000);


INSERT INTO Products (Product_Name, Category, Price) VALUES
('iPhone 15', 'Electronics', 1200), ('Laptop Dell', 'Electronics', 1500),
('Smart Watch', 'Electronics', 300), ('Nike Shoes', 'Fashion', 120),
('Adidas T-Shirt', 'Fashion', 50), ('Coffee Maker', 'Home', 200),
('Gaming Mouse', 'Electronics', 80), ('Sofa', 'Home', 700);

INSERT INTO Orders (Customer_ID, Order_Date, Total_Amount)
SELECT 
    floor(random()*1000)+1, 
    '2023-01-01'::DATE + (random()*700)::INT, 
    (random()*500 + 50)::DECIMAL(10,2) 
FROM generate_series(1, 20000); 

SELECT COUNT(*) FROM Orders;

SELECT 
    Customer_ID,
    MAX(Order_Date) as Last_Order_Date,   -
    COUNT(*) as Total_Orders,             
    SUM(Total_Amount) as Total_Spent,     
    CASE 
        WHEN SUM(Total_Amount) > 5000 THEN 'VIP Customer'
        WHEN COUNT(*) > 20 THEN 'Loyal Customer'
        ELSE 'Regular'
    END as Customer_Segment
FROM Orders
GROUP BY Customer_ID
ORDER BY Total_Spent DESC
LIMIT 10; 

SELECT 
    Order_Date,
    SUM(Total_Amount) as Daily_Sales,
    AVG(SUM(Total_Amount)) OVER (ORDER BY Order_Date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as Moving_Avg_7_Days
FROM Orders
GROUP BY Order_Date
ORDER BY Order_Date
LIMIT 20;

WITH Yearly_Sales AS (
    SELECT 
        EXTRACT(YEAR FROM Order_Date) as Sales_Year,
        SUM(Total_Amount) as Total_Revenue
    FROM Orders
    GROUP BY EXTRACT(YEAR FROM Order_Date)
)
SELECT 
    Sales_Year,
    Total_Revenue,
    LAG(Total_Revenue) OVER (ORDER BY Sales_Year) as Previous_Year_Revenue,
    ROUND(
        (Total_Revenue - LAG(Total_Revenue) OVER (ORDER BY Sales_Year)) 
        / LAG(Total_Revenue) OVER (ORDER BY Sales_Year) * 100
    , 2) as Growth_Percentage
FROM Yearly_Sales;