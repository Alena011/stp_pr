require 'minitest/autorun'
require 'mocha/minitest'
require 'csv'
require_relative '../weather'  # Подключаем Ruby-файл с методами

class WeatherTest < Minitest::Test
  def test_fetch_weather_success
    city = 'Kyiv'
    fake_response = {
      'main' => { 'temp' => 10.0, 'humidity' => 75 },
      'wind' => { 'speed' => 3.5 }
    }
    HTTParty.expects(:get).returns(stub(success?: true, parsed_response: fake_response))

    result = fetch_weather(city)
    assert_equal city, result[:city]
    assert_equal 10.0, result[:temperature]
    assert_equal 75, result[:humidity]
    assert_equal 3.5, result[:wind_speed]
  end

  def test_fetch_weather_failure
    HTTParty.expects(:get).returns(stub(success?: false))

    result = fetch_weather('UnknownCity')
    assert_nil result
  end

  def test_save_to_csv
    data = [{ city: 'Kyiv', temperature: 10.0, humidity: 75, wind_speed: 3.5 }]
    filename = 'test_weather_data.csv'
    save_to_csv(data, filename)

    assert File.exist?(filename)

    csv_content = CSV.read(filename, headers: true)
    assert_equal 'Kyiv', csv_content[0]['Місто']
    assert_equal '10.0', csv_content[0]['Температура (°C)']
    assert_equal '75', csv_content[0]['Вологість (%)']
    assert_equal '3.5', csv_content[0]['Швидкість вітру (м/с)']
  ensure
    File.delete(filename) if File.exist?(filename)
  end
end
