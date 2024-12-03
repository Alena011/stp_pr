# factorial.rb

class Factorial
  # Метод для обчислення факторіалу числа
  def self.calculate(n)
    # Перевірка на коректність вхідного параметру
    raise ArgumentError, "Число повинно бути цілим і невід'ємним" unless valid_number?(n)

    # Рекурсивний алгоритм обчислення факторіалу
    return 1 if n == 0 || n == 1
    n * calculate(n - 1)
  end

  private

  # Метод для перевірки, чи число є цілим та невід'ємним
  def self.valid_number?(n)
    n.is_a?(Integer) && n >= 0
  end
end

# Виклик методу та вивід результату
if __FILE__ == $0
  begin
    print "Введіть число для обчислення факторіалу: "
    input = gets.chomp
    number = Integer(input)
    result = Factorial.calculate(number)
    puts "Факторіал числа #{number} дорівнює #{result}"
  rescue ArgumentError => e
    puts "Помилка: #{e.message}"
  rescue => e
    puts "Сталася невідома помилка: #{e.message}"
  end
end
