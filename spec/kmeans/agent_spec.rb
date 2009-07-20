require File.join(File.dirname(__FILE__), "/../spec_helper")

describe Agent do
  before(:all) do
    @node_list = [[1,1,1], [2,2,2], [3,3,3], [7,7,7], [8,8,8],[9,9,9]]
  end
  
  it "should be able to process things simply" do
    agent = Agent.process(:k => 2, *@node_list)
    centroid_map = agent.centroids.map {|c| c.position}
    centroid_map.should be_include([2,2,2])
    centroid_map.should be_include([8,8,8])
  end
  
  it "should be able to assume the first parameter is the k parameter in a simple usage situation" do
    agent = Agent.process(2, *@node_list)
    centroid_map = agent.centroids.map {|c| c.position}
    centroid_map.should be_include([2,2,2])
    centroid_map.should be_include([8,8,8])
  end
  
  it "should allow centroids to be passed in to simplify processing" do
    c1 = Centroid.new([4,4,4])
    c2 = Centroid.new([5,5,5])
    agent = Agent.process(:k => 2, :centroids => [c1, c2], *@node_list)
    c1.position.should eql([2,2,2])
    c2.position.should eql([8,8,8])
  end
    
end