def get_int(desc, min:, max:)
  $> << "Set the #{desc} (*required, integer): "
  Integer(gets).tap do |val|
    raise "#{desc.capitalize} can't be greater than #{max}" if val > max
    raise "#{desc.capitalize} can't be less than #{min}" if val < min
    puts "#{desc.capitalize} set to #{val}"
  end
end

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

def lagrange_polynomial_with_error(xys, order, x)
  windowed_xys = xys[0..order]
  value =
    windowed_xys.zip(0..).sum do |(grid_x, grid_y), i|
      other_xys = windowed_xys[0, i] + windowed_xys[i + 1..order]

      bp_num = other_xys.map { |xy| x - xy[0] }.reduce(:*)
      bp_den = other_xys.map { |xy| grid_x - xy[0] }.reduce(:*)
      basis_polynomial = bp_num / bp_den

      grid_y * basis_polynomial
    end

  dds = div_diffs(windowed_xys)
  mnp1 = dds * factorial(order + 1)
  diff_prod = windowed_xys.map { |xy| x - xy[0] }.reduce(:*)
  error = (dds * diff_prod).abs

  [value, error]
end

y = ->(x) { 1 / (Math.sin(x) + Math.cos(x)) }
xs = (0..8).map { |i| -1 / 4r * Math::PI + 1 / 10r * Math::PI * (i + 1) }
xys = xs.map { |x| [x, y[x]] }
order = get_int("polynomial order", min: 1, max: xys.count - 1)

target_xs = (0..16).map { |i| -1 / 4r * Math::PI + 5 / 100r * Math::PI * (i + 2) }
target_ys_with_errors = target_xs.map { |target_x| [target_x, lagrange_polynomial_with_error(xys, order, target_x)] }

puts "Lagrange interpolation"
target_ys_with_errors.each do |x, (y, e)|
  puts ". x = %g" % x
  puts "  y = %g" % y
  puts "  error = %E" % e
end
