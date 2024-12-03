def greet
  puts "Перед блоком"
  yield if block_given?
  puts "Після блоку"
end

greet do
  puts "Виконується блок"
end

def perform_twice
  yield
  yield
end

perform_twice do
  puts "Виконується блок"
end

def calculate
  result1 = yield(2, 3)
  result2 = yield(5, 7)
  result1 + result2
end

sum = calculate do |a, b|
  a + b
end

puts sum  # Виведе 17 (2+3 + 5+7)


def maybe_yield
  if block_given?
    yield
  else
    puts "Блок не передано"
  end
end

maybe_yield  # Виведе "Блок не передано"
maybe_yield { puts "Блок присутній" }  # Виведе "Блок присутній"
