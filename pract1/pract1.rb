# frozen_string_literal: true

class Pract1
  loop do
  player_score = 0
  opponent_score = 0
  rounds = 3

  rounds.times do |round|
    puts "Раунд #{round + 1} из 3"
  puts "Выберите один из вариантов: камень, ножницы или бумага"
  user_choice = gets.chomp.capitalize
  puts "Ваш ответ принят"
  puts "Очередь оппонента......"

  words = ["Камень", "Ножницы", "Бумага"]
  sleep(1)
  random_word = words.sample
  puts "Оппонент выбрал: #{random_word}"

  if user_choice == random_word
    puts "Ничья!"
  elsif (user_choice == "Камень" && random_word == "Ножницы") ||
    (user_choice == "Ножницы" && random_word == "Бумага") ||
    (user_choice == "Бумага" && random_word == "Камень")
    puts "Вы выиграли раунд!"
    player_score += 1
  else
    puts "Вы проиграли раунд!"
    opponent_score += 1
  end
    puts "Счет: Вы - #{player_score}, Оппонент - #{opponent_score}"
    puts "-----------------------------------"

    # проверка если кто то выиграл два раунда
    if player_score == 2 || opponent_score == 2
      break
    end
  end

  # общий победитель
  if player_score > opponent_score
    puts "Вы выиграли игру с итоговым счетом: #{player_score} - #{opponent_score}!"
  elsif player_score < opponent_score
    puts "Оппонент выиграл игру с итоговым счетом: #{opponent_score} - #{player_score}."
  else
    puts "Игра закончилась ничьей!"
  end
  puts "Нажмите Enter, чтобы сыграть снова, или введите любой другой символ для выхода."
  input = gets.chomp
  break unless input.empty?
  end
  end