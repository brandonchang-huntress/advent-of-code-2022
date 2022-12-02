# frozen_string_literal: true

inputs = File.read("input.txt").split("\n")

shape_scores = {
  "A" => 1,
  "B" => 2,
  "C" => 3
}

win_matrix = {
  "A" => "C",
  "B" => "A",
  "C" => "B"
}

output = inputs.reduce(0) do |total, value|
  opponent, ending = value.split

  case ending
  when "X"
    shape_score = shape_scores[win_matrix[opponent]]
    match_score = 0
  when "Z"
    shape_score = shape_scores[win_matrix.key(opponent)]
    match_score = 6
  else
    shape_score = shape_scores[opponent]
    match_score = 3
  end
  puts "#{match_score}-#{shape_score}"
  total + match_score + shape_score
end

puts output
