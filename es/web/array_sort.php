<?

function merge_sort($arr) {
  $count = count($arr);
  if ($count > 1) {
    $w = (int)($count / 2);
    $left = merge_sort(array_slice($arr, 0, $w));
    $right = merge_sort(array_slice($arr, $w));

    $merged = array();

    while ($left && $right) {
      if ($left[0] < $right[0]) {
        $merged[] = array_shift($left);
      } else {
        $merged[] = array_shift($right);
      }
    }

    return array_merge($merged, $left, $right);
  } else {
    return $arr;
  }
}

?>

<html>
  <head>
    <title>Сортировка массива строк</title>
    <style>
      textarea {
        width: 500px;
        height: 400px;
      }
    </style>
  </head>
  <body>
    <?
      if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $text = $_POST['text'];
        $arr = explode("\n", $text);
        echo '<h2>Результат сортировки массива слиянием:</h2>';
        $arr = merge_sort($arr);
        array_walk($arr, function($str) {
          echo '<p>' . $str . '</p>';
        });
      } else {
    ?>
      <p>Введите строки в поле:</p>
      <form action="" method="post">
        <textarea name="text"></textarea><br>
        <input type="submit" value="Сортировать">
      </form>
    <?
      }
    ?>
  </body>
</html>
