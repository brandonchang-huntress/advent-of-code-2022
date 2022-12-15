# frozen_string_literal: true

require "active_support/core_ext/array"

def comparison(left_item, right_item)
  return left_item <=> right_item if left_item.is_a?(Integer) && right_item.is_a?(Integer)

  left_item_array = Array.wrap(left_item)
  right_item_array = Array.wrap(right_item)

  left_item_array.each_with_index do |item1, index|
    return 1 if index >= right_item_array.size

    comp = comparison(item1, right_item_array[index])
    return comp unless comp.zero?
  end

  return 0 if left_item_array.size == right_item_array.size

  -1
end

lines = File.readlines("input.txt", chomp: true)

right_order_indices = []
lines.each_slice(3).each_with_index do |line_slice, index|
  array1 = eval line_slice[0]
  array2 = eval line_slice[1]

  comp = comparison(array1, array2)

  pp("*" * 20)
  pp array1
  pp array2
  pp comp
  pp("*" * 20)

  right_order_indices << (index + 1) if comp == -1
end

pp right_order_indices.size
pp right_order_indices.sum
