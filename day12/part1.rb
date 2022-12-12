# frozen_string_literal: true

require "set"

class Node
  attr_accessor :shortest_distance
  attr_reader :height, :row, :column, :connections

  def initialize(height, row, column)
    @height = height
    @row = row
    @column = column
    @connections = []
    @shortest_distance = nil
  end

  def check_neighbor(neighbor)
    @connections << neighbor if height >= neighbor.height - 1
  end

  def distance_to(node)
    (row - node.row).abs + (column - node.column).abs
  end

  def to_s
    "#{height} - #{row}:#{column}"
  end
end

def build_node(nodes, node, row, column)
  node.check_neighbor(nodes[row - 1][column]) if row.positive?
  node.check_neighbor(nodes[row + 1][column]) if row < nodes.size - 1
  node.check_neighbor(nodes[row][column - 1]) if column.positive?
  node.check_neighbor(nodes[row][column + 1]) if column < nodes[row].size - 1
end

def node_height_from_character(character)
  case character
  when "S"
    1
  when "E"
    26
  else
    character.ord - 96
  end
end

def find_shortest_path(starting_node, ending_node, nodes)
  evaluations = [{
    node: starting_node,
    distance_to_end: starting_node.distance_to(ending_node),
    current_distance: 0,
    visited: [starting_node]
  }]

  loop do
    evaluations.sort_by! { |evaluation| evaluation[:distance_to_end] + evaluation[:current_distance] }
    next_evaluation = evaluations.shift

    next if next_evaluation[:node].shortest_distance && next_evaluation[:node].shortest_distance <= next_evaluation[:current_distance]

    next_evaluation[:node].shortest_distance = next_evaluation[:current_distance]
    next_evaluation[:node].connections.each do |node|
      next if node.shortest_distance && node.shortest_distance <= next_evaluation[:current_distance]

      return next_evaluation[:visited].clone << node if node == ending_node

      evaluations << {
        node: node,
        distance_to_end: node.distance_to(ending_node),
        current_distance: next_evaluation[:current_distance] + 1,
        visited: next_evaluation[:visited].clone << node
      }
    end

    # print_node_path(nodes, next_evaluation[:visited], starting_node, ending_node)
  end
end

def print_node_path(nodes, visited, starting_node, ending_node)
  outs = []
  nodes.each { |node_row| outs << (" " * node_row.size) }
  visited.each { |node| outs[node.row][node.column] = "*" }
  outs[starting_node.row][starting_node.column] = "S"
  outs[ending_node.row][ending_node.column] = "E"
  pp("=" * outs[0].size)
  outs.each { |out| pp out }

  sleep(0.1)
end

lines = File.readlines("input.txt", chomp: true)

nodes = []
starting_node = nil
ending_node = nil

lines.each_with_index do |line, row|
  nodes_row = []
  line.chars.each_with_index do |character, column|
    is_starting_node = character == "S"
    is_ending_node = character == "E"
    node = Node.new(node_height_from_character(character), row, column)
    starting_node = node if is_starting_node
    ending_node = node if is_ending_node
    nodes_row << node
  end
  nodes << nodes_row
end

nodes.each_with_index do |node_row, row|
  node_row.each_with_index do |node, column|
    build_node(nodes, node, row, column)
  end
end

path = find_shortest_path(starting_node, ending_node, nodes)

pp path.size - 1
