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

    range.map do |i|
      subrange = range - [i]
      numerator =
        factorial(n) *
        subrange
          .map { |j| x - @xs[j] }
          .combination(subrange.count - n)
          .map { |c| c.reduce(:*) }
          .sum
      denominator =
        subrange
          .map { |j| @xs[i] - @xs[j] }
          .reduce(:*)

      @ys[i] * numerator / denominator
    end.sum
  end

  def derivative_error(n, x)
    sum_of_prods =
      factorial(n) *
      @xs
        .map { |x_i| x - x_i }
        .combination(@xs.count - n)
        .map { |c| c.reduce(:*) }
        .sum

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
  puts ". x = #{x.to_f}"
  puts "  dy/dx = #{d1.to_f} (error = #{ed1.to_f})"
  puts "  d2y/dx2 = #{d2.to_f} (error = #{ed2.to_f})"
end
