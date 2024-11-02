# frozen_string_literal: true

class Tokens
  def initialize(expression)
    @tokens = expression.scan(/-?\d+\.?\d*|\+|\-|\*|\/|\(|\)/) #учитываем числа с плавающей точкой и операторы
    @stack = [] # массив для хранения операторов
    @output = [] # массив для хранения результата в RPN
  end

  def precedence(operator)
    case operator
    when '+', '-'
      1
    when '*', '/'
      2
    else
      0 # все остальные нулевой приоритет
    end
  end

  def analysis
    @tokens.each_with_index do |token, index| # проходим по каждому элементу выражения
      if number?(token)
        @output << token
      elsif token == '(' # если это открывающая скобка
        @stack.push(token)
      elsif token == ')' # если это закрывающая скобка
        while @stack.last != '('
          @output << @stack.pop
        end
        @stack.pop
      elsif '+-*/'.include?(token)
        # Проверка на деление на 0
        if token == '/' && @tokens[index + 1] == '0'
          raise ZeroDivisionError, 'вообще то на 0 не делим:)'
        end

        # Обрабатываем операторы по приоритету
        until @stack.empty? || precedence(@stack.last) < precedence(token)
          @output << @stack.pop
        end
        @stack.push(token)
      end
    end

    # перемещаем оставшиеся операторы из стека в результат
    while !@stack.empty?
      @output << @stack.pop
    end

    @output.join(' ')
  end

  private

  # Метод для проверки
  def number?(token)
    token =~ /\A-?\d+\.?\d*\z/ # проверяет на целые и числа с плавающей точкой
  end
end

begin
  expression = "4-5+(-4+5)" # ваше выражение
  tokens = Tokens.new(expression)
  puts tokens.analysis
rescue ZeroDivisionError => e
  puts e.message
end
