# frozen_string_literal: true

require "set"
require "matrix"
require "byebug"

moves = File.readlines("input.txt").map { |line| line.match(/(.) (.+)/).captures }

head = Vector[0, 0]
tail = Vector[0, 0]
tail_history = Set.new
tail_history.add tail
max_distance = Vector[1, 1].r

moves.each do |move|
  direction = move[0]
  distance = move[1].to_i

  distance.times do
    old_head = head

    direction_vector =
      case direction
      when "U"
        Vector[1, 0]
      when "D"
        Vector[-1, 0]
      when "L"
        Vector[0, -1]
      when "R"
        Vector[0, 1]
      end

    head += direction_vector
    if (head - tail).r > max_distance
      tail = old_head
      tail_history.add tail
    end
  end
end

# pp tail_history
pp tail_history.size
