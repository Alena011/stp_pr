# Торт с родзинками
cake = [
  ".o......",
  "......o.",
  "....o...",
  "..o....."
]

#поиск родзинок
def find_raisins(cake)
  raisins = []
  cake.each_with_index do |row, i|
    row.chars.each_with_index do |cell, j|
      if cell == 'o'
        raisins << [i, j]
      end
    end
  end
  raisins
end

#есть ли ровно одна родзинка в данном прямоугольнике
def count_raisins_in_rectangle(cake, x1, y1, x2, y2)
  count = 0
  (x1..x2).each do |i|
    (y1..y2).each do |j|
      count += 1 if cake[i][j] == 'o'
    end
  end
  count == 1
end

#все возможных горизонтальных разрезов торта
def horizontal_cuts(cake, raisins)
  rectangles = []
  start_row = 0
  raisins.each do |(x, y)|
    end_row = x
    rectangles << cake[start_row..end_row]
    start_row = end_row + 1
  end
  rectangles
end

#генерация всех возможных вертикальных разрезов торта
def vertical_cuts(cake, raisins)
  columns = cake[0].length
  pieces = Array.new(columns) { [] }

  (0...cake.length).each do |row|
    (0...columns).each do |col|
      pieces[col] << cake[row][col]
    end
  end

  rectangles = []
  start_col = 0
  raisins.each do |(x, y)|
    end_col = y
    rectangles << pieces[start_col..end_col].map(&:join)
    start_col = end_col + 1
  end

  rectangles
end

#пробуем комбинации горизонтальных и вертикальных разрезов
def mixed_cuts(cake, raisins)
  #для упрощения используем только горизонтальные и вертикальные для примера
  [horizontal_cuts(cake, raisins), vertical_cuts(cake, raisins)]
end

def cut_cake(cake)
  raisins = find_raisins(cake)

  #получаем все возможные варианты разрезания
  horizontal_solution = horizontal_cuts(cake, raisins)
  vertical_solution = vertical_cuts(cake, raisins)
  mixed_solutions = mixed_cuts(cake, raisins)

  #собираем все решения
  solutions = [horizontal_solution, vertical_solution] + mixed_solutions

  #возвращаем все возможные решения
  solutions
end

#выбор решения с наибольшей шириной первого куска
def find_best_solution(solutions)
  best_solution = nil
  max_width = 0

  solutions.each do |solution|
    first_piece = solution[0]
    width = first_piece[0].length  #ширина первого куска

    if width > max_width
      max_width = width
      best_solution = solution
    end
  end

  best_solution
end

rectangles = cut_cake(cake)
best_solution = find_best_solution(rectangles)

puts "Лучшее решение:"
best_solution.each_with_index do |rect, index|
  puts "Кусок #{index + 1}:"
  rect.each { |line| puts line }
  puts "---"
end
