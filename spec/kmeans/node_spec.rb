require File.join(File.dirname(__FILE__), "/../spec_helper")

describe Node do
  
  before do
    Node.clear_nodes!
    @@boundaries = nil
  end
  
  context "instance methods" do
    before do
      @node = Node.new(1,2,3)
    end
    
    it "should record the position at initialization" do
      @node.position.should eql([1,2,3])
    end

    it "should know about all new nodes on the class level" do
      Node.nodes.should be_include(@node)
    end

    it "should have a centroid accessor" do
      @node.centroid = :whatever
      @node.centroid.should eql(:whatever)
    end

    # square root of 1^2 + 2^2 + 3^2 == square root of 14
    it "should be able to calculate the euclidian distance between a node and its centroid" do
      @c = Centroid.new([0,0,0])
      @c.add_node(@node)
      @node.distance.should eql(Math.sqrt(14))
    end

    it "should be able to scale the distance, so that some dimensions count more than others" do
      @c = Centroid.new([0,0,0])
      @node.distance(@c, [3,1,1]).should be_close(4.69, 0.001)
    end

    it "should be moveable from one centroid to another" do
      c1 = Centroid.new([0,0,0])
      c2 = Centroid.new([1,1,1])
      c1.add_node(@node)
      @node.move_to(c2)
      c1.nodes.should_not be_include(@node)
      c2.nodes.should be_include(@node)
    end

    it "should be able to clear all existing nodes for pseudo flexibility" do
      n1 = Node.new(1,2,3)
      Node.nodes.should be_include(n1)
      Node.clear_nodes!
      Node.nodes.should be_empty
    end
  
  end
  
  it "should be able to supply the max and min boundaries for each dimension" do
    n1 = Node.new 1
    n2 = Node.new 5
    Node.boundaries.should eql([[1,5]])
  end
  
  it "should be able to find boundaries with the right cardinality" do
    Node.new(1,2,3)
    Node.boundaries.should_not be_nil
    Node.send(:class_variable_get, :@@boundaries).should eql([[1,1], [2,2], [3,3]])
  end
  
  it "should be able to generate a random centroid within the limits of all the nodes already created" do
    n1 = Node.new 1
    n2 = Node.new 5
    100.times do
      Node.random_centroid.should be_is_a(Centroid)
      (Node.random_centroid.position.first >= 1).should be_true
      (Node.random_centroid.position.first <= 5).should be_true
    end
  end
  
  it "should be able to add a node with just the dimensions" do
    Node.clear_nodes!
    Node.add_node([1,2,3])
    Node.nodes.first.position.should eql([1,2,3])
  end
  
  it "should keep the cardinality of the dimensions consitent" do
    Node.new(1,2,3)
    lambda{Node.new(1,2)}.should raise_error(ArgumentError, 'Node does not have the right number of positions')
  end
  
  it "should reset the boundaries any time a new node is added" do
    Node.new(1,2,3)
    Node.find_boundaries
    Node.send(:class_variable_get, :@@boundaries).should eql([[1,1], [2,2], [3,3]])
    Node.new(2,2,2)
    Node.send(:class_variable_get, :@@boundaries).should be_nil
    Node.find_boundaries
    Node.send(:class_variable_get, :@@boundaries).should eql([[1,2], [2,2], [2,3]])
  end
  
  it "should be able to add many nodes at a time" do
    Node.add_nodes [1,2,3], [4,5,3], [2,1,3]
    Node.nodes.map{|n| n.position}.should eql([[1,2,3], [4,5,3], [2,1,3]])
  end
  
  it "should know the dimension size" do
    Node.add_node [1,2,3]
    Node.dimension_size.should eql(3)
    Node.clear_nodes!
    Node.add_node [1,2]
    Node.dimension_size.should eql(2)
  end
  
  it "should be able to cluster the nodes" do
    n1 = Node.new 1,1,1
    n2 = Node.new 2,2,2
    n3 = Node.new 3,3,3
    n4 = Node.new 7,7,7
    n5 = Node.new 8,8,8
    n6 = Node.new 9,9,9
    c1 = Centroid.new([2,2,2])
    c2 = Centroid.new([8,8,8])
    Node.cluster_to([c1, c2])
    c1.nodes.should be_include(n1)
    c1.nodes.should be_include(n2)
    c1.nodes.should be_include(n3)
    c2.nodes.should be_include(n4)
    c2.nodes.should be_include(n5)
    c2.nodes.should be_include(n6)
  end
  
end
