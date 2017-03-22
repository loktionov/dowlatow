SELECT b.rn, b.cat_id, b.art_id, b.article, b.category FROM (
SELECT     
  @rn:=CASE WHEN a.cat_id = @cat_id THEN @rn + 1 ELSE 1 END AS rn,
  @cat_id:=a.cat_id AS cat, 
  a.*
  FROM 
  
    (
      SELECT 
        c.id AS cat_id,
        a.id AS art_id,
          a.title AS article,        
          c.title as category 
    FROM articles_categories ac
    JOIN articles a ON a.id=ac.article_id
    JOIN categories c ON c.id=ac.category_id      
    ORDER BY c.id, article
    ) a 
  
  ) b
 
 WHERE b.rn <= 2
