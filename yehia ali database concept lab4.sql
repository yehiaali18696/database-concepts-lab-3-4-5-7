CREATE TABLE WBA.Articles (
    Id INTEGER PRIMARY KEY,
    ArticleName NVARCHAR(30) UNIQUE NOT NULL,
    ArticleBarcode NVARCHAR(13)
);

CREATE INDEX IDX_Articles_Barcode ON WBA.Articles(ArticleBarcode);
INSERT INTO WBA.Articles (Id, ArticleName, ArticleBarcode)
VALUES (1, 'Tomato', '1234567891230'),
       (2, 'Potato', '1234567891231'),
       (3, 'Bean', '1234567891232'),
       (4, 'Garlic', '1234567891233'),
       (5, 'Lettuce', '1234567891234');

DELETE FROM WBA.SalesInvoiceElements;
ALTER TABLE WBA.SalesInvoiceElements

ADD ArticleId INTEGER,

 FOREIGN KEY (ArticleId) REFERENCES WBA.Articles(Id);

 ALTER TABLE WBA.SalesInvoiceElements
ADD Value AS (Quantity * Price) PERSISTED;


ALTER TABLE WBA.SalesInvoiceElements
DROP COLUMN ArticleName;


INSERT INTO WBA.SalesInvoiceElements (Id, Price, Quantity)
SELECT a.Id, 
       ROUND(CAST((RAND() * 99.99 + 1) AS DECIMAL(5,2)), 2), 
       CAST((RAND() * 24 + 1) AS INT)
FROM WBA.Articles AS a;

SELECT se.Quantity, a.ArticleName AS Name, a.ArticleBarcode AS Barcode
FROM WBA.SalesInvoiceElements AS se
INNER JOIN WBA.Articles AS a ON se.ArticleId = a.Id
WHERE se.Quantity > 1;

SELECT a.ArticleName, a.ArticleBarcode, (
    SELECT se.Quantity, se.Price
    FROM WBA.SalesInvoiceElements AS se
    WHERE se.ArticleId = a.Id
    FOR JSON PATH
) AS SalesInvoiceElements
FROM WBA.Articles AS a
WHERE a.ArticleBarcode <> '1234567891231';

SELECT *
FROM WBA.SalesInvoiceElements
CROSS JOIN WBA.Articles;

CREATE VIEW CombinedInformation AS
SELECT se.Id AS SalesInvoiceId, se.ArticleId AS SalesInvoiceArticleId, se.Price, se.Quantity, a.Id AS ArticleId, a.ArticleName, a.ArticleBarcode
FROM WBA.SalesInvoiceElements AS se
JOIN WBA.Articles AS a ON se.ArticleId = a.Id;