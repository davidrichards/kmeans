require File.dirname(__FILE__) + '/spec_helper'

describe "Kmeans" do
  it "should use TeguGears" do
    defined?(TeguGears).should eql('constant')
  end
end
