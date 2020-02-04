def select_sort(a)
  a.count.times do |i|
    puts a.inspect

    k = i;

    (i + 1...a.count).each do |j|
      k = j if a[j] < a[k]
    end

    a[k], a[i] = a[i], a[k];
  end
end

array = [7, 5, 9, 4, 6]
select_sort(array)
