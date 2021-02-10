def cholesky_decompose(matrix)
  b = Array.new(3) { Array.new(3, 0) }
  c = Array.new(3) { Array.new(3, 0) }

  n = matrix.size

  n.times do |line|
    (line...n).each do |i|
      b[i][line] = matrix[i][line] - (0..line - 1).sum { |k| b[i][k] * c[k][line] }
    end
    (line...n).each do |j|
      c[line][j] = (matrix[line][j] - (0..line - 1).sum { |k| b[line][k] * c[k][j] }) / b[line][line]
    end
  end

  [b, c]
end

def cholesky_solve(b, c, d)
  n = b.size

  y = []
  x = []

  n.times { |i| y[i] = (d[i] - (0..i - 1).map { |k| b[i][k] * y[k] }.sum) / b[i][i] }
  n.times do |j|
    i = n - 1 - j
    x[i] = y[i] - (i + 1...n).map { |k| c[i][k] * x[k] }.sum
  end

  x
end

def true_error(a, d, x_tilde)
  d_tilde = a.map { |a_row| a_row.zip(x_tilde).sum { |a, x| a * x } }
  d.zip(d_tilde).map { |d, dt| d - dt }
end

def cholesky_determinant(matrix)
  matrix.zip(0..).reduce(1) { |prod, (row, i)| prod * row[i] }
end

def eye(n)
  Array.new(n) { |i| Array.new(n) { |j| i == j ? 1 : 0 } }
end

def cholesky_inverse(b, c)
  eye(b.count)
    .transpose
    .map { |e_col| cholesky_solve(b, c, e_col) }
    .transpose
end

def inverse_true_error(a, a_inv)
  n = a.size
  a_inv_t = a_inv.transpose
  eye = eye(n)
  Array.new(n) do |i|
    Array.new(a[0].size) do |j|
      eye[j][i] - a[i].zip(a_inv_t[j]).sum { |a, a_i| a * a_i }
    end
  end
end

def inspect_number(n)
  "%g" % n
end

def inspect_matrix(m)
  m.map { |row| Array(row).map(&method(:inspect_number)).join("\t") }
end

a = [
  [3.6r, 1.8r, -4.7r],
  [2.7r, -3.6r, 1.9r],
  [1.5r, 4.5r, 3.3r],
]

d = [3.8r, 0.4r, -1.6r]

b, c = cholesky_decompose(a)
x = cholesky_solve(b, c, d)
true_error = true_error(a, d, x)
inverse = cholesky_inverse(b, c)
inverse_true_error = inverse_true_error(a, inverse)

puts "B:"
puts inspect_matrix(b)
puts
puts "C:"
puts inspect_matrix(c)
puts
puts "solution:"
puts inspect_matrix(x)
puts
puts "true error:"
puts inspect_matrix(true_error)
puts
puts "det:"
puts inspect_number(cholesky_determinant(b))
puts
puts "inverse:"
puts inspect_matrix(inverse)
puts
puts "inverse true error:"
puts inspect_matrix(inverse_true_error)
