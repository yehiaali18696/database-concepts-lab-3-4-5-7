CREATE SCHEMA WBA;

CREATE TABLE WBA.SalesInvoiceElements (
    Id INTEGER PRIMARY KEY,
    ArticleName NVARCHAR(30),
    Price DECIMAL(10,4),
    Quantity INTEGER
);

INSERT INTO WBA.SalesInvoiceElements (Id, ArticleName, Price, Quantity)
VALUES (1, 'T-shirt', 25.29, 2);

INSERT INTO WBA.SalesInvoiceElements (Id, ArticleName, Price, Quantity)
VALUES (2, 'Shoes', 140.99, 1);

INSERT INTO WBA.SalesInvoiceElements (Id, ArticleName, Price, Quantity)
VALUES (3, 'Backpack', 199.99, 1);

INSERT INTO WBA.SalesInvoiceElements (Id, ArticleName, Price, Quantity)
VALUES (4, 'Hoodie', 130.99, 1);

INSERT INTO WBA.SalesInvoiceElements (Id, ArticleName, Price, Quantity)
VALUES (5, 'Paper Bag', 0.90, 2);

ALTER TABLE WBA.SalesInvoiceElements
ADD Currency NVARCHAR(3) DEFAULT 'EUR';




SELECT ArticleName, Price, Quantity
FROM WBA.SalesInvoiceElements;

SELECT ArticleName, Price, Quantity
FROM WBA.SalesInvoiceElements
WHERE Quantity > 1;