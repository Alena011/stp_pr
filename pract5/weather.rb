# frozen_string_literal: true

require 'httparty'
require 'csv'

API_KEY = 'fddbf07bc859d039647854aefd1efa6d'
BASE_URL = 'https://api.openweathermap.org/data/2.5/weather'

# Функція для отримання погоди
def fetch_weather(city)
  response = HTTParty.get(BASE_URL, query: { q: city, appid: API_KEY, units: 'metric' })

  if response.success?
    weather_data = response.parsed_response
    {
      city: city,
      temperature: weather_data['main']['temp'],
      humidity: weather_data['main']['humidity'],
      wind_speed: weather_data['wind']['speed']
    }
  else
    puts "Не вдалося отримати дані для міста #{city}"
    nil
  end
end

# Функція для збереження даних у CSV
def save_to_csv(data, filename = 'weather_data.csv')
  CSV.open(filename, 'w', headers: true) do |csv|
    csv << ['Місто', 'Температура (°C)', 'Вологість (%)', 'Швидкість вітру (м/с)']
    data.each { |row| csv << row.values }
  end
end

cities = ['Kyiv', 'Lviv', 'Kharkiv']
weather_data = cities.map { |city| fetch_weather(city) }.compact

save_to_csv(weather_data)
puts "Дані успішно збережені у файл weather_data.csv."
