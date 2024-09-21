require_relative 'node'

class BSTree
  attr_accessor :data, :root

  def initialize(arr)
    # Initalizes the BSTree with a sorted array of unique values
    @data = arr.sort.unique
    @root = build_tree(data)
  end

  def delete(value)
    delete_node(root, value)
  end

  def insert(value)
    insert_node(root, value)
  end

  # Calculating the depth of a node(traversal thought parent node)
  def depth(node, parent = root, egdes = 0)
    return -1 if node.nil?
    return egdes if node == parent

    if node.data < parent.data
      depth(node, parent.left_node, egdes + 1)
    elsif node.data > parent.data
      depth(node, parent.right_node, egdes + 1)
    end
  end

  # Height of the longest branch
  def height(node = root)
    return 0 if node.nil?

    left_hight = height(node.left_node)
    right_height = height(node.right_node)

    [left_hight, right_height].max + 1
  end

  # Preorder DLR
  def preorder(node = root)
    return if node.nil?

    print "#{node.data} "
    preorder(node.left_node)
    preorder(node.right_node)
  end

  # Inorder LDR
  def inorder(node = root)
    return if node.nil?

    inorder(node.left_node)
    print "#{node.data} "
    inorder(node.right_node)
  end

  # Postorder LRD
  def postorder(node = root)
    return if node.nil?

    postorder(node.left_node)
    postorder(node.right_node)
    printf "#{node.data} "
  end

  # `Breadth-first traversal`
  def level_order(node = root, queue = [])
    print "#{node.data} "
    queue << node.left_node unless node.left_node.nil?
    queue << node.right_node unless node.right_node.nil?
    return if queue.empty?

    level_order(queue.shift, queue)
  end

  # Find a node in binary search tree or return nil
  def find(value, node = root)
    return nil if node.nil?

    # Traversing the left and rigt sub-trees
    if value < node.data
      find(value, node.left_node)
    elsif value > node.data
      find(value, node.right_node)
    else
      node
    end
  end

  def delete_node(root, value)
    # Base case if the value isn't in the tree
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
    # Keeping the tree shape
    root
  end

  # Get the node with the next highest value right->left treversal
  def get_successor_node(node)
    # Base case if there is no right node
    return nil unless node.right_node

    # Getting the node with the next highest value
    current_node = node.right_node
    current_node = current_node.left_node while current_node.left_node
    current_node
  end

  def insert_node(root, value)
    # Base case for creating the node
    return Node.new(value) if root.nil?

    # Not allowing duplicates
    return root if root.data == value

    # Position where to insert the node
    if root.data > value
      root.left_node = insert_node(root.left_node, value)
    elsif root.data < value
      root.right_node = insert_node(root.right_node, value)
    end
    # Retuning the root node so tath the tree keeps it's shape
    root
  end

  # Building a binary search tree
  def build_tree(data)
    return nil if data.empty?

    # Getting the root node
    mid = data.size / 2
    root = Node.new(data[mid])

    # Creating a left and right tree
    root.left_node = build_tree(data[0...mid])
    root.right_node = build_tree(data[(mid + 1)..])

    # Retuning the root node so the tree keeps it shape
    root
  end

  # Print BST elemets
  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
