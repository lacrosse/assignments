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

echo("Введите строки поочередно, завершая ввод символом EOF:\n");

$arr = array();

while($str = fgets(STDIN)) {
  $arr[] = $str;
}

echo("Выполняется сортировка массива слиянием...\n");

$arr = merge_sort($arr);

echo("Сортированный массив:\n");

array_walk($arr, function($str) {
  echo($str);
});

?>
