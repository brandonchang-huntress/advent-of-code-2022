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

display = []
value_iterator = cycle_values.each
value_iterator.next
6.times do
  current_display = String.new
  40.times do |column|
    current_value = value_iterator.next
    current_display <<
      if [current_value - 1, current_value, current_value + 1].include?(column)
        "#"
      else
        "."
      end
  end
  display << current_display
end

pp display
