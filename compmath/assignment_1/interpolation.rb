def factorial(n)
  n == 0 ? 1 : (1..n).reduce(:*)
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
    (0..n).sum do |i|
      basis_polynomial = ((0..n).to_a - [i]).map { |j| (x - xs[j]) / (xs[i] - xs[j]) }.reduce(:*)

      ys[i] * basis_polynomial
    end

  dds = div_diffs(xs.zip(ys))
  mnp1 = dds * factorial(n + 1)
  error = (dds * (0..n).reduce(1) { |prod, i| prod * (x - xs[i]) }).abs

  [value, error]
end

y = ->(x) { 1 / (Math.sin(x) + Math.cos(x)) }
xs = (0..8).map { |i| -1 / 4r * Math::PI + 1 / 10r * Math::PI * (i + 1) }
ys = xs.map { |x| y[x] }
target_xs = (0..16).map { |i| -1 / 4r * Math::PI + 5 / 100r * Math::PI * (i + 2) }
target_ys_with_errors = target_xs.map { |target_x| [target_x, lagrange_polynomial_with_error(xs, ys, target_x)] }

puts "Lagrange interpolation"
target_ys_with_errors.each do |x, (y, e)|
  puts ". x = %g" % x
  puts "  y = %g" % y
  puts "  error = %E" % e
end
