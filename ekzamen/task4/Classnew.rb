# Створення класу динамічно
MyDynamicClass = Class.new do
  def greet
    puts "Привіт з динамічного класу!"
  end
end

obj = MyDynamicClass.new
obj.greet  # Виведе "Привіт з динамічного класу!"


class_name = "DynamicUser"
DynamicUser = Class.new do
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def display
    puts "Ім'я користувача: #{@name}"
  end
end

user = DynamicUser.new("Олексій")
user.display  # Виведе "Ім'я користувача: Олексій"


DynamicClass = Class.new
DynamicClass.define_method(:say_hello) do
  puts "Hello from dynamically defined method!"
end

obj = DynamicClass.new
obj.say_hello  # Виведе "Hello from dynamically defined method!"
