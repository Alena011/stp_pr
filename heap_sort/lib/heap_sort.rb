# frozen_string_literal: true

require_relative "heap_sort/version"

module HeapSort
  class Error < StandardError; end

  def self.sort(array)
    n = array.length

    (n / 2 - 1).downto(0) do |i|
      heapify(array, n, i)
    end

    (n - 1).downto(1) do |i|
      array[0], array[i] = array[i], array[0]
      heapify(array, i, 0)
    end

    array
  end

  private

  def self.heapify(array, heap_size, root_index)
    largest = root_index
    left_child = 2 * root_index + 1
    right_child = 2 * root_index + 2

    if left_child < heap_size && array[left_child] > array[largest]
      largest = left_child
    end

    if right_child < heap_size && array[right_child] > array[largest]
      largest = right_child
    end
    if largest != root_index
      array[root_index], array[largest] = array[largest], array[root_index]
      heapify(array, heap_size, largest)
    end
  end
end
