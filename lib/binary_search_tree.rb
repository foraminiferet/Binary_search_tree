require_relative 'node'

class BSTree
  attr_accessor :data, :root

  def initialize(arr)
    @data = arr.sort.unique
    @root = build_tree(data)
  end

  def delete(value)
    delete_node(@root, value)
  end

  def insert(value)
    insert_node(@root, value)
  end

  def insert_node(root, value)
    return Node.new(value) if root.nil?

    return root if root.data == value

    if root.data > value
      root.left_node = insert_node(root.left_node, value)
    elsif root.data < value
      root.right_node = insert_node(root.right_node, value)
    end
    root
  end

  def build_tree(data)
    return nil if data.empty?

    mid = data.size / 2
    root = Node.new(data[mid])

    root.left_node = build_tree(data[0...mid])
    root.right_node = build_tree(data[(mid + 1)..])

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
