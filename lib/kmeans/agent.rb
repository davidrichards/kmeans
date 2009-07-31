module KMeans #:nodoc:
  class Agent
    
    include TeguGears

    class << self
      # Only works if the agent was processed as an online algorithm
      def rebase(*node_list)
        return false unless @@agent
        @@agent.rebase(*node_list)
      end
    end
    
    # The number of clusters we're after
    attr_reader :k

    # Whether we're interested in keeping the results after processing.  To re-process:
    # Agent.rebase(*new_node_list)
    attr_reader :online
    
    # The centroids used for the clustering
    attr_reader :centroids
    
    # The maximum number of iterations allowed
    attr_reader :max
    
    # The number of iterations used
    attr_reader :num_iterations
    
    # All the affectd nodes
    def nodes
      Node.nodes
    end

    # Example:
    # KMeans::Agent.call(3, [1,2,1], [2,1,3], ...)
    # KMeans::Agent.call(:k => 3, :centroids => [[1,2,3],[2,3,4],[3,4,2]], [1,2,1], [2,1,3], ...)
    def process(opts={}, *node_list)
      
      unless self.online
        Node.clear_nodes! 
        @centroids = nil
      end
      
      
      @scaling = opts.fetch(:scaling, false) if opts.is_a?(Hash)
      Node.add_nodes(*node_list)
      
      if opts.is_a?(Hash)
        @k = opts[:k]
        @centroids = opts.fetch(:centroids, false)
        @online = opts.fetch(:online, false)
        @max = opts.fetch(:max, 10_000)
      else
        @k = opts
      end

      stabilize_centroids
      @@agent = self if self.online
      self

    end
    
    def rebase(*node_list)
      Node.add_nodes(*node_list)
      stabilize_centroids
      self
    end

    protected
    
      # This is the core algorithm: assign nodes to centroids, rebalance
      # centroids, repeat until no new assignment is necessary. 
      def stabilize_centroids
        @centroids ||= infer_centroids(@k)
        n = Node.cluster_to(@centroids)
        @num_iterations = 0
        while n > 0
          @centroids.each { |c| c.rebalance }
          n = Node.cluster_to(@centroids)
          @num_iterations += 1
          break if self.num_iterations >= self.max
        end
      end
      
      def infer_centroids(k)
        (1..k).map do
          Node.random_centroid
        end
      end
    
  end
end