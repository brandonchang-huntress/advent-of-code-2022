# frozen_string_literal: true

require "byebug"

lines = File.readlines("input.txt").map(&:chomp)

total = 0

(0...99).each do |row|
  pp "row: #{row} - count: #{total}"
  (0...99).each do |column|
    # byebug if row == 97

    if row.zero? || row == 98 || column.zero? || column == 98
      pp "visible from outside - row: #{row} - column: #{column}"
      total += 1
      next
    end

    height = lines[row][column, 1].to_i

    visible = true

    (0...99).each do |counter|
      if counter == column
        break if visible

        visible = true
        next
      end

      compared_height = lines[row][counter, 1].to_i

      if compared_height >= height
        visible = false
        break if counter > column
      end
    end

    if visible
      pp "visible from vertical - row: #{row} - column: #{column}"
      total += 1
      next
    end

    visible = true

    (0...99).each do |counter|
      if counter == row
        break if visible

        visible = true
        next
      end

      compared_height = lines[counter][column, 1].to_i

      if compared_height >= height
        visible = false
        break if counter > row
      end
    end

    total += 1 if visible
    pp "visible from side - row: #{row} - column: #{column}" if visible
  end
end

puts total
