require "bigdecimal/math"

negative_half = [
  [BigDecimal("-0.932469515"), BigDecimal("0.17132450")],
  [BigDecimal("-0.66120939"), BigDecimal("0.36076158")],
  [BigDecimal("-0.23861919"), BigDecimal("0.46791394")],
]

QUADRATURE_6 = negative_half + negative_half.reverse.map { |t, w| [-t, w] }

def partitioned_gauss_integral(f, a, b, j)
  sum = QUADRATURE_6.map do |t, w|
    w * (0..j).map do |i|
      root = (b + a * (2 * j + 1)) / (2 * (j + 1)) + (b - a) / (2 * (j + 1)) * t
      f[root + (b - a) / (j + 1) * i]
    end.sum
  end.sum

  (b - a) / (2 * (j + 1)) * sum
end

def gauss_integral(f, a, b, delta)
  j, s, actual_delta =
    (0..Float::INFINITY)
      .lazy
      .map { |j| [j, partitioned_gauss_integral(f, a, b, j)] }
      .each_cons(2)
      .map { |(j, s_j), (_, s_jp1)| [j, s_jp1, ((s_jp1 - s_j) / s_jp1).abs] }
      .find { |_, _, diff| diff <= delta }

  { integral: s, delta: actual_delta }
end

f = ->(x) { (1 + x ** 3).sqrt(20) }
a = BigDecimal(0)
b = BigDecimal(2)
error = BigDecimal("1e-10")

result = gauss_integral(f, a, b, error)

puts "Definite integral approximation with Gauss-Legendre quadrature"
puts "integral = #{"%.15f" % result[:integral]}"
puts "error = #{"%.15f" % result[:delta]}"
