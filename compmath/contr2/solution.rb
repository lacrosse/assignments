require "bigdecimal"

def function(x)
  4 * x ** 4 - 6.2 - Math.cos(0.6 * x)
end

def derivative_1(x)
  16 * x ** 3 + 0.6 * Math.sin(0.6 * x)
end

def derivative_2(x)
  48 * x ** 2 + 0.36 * Math.cos(0.6 * x)
end

def newton_x(x)
  x - function(x) / derivative_1(x)
end

def big_m2(*xs)
  xs.map { |x| derivative_2(x).abs }.max
end

def m1(*xs)
  xs.map { |x| derivative_1(x).abs }.min
end

def find_newton_root(a, b, x_eps, f_eps)
  x_0 = x = if (function(a) * derivative_2(a)).positive?
      a
    else
      b
    end

  n_x = 0

  begin
    prev_x, x = x, newton_x(x)
    x_diff = (x - prev_x).abs
    f_x = function(x)
    n_x += 1
  end until x_diff < x_eps && f_x.abs < f_eps

  n_f = 1 + n_x * 2

  conv_rate = big_m2(a, x, b) / (2 * m1(a, x, b))
  error = conv_rate.truncate(20) ** (2 ** n_x - 1) * (x - x_0).abs ** (2 ** n_x)

  { x: x, f_x: f_x, n_x: n_x, n_f: n_f, conv_rate: conv_rate, error: error }
end

def find_roots(range, grid_step, x_eps, f_eps)
  t0 = Time.now

  roots =
    range
      .step(grid_step)
      .map { |x| [x, function(x)] }
      .each_cons(2)
      .select { |(_, v1), (_, v2)| (v1 * v2).negative? }
      .map { |(x1, _), (x2, _)| find_newton_root(x1, x2, x_eps, f_eps) }

  t1 = Time.now

  {
    roots: roots,
    time: t1 - t0,
  }
end

def pluralize(w, n) w + (n == 1 ? "" : ?s) end
def inspect_bigdecimal(f) f.round(30).to_s(?F) end

def get_big_decimal(desc)
  $> << "Set the #{desc} (*required, decimal): "
  BigDecimal(gets).tap { |val| puts "#{desc.capitalize} set to #{val}" }
end

puts "Finding roots of f(x) = 4x^4 - 6.2 - cos0.6x with Newton's method"
puts
lower = get_big_decimal("lower bound")
upper = get_big_decimal("upper bound")
x_eps = get_big_decimal("argument precision")
f_eps = get_big_decimal("value precision")
puts

grid_step = [(upper - lower) / 1000, BigDecimal("1e-1")].min

res = find_roots(lower..upper, grid_step, x_eps, f_eps)

puts "#{res[:roots].count} #{pluralize("root", res[:roots].count)} found between [#{lower}; #{upper}] with grid step #{grid_step} in #{(res[:time] * 1000).round(3)} ms"

res[:roots].each.with_index do |root, j|
  i = j + 1
  puts
  puts "ξ_#{i} = #{inspect_bigdecimal(root[:x])}, error = #{inspect_bigdecimal(root[:error])}"
  puts "f(ξ_#{i}) = #{inspect_bigdecimal(root[:f_x])}"
  puts "#{root[:n_x]} #{pluralize("iteration", root[:n_x])}, #{root[:n_f]} #{pluralize("f(x) computation", root[:n_f])}, convergence rate = #{inspect_bigdecimal(root[:conv_rate])}"
end
