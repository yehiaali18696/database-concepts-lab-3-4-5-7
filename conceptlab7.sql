

CREATE PROCEDURE WBA.SaveArticle
  @Id INT,
  @Name NVARCHAR(255),
  @Weight DECIMAL(10, 2),
  @Price DECIMAL(10, 2),
  @Barcode NVARCHAR(13)
AS
BEGIN
  IF EXISTS (SELECT * FROM WBA.Articles WHERE Id = @Id)
  BEGIN
    -- Article with the given Id exists, perform an update
    UPDATE WBA.Articles
    SET ArticleName = @Name,
        Weight = @Weight,
        Price = @Price,
        ArticleBarcode = @Barcode
    WHERE Id = @Id;
  END
  ELSE
  BEGIN
    -- Article with the given Id does not exist, perform an insert
    INSERT INTO WBA.Articles (Id, ArticleName, Weight, Price, ArticleBarcode)
    VALUES (@Id, @Name, @Weight, @Price, @Barcode);
  END
END;


CREATE PROCEDURE WBA.ArticleGetByBarcode
  @Barcode NVARCHAR(13)
AS
BEGIN
  SELECT Id, ArticleName, Weight
  FROM WBA.Articles
  WHERE ArticleBarcode = @Barcode;
END;

CREATE FUNCTION WBA.ArticleGetSumWeights()
RETURNS INT
AS
BEGIN
  DECLARE @SumWeights DECIMAL(10, 2);

  SELECT @SumWeights = SUM(Weight)
  FROM WBA.Articles;

  RETURN ROUND(@SumWeights, 0);
END;