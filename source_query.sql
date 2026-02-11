-- After Uploading .csv table to Google Cloud Console, Add PRIMARY KEY to each table

-- PRIMARY KEY for Customers
ALTER TABLE `pbi-bank-muamalat-486514.transaction_data.Customers`
ADD PRIMARY KEY (CustomerID) NOT ENFORCED;

-- PRIMARY KEY for Orders
ALTER TABLE `pbi-bank-muamalat-486514.transaction_data.Orders`
ADD PRIMARY KEY (OrderID) NOT ENFORCED;

-- PRIMARY KEY for Product
ALTER TABLE `pbi-bank-muamalat-486514.transaction_data.Product`
ADD PRIMARY KEY (ProdNumber) NOT ENFORCED; 

-- PRIMARY KEY for ProductCategory
ALTER TABLE `pbi-bank-muamalat-486514.transaction_data.ProductCategory` 
ADD PRIMARY KEY (CategoryID) NOT ENFORCED;

--ADD FOREIGN KEY to table Orders,Product, and ProductCategory

-- FK CustomerID to Orders
ALTER TABLE `pbi-bank-muamalat-486514.transaction_data.Orders`
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (CustomerID)
REFERENCES `pbi-bank-muamalat-486514.transaction_data.Customers`(CustomerID)
NOT ENFORCED;

-- FK ProdNumber to Orders
ALTER TABLE `pbi-bank-muamalat-486514.transaction_data.Orders`
ADD CONSTRAINT fk_orders_product
FOREIGN KEY (ProdNumber)
REFERENCES `pbi-bank-muamalat-486514.transaction_data.Product`(ProdNumber)
NOT ENFORCED;

-- FK Category to Product
ALTER TABLE `pbi-bank-muamalat-486514.transaction_data.Product`
ADD CONSTRAINT fk_category
FOREIGN KEY (Category)
REFERENCES `pbi-bank-muamalat-486514.transaction_data.ProductCategory`(CategoryID)
NOT ENFORCED;

-- Creating Master Table for Dashboard
CREATE TABLE `pbi-bank-muamalat-486514.transaction_data.master_table` AS
SELECT
  o.OrderDate                 AS order_date,
  pc.CategoryName             AS category_name,
  p.ProdName                  AS product_name,
  p.Price                     AS product_price,
  o.Quantity                  AS order_qty,
  o.Quantity * p.Price        AS total_sales,
  c.CustomerEmail             AS cust_email,
  c.CustomerCity              AS cust_city
FROM `pbi-bank-muamalat-486514.transaction_data.Orders` o
JOIN `pbi-bank-muamalat-486514.transaction_data.Customers` c
  ON o.CustomerID = c.CustomerID
JOIN `pbi-bank-muamalat-486514.transaction_data.Product` p
  ON o.ProdNumber = p.ProdNumber
JOIN `pbi-bank-muamalat-486514.transaction_data.ProductCategory` pc
  ON p.Category = pc.CategoryID;

-- Order
SELECT *
FROM `pbi-bank-muamalat-486514.transaction_data.master_table`
ORDER BY
  order_date ASC,
  order_qty ASC;
