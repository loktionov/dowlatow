SELECT * FROM 
  
  (
    SELECT @rn:=CASE WHEN c.id = @cat_id THEN @rn + 1 ELSE 1 END AS rn,
    @cat_id:=c.id cat_id,
        a.title AS article,        
        c.title as category 
  FROM articles_categories ac
  JOIN articles a ON a.id=ac.article_id
  JOIN categories c ON c.id=ac.category_id
  ORDER BY category, article
  ) a
 
 WHERE a.rn<3