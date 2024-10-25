def say_hello
  puts "Перед блоком"
  yield if block_given?  # Викликає блок, якщо він переданий
  puts "Після блоку"
end

say_hello { puts "Це блок!" }
