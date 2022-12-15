# frozen_string_literal: true

require "matrix"
require "set"

def simulate_sand(grid)
  count = 0
  loop do
    return count unless grid[500][0].nil?

    simulate_sand_piece(grid, Vector[500, 0])
    count += 1
  end
end

def simulate_sand_piece(grid, sand_position)
  loop do
    new_x = sand_position[0]
    new_y = sand_position[1] + 1

    if grid[new_x][new_y].nil?
      sand_position = Vector[new_x, new_y]
    elsif (new_x - 1).negative?
      raise "Left side not big enough"
    elsif grid[new_x - 1][new_y].nil?
      sand_position = Vector[new_x - 1, new_y]
    elsif new_x + 1 >= grid.size
      raise "Right side not big enough"
    elsif grid[new_x + 1][new_y].nil?
      sand_position = Vector[new_x + 1, new_y]
    else
      grid[sand_position[0]][sand_position[1]] = 0
      return
    end
  end
end

lines = File.readlines("input.txt", chomp: true)

walls = Set.new
max_y = 0
lines.each do |line|
  start_vector = nil
  line.scan(/(\d+),(\d+)/) do |x, y|
    x = x.to_i
    y = y.to_i
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

size_y = max_y + 3
size_x = 1000

grid = Array.new(size_x) { Array.new(size_y) }
walls.each { |wall| grid[wall[0]][wall[1]] = 1 }
grid.each { |gridx| gridx[size_y - 1] = 1 }

num = simulate_sand(grid)
pp num
