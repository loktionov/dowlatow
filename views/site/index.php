<?php

/* @var $this yii\web\View */
/* @var $values array */

$this->title = 'Dowlatow Test';
?>

<div id="digits-container">
    <div>
        <?php foreach ($values as $k => $v) { ?>
            <div class="digits" id="digit<?= $k ?>">
                <?= $v ?>
            </div>
        <?php } ?>
    </div>
</div>