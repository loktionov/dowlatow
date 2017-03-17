Задание на вакансию PHP-программист
============================

![preview](https://github.com/loktionov/dowlatow/blob/master/digits.png)

1. MySQL
-----------------------------

>Дана структура и данные статей и категорий сайта.
>Требуется написать запрос, которым мы получим по 2 статьи каждой категории.

[Дамп БД](https://github.com/loktionov/dowlatow/blob/master/MySQLtask/dowlatow_dump.sql)


[Решение](https://github.com/loktionov/dowlatow/blob/master/MySQLtask/row_number.sql)

```mysql
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
```

***Используется эмуляция функции ROW_NUMBER() SQLServer***


2. PHP-framework Yii2 
-----------------------------

>На любом php фреймворке или CMS, с использованием библиотеки jQuery сделать следующее:
>На странице 3 рандомных числа.
>Нажимая на любое число - числа ajax'ом сменяются.
>Если обновляем страницу - числа должны оставаться те, что есть.
>Числа хранить ТОЛЬКО в сессии, не в куках.

[Controller](https://github.com/loktionov/dowlatow/blob/master/controllers/SiteController.php)

```php

    /**
         * Displays homepage.
         *
         * @return string
         */
        public function actionIndex()
        {
    
            return $this->render('index', ['values' => self::getRandValues(true)]);
        }
    
        public function actionAjax()
        {
            if (!Yii::$app->request->isAjax) {
                Yii::$app->end();
            }
            echo json_encode(self::getRandValues());
            Yii::$app->end();
        }
    
        /**
         * @param bool $from_session
         * @return array
         */
        public static function getRandValues($from_session = false): array
        {
            if ($from_session) {
                $session = Yii::$app->session;
                if (empty($session['values'])) {
                    $values = self::getRandArray();
                } else {
                    $values = unserialize($session['values']);
                    if ($values === false OR !is_array($values) OR count($values) != 3) {
                        $values = self::getRandArray();
                    }
                }
            } else {
                $values = self::getRandArray();
            }
            return $values;
        }
    
        /**
         * @return array
         */
        private static function getRandArray(): array
        {
            $values = array_map(function () {
                return mt_rand(100, 999);
            }, [0, 0, 0,]);
            Yii::$app->session['values'] = serialize($values);
            return $values;
        }

```

[View](https://github.com/loktionov/dowlatow/blob/master/views/site/index.php)

```php
<div id="digits-container">
    <div>
        <?php foreach ($values as $k => $v) { ?>
            <div class="digits" id="digit<?= $k ?>">
                <?= $v ?>
            </div>
        <?php } ?>
    </div>
</div>
```
[JavaScript](https://github.com/loktionov/dowlatow/blob/master/web/js/ajax.js)

```javascript

$(document).ready(function () {
    $('.digits').click(function () {
        $.ajax({
            url: '/?r=site/ajax',
            dataType: 'json',
            success: function (data) {
                $.each(data, function (i, v) {
                    $('div#digit' + i).html(v);
                })
            }
        });
    })
});

```
