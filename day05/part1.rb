# frozen_string_literal: true

file_lines = File.readlines("input.txt")

file_lines_iterator = file_lines.each

crate_stacks = Array.new(9) { [] }
# Do not use Array.new(9, [])
# It will give you a headache for an hour

loop do
  line = file_lines_iterator.next

  break if file_lines_iterator.peek == "\n"

  line.scan(/.{1,4}/).map { |s| s.strip.delete("[]") }.each_with_index do |item, index|
    # puts "putting in > #{item} < at index #{index}" if item != ""
    (crate_stacks[index]).unshift(item) if item != ""
  end
end

file_lines_iterator.next
# puts crate_stacks
# puts "================="

loop do
  line = file_lines_iterator.next

  moves = line.match(/move (\d+) from (\d) to (\d)/)
  next unless moves

  num = moves[1].to_i
  from_container = moves[2].to_i - 1
  to_container = moves[3].to_i - 1
  num.times do
    item = crate_stacks[from_container].pop
    # puts "move #{item} from #{from_container + 1} to #{to_container + 1}"
    crate_stacks[to_container].push(item)
  end
  # crate_stacks[to_container].push(*crate_stacks[from_container].pop(num))
end

# crate_stacks.each { |stack| puts stack.count }
# puts "================="
output = crate_stacks.map(&:last).join

puts output
