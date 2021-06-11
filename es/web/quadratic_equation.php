<html>
  <head>
    <title>Решение квадратного уравнения</title>
    <style>
      input { width: 5em; margin: 0 2px }
    </style>
  </head>
  <body>
    <?
      if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $a = $_POST['a'];
        $b = $_POST['b'];
        $c = $_POST['c'];

        if ($a == "" || $b == "" || $c == "") {
          echo "<p>Один из коэффициентов пустой. Введите числа во все поля.</p>";
        } else if ($a == 0) {
          echo "<p>Нулевой коэффициент у квадратного члена уравнения. Уравнение линейное.</p>";
          echo "<p>b = " . $b . "</p>";
          echo "<p>c = " . $c . "</p>";
          $x = -$c / $b;
          echo "<p>x = " . $x . "</p>";
        } else {
          $d = $b * $b - 4 * $a * $c;

          echo "<p>b = " . $a . "</p>";
          echo "<p>b = " . $b . "</p>";
          echo "<p>c = " . $c . "</p>";
          echo "<p>Дискриминант D = " . $d . "</p>";

          if ($d > 0) {
            echo "<p>D > 0, квадратное уравнение имеет два корня:</p>";
            $sqds = array(-$d ** 0.5, $d ** 0.5);
            array_walk($sqds, function($sqd, $i) use ($a, $b) {
              $x = ($sqd - $b) / (2 * $a);
              echo "<p>x<sub>" . ($i + 1) . "</sub> = " . $x . "</p>";
            });
          } else if ($d == 0) {
            echo "<p>D = 0, квадратное уравнение имеет один корень:</p>";
            $x = -$b / (2 * $a);
            echo "<p>x = " . $x . "</p>";
          } else {
            echo "<p>D < 0, квадратное уравнение не имеет действительных корней.</p>";
          }
        }
      } else {
    ?>
      <form action="" method="post">
        <p>Решение квадратного уравнения <input type="number" name="a" />x<sup>2</sup> + <input type="number" name="b">x + <input type="number" name="c"> = 0. <input type="submit" value="Найти"></p>
      </form>
    <?
      }
    ?>
  </body>
</html>
