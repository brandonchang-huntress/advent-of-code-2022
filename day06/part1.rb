# frozen_string_literal: true

input = File.read("input.txt")

index = 4
while index < input.length
  break if input[index - 4, 4].chars.uniq.length >= 4

  index += 1
end

puts index
