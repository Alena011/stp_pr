begin
  # Код, який може спричинити помилку
  num = 10 / 0
rescue ZeroDivisionError
  puts "Помилка: ділення на нуль!"
ensure
  puts "Цей код виконається у будь-якому разі"
end
