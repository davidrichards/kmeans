require File.join(File.dirname(__FILE__), "/../spec_helper")

describe Object do
  it "should be able to generate a random number between two integers" do
    val = (1..100).map {rand_between(1,10)}
    (val.min >= 1).should be_true
    (val.max <= 10).should be_true
  end
  
  it "should be able to generate a random number between two floats" do
    val = (1..100).map {rand_in_floats(1.0,10.0)}
    (val.min >= 1).should be_true
    (val.max <= 10).should be_true
    val.all? {|v| v.should be_is_a(Float)}
  end
  
  it "should be able to work with floats from rand_between" do
    val = (1..100).map {rand_between(1.0,10.0)}
    (val.min >= 1).should be_true
    (val.max <= 10).should be_true
    val.all? {|v| v.should be_is_a(Float)}
  end
end
