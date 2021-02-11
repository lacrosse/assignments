require "bigdecimal/math"

PI = BigMath.PI(100)

class LagrangePolynomial
  def initialize(xs, ys)
    @xs = xs
    @ys = ys
  end

  def order
    @ys.count
  end

  def derivative(n, x)
    range = (0...order).to_a

    range.sum do |i|
      subrange = range - [i]
      numerator =
        factorial(n) *
        subrange
          .map { |j| x - @xs[j] }
          .combination(subrange.count - n)
          .sum { |c| c.reduce(:*) }
      denominator =
        subrange
          .reduce(1) { |p, j| p * (@xs[i] - @xs[j]) }

      @ys[i] * numerator / denominator
    end
  end

  def derivative_error(n, x)
    sum_of_prods =
      factorial(n) *
      @xs
        .map { |x_i| x - x_i }
        .combination(@xs.count - n)
        .sum { |c| c.reduce(:*) }

    div_diffs(@xs.zip(@ys)) * sum_of_prods.abs
  end

  private

  def factorial(n)
    n <= 1 ? 1 : (1..n).reduce(:*)
  end

  def div_diffs(tuples)
    if tuples.count == 1
      tuples[0][1]
    else
      div_diffs(tuples[1..-1]) - div_diffs(tuples[0..-2]) / (tuples[-1][0] - tuples[0][0])
    end
  end
end

def inspect_number(n)
  "%g" % n
end

def inspect_error(n)
  "%e" % n
end

y = ->(x) { 1 / (BigMath.sin(x, 100) + BigMath.cos(x, 100)) }
xs = (0..8).map { |i| PI * (-1r / 4 + BigDecimal("0.1") * (i + 1)) }
ys = xs.map { |x| y[x] }
polynomial = LagrangePolynomial.new(xs, ys)

result =
  (0..16)
    .map { |j| PI * (-1r / 4 + BigDecimal("0.05") * (j + 2)) }
    .map do |target_x|
    [
      target_x,
      polynomial.derivative(1, target_x),
      polynomial.derivative_error(1, target_x),
      polynomial.derivative(2, target_x),
      polynomial.derivative_error(2, target_x),
    ]
  end

puts "Lagrange derivatives:"
result.each do |x, d1, ed1, d2, ed2|
  puts ". x = #{inspect_number(x)}"
  puts "  dy/dx = #{inspect_number(d1)}  (error = #{inspect_error(ed1)})"
  puts "  d2y/dx2 = #{inspect_number(d2)}  (error = #{inspect_error(ed2)})"
end
