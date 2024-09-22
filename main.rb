# frozen_string_literal: true

require_relative 'lib/binary_search_tree'

def main # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
  bst = BSTree.new(Array.new(15) { rand(1..100) })

  puts bst.balanced? ? 'Binary tree is balanced' : 'Binary treee is not balanced'

  bst.level_order
  puts '<- Bredth-first traversal'

  bst.preorder
  puts '<- Preorder traversal'

  bst.inorder
  puts '<- Inorder traversal'

  bst.postorder
  puts '<- Postorder traversal'

  7.times do
    a = rand(100..200)
    bst.insert(a)
    puts "Inserted #{a} in tree"
  end

  puts bst.balanced? ? 'Binary tree is balanced' : 'Binary treee is not balanced'

  bst.rebalance

  puts bst.balanced? ? 'Binary tree is balanced' : 'Binary treee is not balanced'

  bst.level_order
  puts '<- Bredth-first traversal'

  bst.preorder
  puts '<- Preorder traversal'

  bst.inorder
  puts '<- Inorder traversal'

  bst.postorder
  puts '<- Postorder traversal'
end

main
