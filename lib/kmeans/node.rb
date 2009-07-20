module KMeans #:nodoc:
  class Node
    class << self
      
      # Clears out all nodes.  Don't do this while working on a specific
      # problem, but in-between problems.  This nodes-on-the-Node stuff needs
      # to be adjusted when I have some time. 
      def clear_nodes!
        self.nodes.clear
      end
      
      # Returns the number of re-assignments made
      def cluster_to(centroids, scaling=nil)
        n = 0
        self.nodes.each do |node|
          position = centroids.map { |centroid| node.distance(centroid, scaling) }.min_position
          target_centroid = centroids[position]
          next if target_centroid == node.centroid
          node.move_to(target_centroid)
          n += 1
        end
        n
      end
      
      # Gets the max and min on every dimension for every node
      def find_boundaries
        return nil if self.nodes.empty?
        return @@boundaries if @@boundaries
        # Building this long-hand for good reason...
        dimensional_array = []
        self.dimension_size.times {dimensional_array << [nil, nil]}
        @@boundaries = self.nodes.inject(dimensional_array) do |list, node|
          node.position.each_with_index do |dimension, i|
            list[i][0] ||= dimension
            list[i][1] ||= dimension
            list[i][0] = dimension if dimension < list[i][0]
            list[i][1] = dimension if dimension > list[i][1]
          end
          list
        end
      end
      alias :boundaries :find_boundaries
      
      # A list of nodes initialized
      def nodes
        @@nodes ||= []
      end
      
      def dimension_size
        @@dimension_size
      end
      
      def dimension_size=(val)
        @@dimension_size = val
      end
      
      # Instantiates the node object and adds them to the list.  Example:
      # Node.add_nodes [1,2,3], [4,5,3], [2,1,3]
      # Node.add_nodes *node_list
      def add_nodes(*nodes)
        nodes.each do |node|
          node = new(*node)
        end
      end
      
      # Adds a node, clears the cache, asserts that the parameter is a node.
      def add_node(node)
        node = new(*node) unless node.is_a?(Node)
        self.dimension_size = node.position.size if self.nodes.empty?
        raise ArgumentError, "Node does not have the right number of positions" unless
          node.position.size == self.dimension_size
        self.nodes << node
        @@boundaries = nil
        node
      end
      
      # A centroid that fits between the boundaries on each dimension.  The
      # boundaries for a 3-dimensional model might look like: 
      # [[1,5], [0,10], [1,100]]
      # This means that the first dimension can be between 1 and 5, the second
      # between 0 and 10, and the third between 1 and 100. 
      def random_centroid
        position = (0...self.dimension_size).inject([]) do |list, i|
          list << rand_between(self.boundaries[i].first, self.boundaries[i].last)
        end
        Centroid.new(position)
      end
      
    end
    
    # The position on every dimension
    attr_reader :position
    
    # Creates a node based only on the position.  The dimension
    # cardinality is enforced on the class level (I.e., all nodes must have
    # the same number of position.) 
    def initialize(*position)
      @position = position
      Node.add_node(self)
    end
    
    # Records which centroid the node is assigned to
    attr_accessor :centroid
    
    def distance(centroid=nil, scaling=nil)
      centroid ||= self.centroid
      op = centroid.position
      map = self.position.map_with_index do |e, i|
        if scaling
          (
            (op[i] * scaling[i]) - 
            (e * scaling[i])
          ) ** 2
        else
          (op[i] - e) ** 2
        end
      end
      Math.sqrt(map.sum)
    end
    
    def move_to(centroid)
      self.centroid.remove_node(self) if self.centroid
      centroid.add_node(self)
    end
  end
end