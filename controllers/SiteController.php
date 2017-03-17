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
}
