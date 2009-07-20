require File.join(File.dirname(__FILE__), "/../spec_helper")

describe Enumerable do
  
  before do 
    @a = [1,2,3]
  end
  
  it "should have a map_with_index" do
    @a.map_with_index {|e, i| i * 2}.should eql([0, 2, 4])
    @a.should eql([1,2,3])
  end
  
  it "should have a destructive map with index" do
    @a.map_with_index! {|e, i| i * 2}.should eql([0, 2, 4])
    @a.should eql([0,2,4])
  end
  
  it "should be able to scale an array by another array" do
    @a.scale_with([2,2,2]).should eql([2,4,6])
    @a.should eql([1,2,3])
  end

  it "should have a dextructive scale with method" do
    @a.scale_with!([2,2,2]).should eql([2,4,6])
    @a.should eql([2,4,6])
  end
  
  it "should be able to do a simple sum" do
    @a.sum.should eql(6)
  end
  
  it "should be able to calculate the mean" do
    @a.mean.should eql(2)
  end

  it "should know the position of the minimum value" do
    @a.min_position.should eql(0)
  end
  
  it "should know the position of the maximum value" do
    @a.max_position.should eql(2)
  end
  
end
