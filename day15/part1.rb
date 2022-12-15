# frozen_string_literal: true

require "matrix"
require "set"

def manhattan_distance(vector1, vector2)
  distance = vector1 - vector2
  distance[0].abs + distance[1].abs
end

lines = File.readlines("input.txt", chomp: true)

sensors = lines.map do |line|
  captures = line.match(/Sensor at x=([-\d]+), y=([-\d]+): closest beacon is at x=([-\d]+), y=([-\d]+)/).captures.map(&:to_i)
  sensor = Vector[captures[0], captures[1]]
  beacon = Vector[captures[2], captures[3]]
  distance = manhattan_distance(sensor, beacon)
  {
    sensor: sensor,
    beacon: beacon,
    manhattan_distance: distance
  }
end

y = 2_000_000
non_beacon_locations = Set.new
beacon_locations = Set.new

sensors.each do |sensor|
  min_x = sensor[:sensor][0] - sensor[:manhattan_distance] + (y - sensor[:sensor][1]).abs
  max_x = sensor[:sensor][0] + sensor[:manhattan_distance] - (y - sensor[:sensor][1]).abs
  (min_x..max_x).each do |x|
    position = Vector[x, y]
    non_beacon_locations << position if manhattan_distance(position, sensor[:sensor]) <= sensor[:manhattan_distance]
  end
  beacon_locations << sensor[:beacon]
end

non_beacon_locations -= beacon_locations

pp non_beacon_locations.size
