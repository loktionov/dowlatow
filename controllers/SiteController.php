<?php

namespace app\controllers;

use Yii;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\filters\VerbFilter;

class SiteController extends Controller
{
    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout'],
                'rules' => [
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    /**
     * @inheritdoc
     */
    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    /**
     * Displays homepage.
     *
     * @return string
     */
    public function actionIndex()
    {
        $session = Yii::$app->session;
        if (empty($session['values'])) {
            $values = self::getRandValues();
            $session['values'] = serialize($values);
        } else {
            $values = unserialize($session['values']);
        }
        return $this->render('index', ['values' => $values]);
    }

    public function actionAjax()
    {
        if (!Yii::$app->request->isAjax) {
            Yii::$app->end();
        }
        $values = self::getRandValues();
        Yii::$app->session['values'] = serialize($values);
        echo json_encode($values);
        Yii::$app->end();
    }

    /**
     * @return array
     */
    public static function getRandValues(): array
    {
        $values = array_map(function () {
            return mt_rand(100, 999);
        }, [0, 0, 0,]);
        return $values;
    }
}
