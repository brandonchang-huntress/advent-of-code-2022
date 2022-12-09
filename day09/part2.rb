# frozen_string_literal: true

require "set"
require "matrix"
require "byebug"

MAX_DISTANCE = Vector[1, 1].r

def calculate_following_knot(knot_index, knots)
  return if knot_index >= knots.size - 1

  knot_position = knots[knot_index]
  next_knot_index = knot_index + 1
  following_knot_position = knots[next_knot_index]
  vector_to_next_knot = knot_position - following_knot_position
  distance_to_next_knot = vector_to_next_knot.r
  return unless distance_to_next_knot > MAX_DISTANCE

  if vector_to_next_knot[0].zero? || vector_to_next_knot[1].zero?
    knots[next_knot_index] += vector_to_next_knot.normalize
  else
    knots[next_knot_index] +=
      Vector[vector_to_next_knot[0].positive? ? 1 : -1, vector_to_next_knot[1].positive? ? 1 : -1]
  end

  calculate_following_knot(knot_index + 1, knots)
end

moves = File.readlines("input.txt").map { |line| line.match(/(.) (.+)/).captures }

knots = Array.new(10) { Vector[0, 0] }
tail_history = Set.new
tail_history.add knots.last

moves.each do |move|
  direction = move[0]
  distance = move[1].to_i

  distance.times do
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

    knots[0] += direction_vector
    calculate_following_knot(0, knots)
    tail_history.add knots.last
  end
end

pp tail_history
pp tail_history.size
