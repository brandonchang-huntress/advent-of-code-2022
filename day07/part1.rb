# frozen_string_literal: true

require "active_support"

def parse_directory(current_directory, commands_iterator)
  loop do
    command = commands_iterator.next

    regex_result = command.match(/\$ cd (.*)/)

    if regex_result
      directory = regex_result[1]

      return if directory == ".."

      current_directory[directory] = { "files" => [] } unless current_directory[directory]
      parse_directory(current_directory[directory], commands_iterator)

      next
    end

    regex_result = command.match(/\$ ls/)
    next unless regex_result

    build_directory(current_directory, commands_iterator)
  end
end

def build_directory(current_directory, commands_iterator)
  loop do
    list_line = commands_iterator.peek

    break if list_line.start_with?("$")

    list_line = commands_iterator.next
    list_line_regex = list_line.match(/(\d+) (.+)/)

    next unless list_line_regex

    current_directory["files"] << { "name" => list_line_regex[2], "size" => list_line_regex[1].to_i }
  end
end

def directory_sizes(directory)
  sub_directories = directory.except("files").map { |_key, value| directory_sizes(value) }

  size = directory["files"].map { |file| file["size"] }.sum + sub_directories.map(&:first).sum
  [size] + sub_directories.flatten
end

commands = File.readlines("input.txt").map(&:chomp)
commands_iterator = commands.each

file_structure = { "files" => [] }

parse_directory(file_structure, commands_iterator)

pp file_structure

pp directory_sizes(file_structure).select { |s| s <= 100_000 }.sum
