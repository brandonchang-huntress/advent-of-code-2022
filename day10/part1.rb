# frozen_string_literal: true

commands = File.readlines("input.txt", chomp: true)

register = 1
cycle_values = [1]

commands.each do |command|
  if command == "noop"
    cycle_values << register
  else
    value = command.match(/addx (.+)/)[1].to_i
    cycle_values << register
    cycle_values << register
    register += value
  end
end

total = (cycle_values[20] * 20) +
        (cycle_values[60] * 60) +
        (cycle_values[100] * 100) +
        (cycle_values[140] * 140) +
        (cycle_values[180] * 180) +
        (cycle_values[220] * 220)

pp total
