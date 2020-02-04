# Input
# source grid
# function values
# destination grid
# polynomial degree
#
# Output
# new grid
# first and second derivative values
# derivation error

def factorial(n)
  n.zero? ? 1 : (1..n).reduce(:*)
end

def div_diffs(tuples)
  if tuples.count == 1
    tuples[0][1]
  else
    div_diffs(tuples[1..-1]) - div_diffs(tuples[0..-2]) / (tuples[-1][0] - tuples[0][0])
  end
end

def basis_polynomial_numerator(n, xs, range, x)
  raise ArgumentError, "Impossible to calculate d#{n} with Lagrange polynomial" if range.count < n + 1

  if n.zero?
    range.map { |i| x - xs[i] }.reduce(1, :*)
  else
    range.map { |i| basis_polynomial_numerator(n - 1, xs, range - [i], x) }.sum
  end
end

def lagrange_derivative(n, xs, ys, x)
  range = (0..ys.count - 1).to_a

  range.map do |i|
    subrange = range - [i]

    basis_polynomial = basis_polynomial_numerator(n, xs, subrange, x) / subrange.map { |j| xs[i] - xs[j] }.reduce(:*)

    ys[i] * basis_polynomial
  end.sum
end

def lagrange_first_derivative_error(xs, ys, x)
  mnp1 = factorial(xs.count) * div_diffs(xs.zip(ys))
  puts mnp1
  mnp1 / factorial(xs.count) * (xs.map { |x_i| x - x_i }.reduce(:*) * xs.map { |x_i| 1.fdiv(x - x_i) }.sum).abs
end

y = ->(x) { 1 / (Math.sin(x) + Math.cos(x)) }
xs = (0..8).map { |i| -1.0 / 4 * Math::PI + 0.1 * Math::PI * (i + 1) }
ys = xs.map { |x| y[x] }
target_xs = (0..16).map { |i| -1.0 / 4 * Math::PI + 0.05 * Math::PI * (i + 2) }

derivatives =
  target_xs.map do |target_x|
    [
      lagrange_derivative(1, xs, ys, target_x),
      lagrange_first_derivative_error(xs, ys, target_x),
      lagrange_derivative(2, xs, ys, target_x)
    ]
  end

puts 'Lagrange derivatives:'
target_xs.zip(derivatives).each do |x, (d1, ed1, d2, ed2)|
  puts ". x = #{x}"
  puts "  d1 = #{d1}"
  puts "  e(d1) = #{ed1}"
  puts "  d2 = #{d2}"
  puts "  e(d2) = #{ed2}"
end
