# frozen_string_literal: true

inputs = File.read("input.txt").split("\n")

shape_scores = {
  "X" => 1,
  "Y" => 2,
  "Z" => 3
}

equivalent_shapes = {
  "A" => "X",
  "B" => "Y",
  "C" => "Z"
}

win_matrix = {
  "X" => "Z",
  "Y" => "X",
  "Z" => "Y"
}

output = inputs.reduce(0) do |total, value|
  opponent, response = value.split
  opponent = equivalent_shapes[opponent]

  match_score =
    if win_matrix[response] == opponent
      6
    elsif win_matrix[opponent] == response
      0
    else
      3
    end
  shape_score = shape_scores[response]
  total + match_score + shape_score
end

puts output
