# frozen_string_literal: true

class Tokens
  def initialize(expression)
    @tokens = expression.split # разбиваем выражение на число и операторов
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
      0 #все остальные нулевой приоритет
    end
  end

  def analysis
    @tokens.each do |token| #проходим по каждому элементу выражения
      if token =~ /\d+/  #если это число
        @output << token  #добавляем его в результат
      elsif '+-*/'.include?(token)
        until @stack.empty? || precedence(@stack.last) < precedence(token)
          @output << @stack.pop
        end
        @stack.push(token)
      end
    end

    #перемещаем операторов из стека в аутпут
    while !@stack.empty?
      @output << @stack.pop
    end

    @output.join(' ')  #результат в строку
  end
end

expression = "2 + 1 * 4"
tokens = Tokens.new(expression) #анализ выражения
puts tokens.analysis
