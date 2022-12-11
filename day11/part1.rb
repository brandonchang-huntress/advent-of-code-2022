# frozen_string_literal: true

require "byebug"

monkeys = File.read("input.txt")
  .scan(/Monkey (\d):\n  Starting items: ([\d ,]+)\n  Operation: (.*)\n  Test: divisible by (\d+)\n    If true: throw to monkey (\d)\n    If false: throw to monkey (\d)/)
  .map do |monkey|
    {
      id: monkey[0],
      items: monkey[1].split(", ").map(&:to_i),
      operation: ->(old) { eval(monkey[2]) }, # rubocop:disable Lint/UnusedBlockArgument
      division_test: monkey[3].to_i,
      true_monkey: monkey[4].to_i,
      false_monkey: monkey[5].to_i,
      inspection_count: 0
    }
  end

20.times do
  monkeys.each do |monkey|
    while monkey[:items].size.positive?
      item = monkey[:items].shift
      # byebug
      new_value = monkey[:operation].call(item) / 3
      if (new_value % monkey[:division_test]).zero?
        monkeys[monkey[:true_monkey]][:items] << new_value
      else
        monkeys[monkey[:false_monkey]][:items] << new_value
      end
      monkey[:inspection_count] += 1
    end
  end
end

monkey_business = monkeys.map { |monkey| monkey[:inspection_count] }.max(2).reduce(&:*)

pp monkey_business
