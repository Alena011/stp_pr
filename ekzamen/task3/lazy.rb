# Створюємо великий масив
numbers = (1..Float::INFINITY).lazy

# Застосовуємо фільтрацію та трансформацію
result = numbers
           .select { |n| n.even? }
           .map { |n| n * 2 }
           .first(10)

puts result  # Виведе перші 10 парних чисел, подвоєних: [4, 8, 12, 16, 20, 24, 28, 32, 36, 40]
