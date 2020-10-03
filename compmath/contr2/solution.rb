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

def find_newton_root(a, b, x_eps, f_eps)
  x = if (function(a) * derivative_2(a)).positive?
      a
    else
      b
    end

  n_x = 0
  n_f = 1

  begin
    prev_x, x = x, newton_x(x)
    f_x = function(x)
    n_x += 1
    n_f += 2
  end until (x - prev_x).abs < x_eps && f_x.abs < f_eps

  conv_rate = derivative_2(x).abs / (2 * derivative_1(x).abs)

  { x: x, f_x: f_x, n_x: n_x, n_f: n_f, conv_rate: conv_rate }
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

def pluralize(w, n)
  w + (n == 1 ? "" : ?s)
end

def get_big_decimal(desc)
  $> << "Fill in the #{desc} (*required, decimal): "
  BigDecimal(gets).tap { |val| puts "#{desc.capitalize}: #{val}" }
end

puts "Finding roots of f(x) = 4x^4 - 6.2 - cos0.6x with Newton's method"
puts
lower = get_big_decimal("lower bound")
upper = get_big_decimal("upper bound")
x_eps = get_big_decimal("argument precision")
f_eps = get_big_decimal("value precision")
puts

res = find_roots(lower..upper, BigDecimal("1e-1"), x_eps, f_eps)

puts "#{res[:roots].count} #{pluralize("root", res[:roots].count)} found between #{lower} and #{upper}"
puts

res[:roots].each.with_index do |root, index|
  puts "ξ_#{index + 1} = #{root[:x].round(20).to_s(?F)}"
  puts "f(ξ_#{index + 1}) = #{root[:f_x].round(20).to_s(?F)}"
  puts "#{root[:n_x]} #{pluralize("iteration", root[:n_x])}, #{root[:n_f]} #{pluralize("f(x) computation", root[:n_f])}"
  puts "convergence rate = #{root[:conv_rate].round(20).to_s(?F)}"
  puts
end

puts "t = #{(res[:time] * 1000).round(3)} ms"
