require 'bigdecimal'

# f(x) = 4 x^4 - 6.2 - cos(0.6x)
#
# Input:
# * [a, b] range
# * epsilon_1 - argument precision
# * epsilon_2 - value precision
#
# Output:
# * roots, precision
# * values
# * number of iterations
# * number of f(x) computation
# * time of computation
# * convergence rate: alpha = abs(x_(n+1) - x_n) / abs(x_n - x_(n-1))^n,
#   where n - order of convergence

def function(x)
  4 * x**4 - 6.2 - Math.cos(0.6 * x)
end

def derivative_1(x)
  16 * x**3 + 0.6 * Math.sin(0.6 * x)
end

def derivative_2(x)
  48 * x**2 + 0.36 * Math.cos(0.6 * x)
end

def newton_x(prev_x)
  prev_x - function(prev_x) / derivative_1(prev_x)
end

def newton_iteration(prev_x, x_eps, f_eps, n_x, n_f = 0)
  x = newton_x(prev_x)
  f_x = function(x)

  if (x - prev_x).abs < x_eps && f_x.abs < f_eps
    conv_rate = (x - newton_x(x)).abs / (x - prev_x).abs**2
    { x: x, f_x: f_x, n_x: n_x + 1, n_f: n_f + 2, conv_rate: conv_rate }
  else
    newton_iteration(x, x_eps, f_eps, n_x + 1, n_f + 2)
  end
end

def find_newton_root(a, b, x_eps, f_eps)
  x0 =
    if (function(a) * derivative_2(a)).positive?
      a
    else
      b
    end

  newton_iteration(x0, x_eps, f_eps, 0, 1)
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
    time: t1 - t0
  }
end

res = find_roots(BigDecimal(-5)..BigDecimal(5), BigDecimal('0.1'), 10**-5, 10**-5)

puts "t = #{res[:time] * 1000} ms"

res[:roots].each.with_index do |root, index|
  puts
  puts "ξ_#{index + 1} = #{root[:x].round(20)}"
  puts "f(ξ_#{index + 1}) = #{root[:f_x].round(20)}"
  puts "number of iterations = #{root[:n_x]}"
  puts "number of f(x) computations = #{root[:n_f]}"
  puts "α (convergence rate) = #{root[:conv_rate].round(3).to_s('F')}"
end
