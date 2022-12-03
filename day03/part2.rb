# frozen_string_literal: true

sacks = File.readlines("input.txt")

value = sacks.each_slice(3).map do |group|
  item = group.map(&:chars).reduce(&:&).first
  # puts "#{sack} => #{first_half.length}:#{first_half}-#{second_half.length}:#{second_half} => #{item}:#{item.ord}"
  item.ord > 96 ? item.ord - 96 : item.ord - 38
end.sum

puts value
