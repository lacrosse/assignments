require "bigdecimal/math"

def get_big_decimal(desc)
  $> << "Set the #{desc} (*required, decimal): "
  BigDecimal(gets).tap { |val| puts "#{desc.capitalize} set to #{val}" }
end

puts "Numerical integration with midpoint rule:"

f = ->(x) { (1 + x ** 3).sqrt(20) }
d2f = ->(x) { 3 * x * (x.power(3, 20) + 4) / (4 * (1 + x.power(3, 20)).power(3 / 2r, 20)) }
a = BigDecimal(0)
b = BigDecimal(2)
error = get_big_decimal("error")

m2 = [d2f[a], d2f[b]].max
n = (m2 * (b - a).power(3, 20) / (24 * error)).sqrt(20).ceil
h = (b - a) / n
integral = n.times.map { |i| f[a + h * (i + 1 / 2r)] }.sum * h
res_error = (b - a) / 24 * h ** 2 * m2

puts "integral = #{"%g" % integral}"
puts "n = #{n}"
puts "error = #{"%e" % res_error}"
