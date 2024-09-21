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

  def find(value, node = @root)
    return nil if node.nil?

    if value < node.data
      find(value, node.left_node)
    elsif value > node.data
      find(value, node.right_node)
    else
      node
    end
  end

  def delete_node(root, value)
    return root if root.nil?

    # treversing the tree for the selected data
    if value < root.data
      root.left_node = delete_node(root.left_node, value)
    elsif value > root.data
      root.right_node = delete_node(root.right_node, value)
    else
      # Deleting a leaf node
      return nil if root.left_node.nil? && root.right_node.nil?

      # Deleteing a node with one child node
      return root.right_node if root.left_node.nil?
      return root.left_node if root.right_node.nil?

      # Deleting a node with two children nodes
      succ_node = get_successor_node(root)
      root.data = succ_node.data
      root.right_node = delete_node(root.right_node, succ_node.data)

    end
    root
  end

  def get_successor_node(node)
    return nil unless node.right_node

    current_node = node.right_node
    current_node = current_node.left_node while current_node.left_node
    current_node
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
