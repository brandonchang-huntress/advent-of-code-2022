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

lines = lines
  .reject { |line| line == "" }
  .map { |line| eval line }

lines << [[2]]
lines << [[6]]

ordered_lines = lines.sort { |left, right| comparison(left, right) }

first_index = ordered_lines.find_index([[2]]) + 1
second_index = ordered_lines.find_index([[6]]) + 1
pp first_index * second_index
