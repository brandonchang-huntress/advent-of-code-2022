# frozen_string_literal: true

pairs = File.readlines("input.txt")

output = pairs.reduce(0) do |total, pair|
  pairset = pair.split(",")
  pairset = pairset.map { |p| p.split("-").map(&:to_i) }

  if pairset[0][0] == pairset[1][0]
    total + 1
  elsif pairset[0][0] > pairset[1][0]
    if pairset[0][1] <= pairset[1][1]
      total + 1
    else
      total
    end
  elsif pairset[0][1] >= pairset[1][1]
    total + 1
  else
    total
  end
end

puts output
