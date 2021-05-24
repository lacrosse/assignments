require "bigdecimal/math"

PI = BigMath.PI(100)

class LagrangePolynomial
  def initialize(xys, order)
    @xys = xys
    @order = order
  end

  def index_window(x)
    start_index = @xys[0, @xys.size - @order].rindex { |xy| xy[0] <= x }
    start_index..start_index + @order
  end

  def derivative_with_error(n, x)
    range = index_window(x)

    window = @xys[range]

    value = range.sum do |i|
      subrange = range.to_a - [i]
      numerator =
        factorial(n) *
        subrange
          .map { |j| x - @xys[j][0] }
          .combination(subrange.count - n)
          .sum { |c| c.reduce(:*) }
      denominator =
        subrange
          .reduce(1) { |p, j| p * (@xys[i][0] - @xys[j][0]) }

      @xys[i][1] * numerator / denominator
    end

    sum_of_prods =
      factorial(n) *
      window
        .map { |x_i, _| x - x_i }
        .combination(window.count - n)
        .sum { |c| c.reduce(:*) }

    error = div_diffs(range.begin, range.end) * sum_of_prods.abs

    [value, error]
  end

  private

  def factorial(n)
    n <= 1 ? 1 : (1..n).reduce(:*)
  end

  def div_diffs(from, to)
    if from == to
      @xys[from][1]
    else
      div_diffs(from + 1, to) - div_diffs(from, to - 1) / (@xys[to][0] - @xys[from][0])
    end
  end
end

def get_int(desc, min:, max:)
  $> << "Set the #{desc} (*required, integer): "
  Integer(gets).tap do |val|
    raise "#{desc.capitalize} can't be greater than #{max}" if val > max
    raise "#{desc.capitalize} can't be less than #{min}" if val < min
    puts "#{desc.capitalize} set to #{val}"
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
xys = xs.map { |x| [x, y[x]] }
order = get_int("polynomial order", min: 1, max: xys.count - 1)
polynomial = LagrangePolynomial.new(xys, order)

result =
  (0..16)
    .map { |j| PI * (-1r / 4 + BigDecimal("0.05") * (j + 2)) }
    .map do |target_x|
    [
      target_x,
      polynomial.derivative_with_error(1, target_x),
      polynomial.derivative_with_error(2, target_x),
    ]
  end

puts "Lagrange derivatives:"
result.each do |x, (d1, ed1), (d2, ed2)|
  puts ". x = #{inspect_number(x)}"
  puts "  dy/dx = #{inspect_number(d1)}  (error = #{inspect_error(ed1)})"
  puts "  d2y/dx2 = #{inspect_number(d2)}  (error = #{inspect_error(ed2)})"
end
