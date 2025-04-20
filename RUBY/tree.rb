    class Tree
        attr_accessor :value, :left, :right
        def initialize(value, left=nil, right=nil)
        @value = value
        @left = left
        @right = right
        end
    
    # each_node method using a block 
    # pre-order traversal
        def each_node(&block)
        yield value
        left.each_node(&block) if left
        right.each_node(&block) if right
        end
    
    # method_missing - navigate tree by method names
        def method_missing(method_name, *args, &block)
        path = method_name.to_s.scan(/left|right/)
        current = self
        path.each do |direction|
            current = current.send(direction)
            return nil unless current
        end
        current
        end
    
        def respond_to_missing?(method_name, include_private = false)
        method_name.to_s.match?(/\A(?:left|right)+(?:_(?:left|right)+)*\z/) || super
        end
    end
    
    # Example
    my_tree = Tree.new(42,
                    Tree.new(3,
                            Tree.new(1,
                                    Tree.new(7,
                                            Tree.new(22),
                                            Tree.new(123)),
                                    Tree.new(32))),
                    Tree.new(99,
                            Tree.new(81)))
    
        puts " Each Node (puts)"
        my_tree.each_node { |v| puts v }
        
        puts "\n Each Node (to array)"
        arr = []
        my_tree.each_node { |v| arr.push v }
        p arr
        
        puts "\n Getting nodes from tree"
        p my_tree.left_left
        p my_tree.right_left
        p my_tree.left_left_right
        p my_tree.left_left_left_right
        