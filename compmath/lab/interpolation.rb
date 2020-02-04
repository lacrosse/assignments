# y = 1 / (sinx + cosx)
# x_i = -1/4 * pi + 0.1pi * (i + 1); i = 0..8
# x_j = -1/4 * pi + 0.05pi * (j + 2); j = 0..16

# Input:
# interpolation grid
# function values
# output grid
# polynomial degree
#
# Output:
# grid
# values
# error

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

def lagrange_polynomial_with_error(xs, ys, x)
  n = ys.count - 1
  value =
    (0..n).map do |i|
      basis_polynomial = ((0..n).to_a - [i]).map { |j| (x - xs[j]) / (xs[i] - xs[j]) }.reduce(:*)

      ys[i] * basis_polynomial
    end.sum

  mnp1 = factorial(n + 1) * div_diffs(xs.zip(ys))
  error = (mnp1 / factorial(n + 1) * (0..n).map { |i| x - xs[i] }.reduce(:*)).abs

  [value, error]
end

y = ->(x) { 1 / (Math.sin(x) + Math.cos(x)) }
xs = (0..8).map { |i| -1.0 / 4 * Math::PI + 0.1 * Math::PI * (i + 1) }
ys = xs.map { |x| y[x] }
target_xs = (0..16).map { |i| -1.0 / 4 * Math::PI + 0.05 * Math::PI * (i + 2) }
target_ys_with_errors = target_xs.map { |target_x| lagrange_polynomial_with_error(xs, ys, target_x) }

puts 'Lagrange interpolation'
target_xs.zip(target_ys_with_errors).each do |x, (val, e)|
  puts ". x = #{x}"
  puts "  y = #{val}"
  puts "  error = #{e}"
end
