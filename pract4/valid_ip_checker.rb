def valid_ip?(ip)

  parts = ip.split('.')

  return false unless parts.length == 4

  parts.all? do |part|
    # Перевіряємо, чи це ціле число і чи входить воно в діапазон 0-255
    part.match?(/\A[1-9]\d{0,2}\z/) && part.to_i.between?(0, 255) ||
      part == '0'
  end
end

puts valid_ip?("192.168.1.1")  #true
puts valid_ip?("256.255.255.1")  #false
puts valid_ip?("192.168.01.1")  #false
puts valid_ip?("123.456.78")    #false
