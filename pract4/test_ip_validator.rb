require 'minitest/autorun'

def valid_ip?(ip)
  parts = ip.split('.')
  return false unless parts.length == 4

  parts.all? do |part|
    part.match?(/\A[1-9]\d{0,2}\z/) && part.to_i.between?(0, 255) || part == '0'
  end
end

class TestIpValidator < Minitest::Test
  def test_valid_ip
    assert_equal true, valid_ip?("192.168.1.1")
  end

  def test_invalid_ip_out_of_range
    assert_equal false, valid_ip?("256.255.255.1")
  end

  def test_invalid_ip_leading_zero
    assert_equal false, valid_ip?("192.168.01.1")
  end

  def test_invalid_ip_missing_parts
    assert_equal false, valid_ip?("123.456.78")
  end

  def test_invalid_ip_extra_parts
    assert_equal false, valid_ip?("192.168.1.1.1")
  end

  def test_invalid_ip_non_numeric_part
    assert_equal false, valid_ip?("192.168.one.1")
  end

  def test_valid_ip_all_zeros
    assert_equal true, valid_ip?("0.0.0.0")
  end
end
