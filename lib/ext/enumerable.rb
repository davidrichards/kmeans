module Enumerable
  def map_with_index(&block)
    val = []
    self.each_with_index { |e, i| val << yield(e, i) }
    val
  end
  
  def map_with_index!(&block)
    self.each_with_index do |e, i|
      val = yield(e, i)
      self[i] = val
    end
  end
  
  # Expects an array of scalars
  def scale_with(ary)
    val = []
    self.map_with_index { |e, i| val << e * ary[i] }
    val
  end
  
  def scale_with!(ary)
    self.map_with_index! { |e, i| e * ary[i] }
  end
  
  def sum
    val = any? {|e| e.is_a?(Float)} ? 0.0 : 0
    self.inject(val) {|s, e| s += e}
  end

  def average
    sum/size
  end
  alias :mean :average
  alias :avg :average

  # Returns the position (or first position) of the minimal value.  So, 
  # [3,2,1,4,5,0].min_position is 5
  def min_position
    mp = [nil, nil]
    each_with_index do |e, i|
      mp = e, i unless mp.first
      mp = e, i if e < mp.first
    end
    mp.last
  end
  
  def max_position
    mp = [nil, nil]
    each_with_index do |e, i|
      mp = e, i unless mp.first
      mp = e, i if e > mp.first
    end
    mp.last
  end
  
end
