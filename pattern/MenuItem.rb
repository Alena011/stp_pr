#Базовий компонент для елементів меню
class MenuItem
  def add(item)
    raise NotImplementedError, 'Цей метод має бути реалізований у підкласі'
  end

  def remove(item)
    raise NotImplementedError, 'Цей метод має бути реалізований у підкласі'
  end

  def display(indent = 0)
    raise NotImplementedError, 'Цей метод має бути реалізований у підкласі'
  end
end

#Клас Dish (листок) — це окреме блюдо, яке не має підкатегорій
class Dish < MenuItem
  def initialize(name, price)
    @name = name
    @price = price
  end

  def display(indent = 0)
    puts "#{' ' * indent}Dish: #{@name}, Price: $#{@price}"
  end
end

# Клас MenuCategory (композит) — це категорія меню, яка може містити інші категорії або блюда
class MenuCategory < MenuItem
  def initialize(name)
    @name = name
    @items = []
  end

  def add(item)
    @items << item
  end

  def remove(item)
    @items.delete(item)
  end

  def display(indent = 0)
    puts "#{' ' * indent}Category: #{@name}"
    @items.each { |item| item.display(indent + 2) }
  end
end

#Використання патерна Composite для побудови ресторанного меню
main_menu = MenuCategory.new('Main Menu') # Головне меню
drinks = MenuCategory.new('Drinks') # Категорія напоїв
food = MenuCategory.new('Food') # Категорія їжі
desserts = MenuCategory.new('Desserts') # Категорія десертів

#Створення страв
coffee = Dish.new('Coffee', 3.0)
tea = Dish.new('Tea', 2.5)
burger = Dish.new('Burger', 8.0)
salad = Dish.new('Salad', 5.5)
ice_cream = Dish.new('Ice Cream', 4.0)
cake = Dish.new('Cake', 6.0)

#Додавання страв до відповідних категорій
drinks.add(coffee)
drinks.add(tea)
food.add(burger)
food.add(salad)
desserts.add(ice_cream)
desserts.add(cake)

#Додавання категорій до головного меню
main_menu.add(drinks)
main_menu.add(food)
main_menu.add(desserts)

#Виведення всього меню
main_menu.display
