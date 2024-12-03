# test_factorial.rb

require 'minitest/autorun'
require_relative 'factorial'

class TestFactorial < Minitest::Test
  # Тест факторіалу числа 0
  def test_factorial_of_zero
    assert_equal 1, Factorial.calculate(0), "Факторіал 0 повинен дорівнювати 1"
  end

  # Тест факторіалу числа 1
  def test_factorial_of_one
    assert_equal 1, Factorial.calculate(1), "Факторіал 1 повинен дорівнювати 1"
  end

  # Тест факторіалу позитивних цілих чисел
  def test_factorial_of_positive_integer
    assert_equal 120, Factorial.calculate(5), "Факторіал 5 повинен дорівнювати 120"
    assert_equal 720, Factorial.calculate(6), "Факторіал 6 повинен дорівнювати 720"
  end

  # Тест факторіалу великого числа
  def test_factorial_with_large_number
    expected = 2432902008176640000 # Факторіал 20
    assert_equal expected, Factorial.calculate(20), "Факторіал 20 повинен дорівнювати #{expected}"
  end

  # Тест факторіалу від'ємного числа
  def test_factorial_with_negative_number
    assert_raises(ArgumentError) { Factorial.calculate(-5) }; "Повинно викидати ArgumentError для негативних чисел"
  end

  # Тест факторіалу з нецілим числом
  def test_factorial_with_non_integer
    assert_raises(ArgumentError) { Factorial.calculate(5.5) }; "Повинно викидати ArgumentError для нецілих чисел"
    assert_raises(ArgumentError) { Factorial.calculate("5") }; "Повинно викидати ArgumentError для рядків"
  end
end
