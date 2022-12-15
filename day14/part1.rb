# frozen_string_literal: true

require "matrix"
require "set"

def simulate_sand(grid, min_x)
  count = 0
  loop do
    sand_position = Vector[500 - min_x, 0]

    result = simulate_sand_piece(grid, sand_position)
    return count unless result

    count += 1
  end
end

def simulate_sand_piece(grid, sand_position)
  loop do
    new_x = sand_position[0]
    new_y = sand_position[1] + 1
    return if new_y >= grid[0].size

    if grid[new_x][new_y].nil?
      sand_position = Vector[new_x, new_y]
    elsif (new_x - 1).negative?
      return
    elsif grid[new_x - 1][new_y].nil?
      sand_position = Vector[new_x - 1, new_y]
    elsif new_x + 1 >= grid.size # rubocop:disable Lint/DuplicateBranch
      return
    elsif grid[new_x + 1][new_y].nil?
      sand_position = Vector[new_x + 1, new_y]
    else
      grid[sand_position[0]][sand_position[1]] = 0
      return true
    end
  end
end

lines = File.readlines("input.txt", chomp: true)

walls = Set.new
min_x = 500
max_x = 500
max_y = 0
lines.each do |line|
  start_vector = nil
  line.scan(/(\d+),(\d+)/) do |x, y|
    x = x.to_i
    y = y.to_i
    min_x = x if x < min_x
    max_x = x if x > max_x
    max_y = y if y > max_y

    if start_vector.nil?
      start_vector = Vector[x, y]
      next
    end

    end_vector = Vector[x, y]

    direction = (end_vector - start_vector).normalize
    current_position = start_vector
    loop do
      walls << current_position
      break if (start_vector - current_position).r >= (start_vector - end_vector).r

      current_position += direction
    end

    start_vector = end_vector
  end
end

size_x = max_x - min_x + 1
size_y = max_y + 1

grid = Array.new(size_x) { Array.new(size_y) }
walls.each { |wall| grid[wall[0] - min_x][wall[1]] = 1 }

num = simulate_sand(grid, min_x)
pp num
