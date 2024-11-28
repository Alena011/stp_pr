# Спільна черга для обміну даними між потоками
queue = Queue.new

# Потік для генерації чисел
producer = Thread.new do
  loop do
    number = rand(1..100) # Генеруємо випадкове число від 1 до 100
    queue.push(number)    # Додаємо число до черги
    sleep(0.5)            # Затримка для симуляції роботи
  end
end

# Потік для виводу тільки непарних чисел
consumer = Thread.new do
  loop do
    if !queue.empty?
      number = queue.pop   # Забираємо число з черги
      puts "Непарне число: #{number}" if number.odd? # Виводимо, якщо число непарне
    else
      sleep(0.1)           # Якщо черга порожня, чекаємо
    end
  end
end

# Основна програма
puts "Програма запущена. Генерація та фільтрація чисел..."

# Зупинка програми вручну через Ctrl+C
producer.join
consumer.join
