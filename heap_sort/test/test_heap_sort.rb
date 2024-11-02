# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../lib/heap_sort'


class HeapSortTest < Minitest::Test
  def test_sort
    result = HeapSort.sort([4, 1, 3, 5, 2])
    puts "Отсортированный массив: #{result}"
    assert_equal [1, 2, 3, 4, 5], result

    result = HeapSort.sort([0, -1, 4, 2, -3])
    puts "Отсортированный массив: #{result}"
    assert_equal [-3, -1, 0, 2, 4], result

    result = HeapSort.sort([5])
    puts "Отсортированный массив: #{result}"
    assert_equal [5], result

    result = HeapSort.sort([])
    puts "Отсортированный массив: #{result}"
    assert_equal [], result
  end
end
