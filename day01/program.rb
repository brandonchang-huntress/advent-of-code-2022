# frozen_string_literal: true

reindeer_inventory = File.read("input.txt").split("\n\n")

output = reindeer_inventory.map do |inv|
  inv.split.map(&:to_i).sum
end.sort.last(3).sum

puts output
