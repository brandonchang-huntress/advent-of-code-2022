# frozen_string_literal: true

file_lines = File.readlines("input.txt")

file_lines_iterator = file_lines.each

crate_stacks = Array.new(9) { [] }

loop do
  line = file_lines_iterator.next

  break if file_lines_iterator.peek == "\n"

  line.scan(/.{1,4}/).map { |s| s.strip.delete("[]") }.each_with_index do |item, index|
    (crate_stacks[index]).unshift(item) if item != ""
  end
end

file_lines_iterator.next

loop do
  line = file_lines_iterator.next

  moves = line.match(/move (\d+) from (\d) to (\d)/)
  next unless moves

  num = moves[1].to_i
  from_container = moves[2].to_i - 1
  to_container = moves[3].to_i - 1

  crate_stacks[to_container].push(*crate_stacks[from_container].pop(num))
end

output = crate_stacks.map(&:last).join

puts output
