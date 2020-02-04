def cholesky_decompose(matrix)
  b = Array.new(3) { Array.new(3, 0) }
  c = Array.new(3) { Array.new(3, 0) }

  n = matrix.count

  n.times do |line|
    (line...n).each do |i|
      b[i][line] = matrix[i][line] - (0..line - 1).map { |k| b[i][k] * c[k][line] }.sum
    end
    (line...n).each do |j|
      c[line][j] = (matrix[line][j] - (0..line - 1).map { |k| b[line][k] * c[k][j] }.sum) / b[line][line]
    end
  end

  [b, c]
end

def cholesky_solve(b, c, d)
  n = b.count

  y = []
  x = []

  n.times { |i| y[i] = (d[i] - (0..i - 1).map { |k| b[i][k] * y[k] }.sum) / b[i][i] }
  (n - 1).downto(0).each { |i| x[i] = y[i] - (i + 1...n).map { |k| c[i][k] * x[k] }.sum }

  x
end

def cholesky_determinant(matrix)
  matrix.count.times.map { |i| matrix[i][i] }.reduce(:*)
end

def identity_matrix(n)
  Array.new(n) { |i| Array.new(n) { |j| i == j ? 1 : 0 } }
end

def cholesky_inverse(b, c)
  identity_matrix(b.count)
    .transpose
    .map { |e_col| cholesky_solve(b, c, e_col) }
    .transpose
end

def inspect_matrix(m)
  m.map { |row| row.map(&:to_f).join("\t") }
end

a = [
  [3.6r, 1.8r, -4.7r],
  [2.7r, -3.6r, 1.9r],
  [1.5r, 4.5r, 3.3r]
]

b, c = cholesky_decompose(a)

puts 'B:'
puts inspect_matrix(b)
puts
puts 'C:'
puts inspect_matrix(c)
puts
puts 'solution:'
puts cholesky_solve(b, c, [3.8r, 0.4r, -1.6r]).map(&:to_f)
puts
puts 'det:'
puts cholesky_determinant(b).to_f
puts
puts 'inverse:'
puts inspect_matrix(cholesky_inverse(b, c))
