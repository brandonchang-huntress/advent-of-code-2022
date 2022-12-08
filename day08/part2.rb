# frozen_string_literal: true

require "byebug"

def scenic_score(trees, row, column)
  height = trees[row][column].to_i
  up = 0
  down = 0
  left = 0
  right = 0

  (row - 1).downto(0) do |n|
    up += 1
    break if trees[n][column].to_i >= height
  end

  (row + 1).upto(98) do |n|
    down += 1
    break if trees[n][column].to_i >= height
  end

  (column - 1).downto(0) do |n|
    left += 1
    break if trees[row][n].to_i >= height
  end

  (column + 1).upto(98) do |n|
    right += 1
    break if trees[row][n].to_i >= height
  end

  up * down * left * right
end

lines = File.readlines("input.txt").map(&:chomp)

max_sceneic_score = 0

(1...98).each do |row|
  (1...98).each do |column|
    current_sceneic_score = scenic_score(lines, row, column)

    max_sceneic_score = current_sceneic_score if current_sceneic_score > max_sceneic_score
  end
end

puts max_sceneic_score
