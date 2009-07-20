module KMeans #:nodoc:
  class Centroid
    
    # The position of the centroid, or a value for every dimension
    attr_reader :position
    
    def initialize(position)
      @position = position
    end
    
    def nodes
      @nodes ||= []
    end
    
    def add_nodes(*new_nodes)
      new_nodes.each do |node|
        self.nodes << node
        node.centroid = self
      end
    end
    alias :add_node :add_nodes
    
    def remove_nodes(*nodes)
      nodes.each do |node|
        self.nodes.delete(node)
        node.centroid = nil
      end
    end
    alias :remove_node :remove_nodes
    
    # Finds a new centroid based on the nodes currently attached to it
    def rebalance
      return true if nodes.empty?
      size = nodes.first. position.size
      @position = (0...size).map do |i|
        self.nodes.map { |e| e. position[i] }.mean
      end
    end
    
    def inspect
      "KMeans::Centroid:#{self.position.inspect}"
    end
    
  end
end