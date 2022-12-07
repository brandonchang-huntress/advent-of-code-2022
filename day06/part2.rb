# frozen_string_literal: true

input = File.read("input.txt")

index = 14
while index < input.length
  break if input[index - 14, 14].chars.uniq.length >= 14

  index += 1
end

puts index
