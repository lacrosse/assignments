f = ->(x) { Math.sqrt(1 + x**3) }
a = 0
b = 2r
n = 6
h = (b - a) / n
integral = n.times.map { |i| f[a + h * (i + 1/2r)] * h }.sum

d2f = ->(x) { 3 * x * (x**3 + 4) / (4 * (1 + x**3)**(3/2r)) }
m2 = [d2f[a], d2f[b]].max
error = (b - a) / 24 * h**2 * m2

puts 'Numerical integration with midpoint rule:'
puts "integral value = #{integral}"
puts "error = #{error}"
