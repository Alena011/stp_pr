class BankAccount
  def initialize(balance = 0)
    @balance = balance
  end

  def deposit(amount)
    if amount > 0
      @balance += amount
    else
      puts "Неможливо внести негативну суму"
    end
  end

  def withdraw(amount)
    if amount > @balance
      puts "Недостатньо коштів для зняття #{amount}!"
    elsif amount < 0
      puts "Неможливо зняти негативну суму"
    else
      @balance -= amount
    end
  end

  def balance
    puts "Ваш баланс: #{@balance} грн"
    @balance
  end
end

# Приклад використання
account = BankAccount.new(1000)
account.deposit(500)
account.withdraw(300)
account.balance
