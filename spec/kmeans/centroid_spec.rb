require File.join(File.dirname(__FILE__), "/../spec_helper")

describe Centroid do
  
  before do
    @c = Centroid.new([1,2,3])
  end
  
  it "should initialize with a position list" do
    c = Centroid.new([1,2,3])
    c.position.should eql([1,2,3])
  end
  
  it "should have node storage" do
    @c.nodes.should be_is_a(Array)
  end
  
  it "should be able to add a node, to the centroid and the node (an optimization decision)" do
    @n = new_node
    @c.add_node(@n)
    @n.centroid.should eql(@c)
    @c.nodes.should be_include(@n)
  end
  
  it "should be able to add many nodes at a time" do
    @c.add_nodes(new_node, new_node, new_node)
    @c.nodes.size.should eql(3)
  end
  
  it "should be able to remove a node from the centroid and the node" do
    @n = new_node
    @c.add_node(@n)
    @c.remove_node(@n)
    @c.nodes.should_not be_include(@n)
    @n.centroid.should be_nil
  end
  
  it "should be able to remove a list of nodes" do
    n1, n2, n3 = new_node, new_node, new_node
    @c.add_node(n1, n2, n3)
    @c.nodes.should eql([n1, n2, n3])
    @c.remove_nodes(n2, n3)
    @c.nodes.should eql([n1])
  end
  
  it "should be able to rebalance the center of the centroid, based on the nodes" do
    n1 = Node.new(1,2,3)
    @c.add_node(n1)
    @c.rebalance
    @c.position.should eql([1,2,3])
    n2 = Node.new(2,4,6)
    @c.add_node(n2)
    @c.rebalance
    @c.position.should eql([3/2, 6/2, 9/2])
  end
end
