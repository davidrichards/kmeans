$: << File.join(File.dirname(__FILE__), "/../lib") 
require 'rubygems' 
require 'spec' 
require 'kmeans'
require 'factory_girl'

include KMeans

Spec::Runner.configure do |config|
  def new_node
    @node = Node.new(1, 2, 3)
  end
end

