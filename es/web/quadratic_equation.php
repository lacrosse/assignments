<?

function get_f() {
  return (float)fgets(STDIN);
}

function get_nonzero_f() {
  $res = null;

  while(!$res) {
    $res = get_f();
    if ($res == 0) {
      echo("Введен нулевой коэффициент, попробуйте снова:\n");
      $res = null;
    }
  }

  return $res;
}

echo("Решение квадратного уравнения ax^2 + bx + c = 0\n");
echo("Введите коэффициент a (отличный от нуля):\n");
$a = get_nonzero_f();
echo("Введите коэффициент b:\n");
$b = get_f();
echo("Введите коэффициент c:\n");
$c = get_f();
$d = ($b * $b - 4 * $a * $c);
echo("Дискриминант D = $d\n");

if ($d > 0) {
  echo("D > 0, квадратное уравнение имеет два корня:\n");
  $sqds = array(-$d ** 0.5, $d ** 0.5);
  array_walk($sqds, function($sqd, $i) use ($a, $b) {
    $x = ($sqd - $b) / (2 * $a);
    echo("x" . ($i + 1) . " = " . $x . "\n");
  });
} else if ($d == 0) {
  echo("D = 0, квадратное уравнение имеет один корень:\n");
  $x = -$b / (2 * $a);
  echo("x = $x");
} else {
  echo("D < 0, квадратное уравнение не имеет действительных корней.\n");
}

?>
