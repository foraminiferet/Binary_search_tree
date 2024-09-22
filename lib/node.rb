# frozen_string_literal: true

class Node # rubocop:disable Style/Documentation
  attr_accessor :data, :left_node, :right_node

  def initialize(data)
    @data = data
    @left_node = nil
    @right_node = nil
  end
end
