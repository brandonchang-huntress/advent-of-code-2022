# frozen_string_literal: true

sacks = File.readlines("input.txt")

value = sacks.map do |sack|
  sack_string = sack.strip
  first_half = sack_string[0, sack_string.length / 2]
  second_half = sack_string[sack_string.length / 2, sack_string.length]

  item = (first_half.chars & second_half.chars).first
  # puts "#{sack} => #{first_half.length}:#{first_half}-#{second_half.length}:#{second_half} => #{item}:#{item.ord}"
  item.ord > 96 ? item.ord - 96 : item.ord - 38
end.sum

puts value
