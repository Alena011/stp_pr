module StringRefinement
  refine String do
    def shout
      self.upcase + "!!!"
    end
  end
end

using StringRefinement

puts "hello".shout  # Виведе "HELLO!!!"


def example
  using StringRefinement
  puts "world".shout  # Виведе "WORLD!!!"
end

example
puts "world".shout  # Помилка: undefined method `shout` for "world":String