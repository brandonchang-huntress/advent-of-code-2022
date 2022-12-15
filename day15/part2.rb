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

max_location = 4_000_000
# max_location = 20
signal_location = nil

(max_location * 2).times do |diagonal_num|
  x = [diagonal_num, max_location].min
  y = diagonal_num - x
  while x >= 0 && y <= max_location
    position = Vector[x, y]
    puts position
    sensor_index = nil
    sensors.each_with_index do |sensor, index|
      next unless manhattan_distance(position, sensor[:sensor]) <= sensor[:manhattan_distance]

      sensor_index = index
      break
    end

    signal_location = position unless sensor_index
    break if signal_location

    # ey = (D + py + px + sy - sx) / 2
    sensor = sensors[sensor_index][:sensor]
    sensor_detector_distance = sensors[sensor_index][:manhattan_distance]
    y = ((sensor_detector_distance + position[0] + position[1] + sensor[1] - sensor[0]) / 2) + 1
    x = diagonal_num - y
  end
  break if signal_location
end

pp signal_location
pp((signal_location[0] * 4_000_000) + signal_location[1])

#
#
#
#
#
#            1    1    2    2
#  0    5    0    5    0    5
# -2 ..........#.................
# -1 .........#o#..........#.....
#  0 ....S...###o#........###....
#  1 .......###o#o#......##S##...
#  2 ......#####o#o#S.....###....
#  3 .....#####o#o#o#SB....#.....
#  4 ....#######o#o#o#...........   sx, sy, px, py, ex, ey, d, D
#  5 ...#######o#o#o###..........   |(px - sx)| + |(py - sy)| = d
#  6 ..#######o#o#o#####.........   ey = (D + py + px + sy - sx) / 2
#  7 .#######o#S#o#####S#........   ex + ey = px + py
#  8 ..#######o#o#######.........   ex = px + py - ey
#  9 ...#######o#######..........   D = 9
# 10 ....B####o#o#####...........   S = 12,7     B = 6,10
# 11 ..S..###o#o#####............   P = 12,9
# 12 ......#o###o###.............   ey = 12
# 13 ......O###o###..............
# 14 .....o..###o#.S.......S.....
# 15 B...o....#o#................
# 16 ..........#SB...............
# 17 ................S..........B
# 18 ....S.......................
# 19 ............................
# 20 ............S......S........
# 21 ............................
# 22 .......................B....
#
#
#
#
#
#
#
#
#
#
