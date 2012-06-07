require 'spec_helper'

describe TfPoint do 
  it 'must initialize success' do
    tf = TfPoint.new(4, 3, 2, 1)
    tf.numbers.should eq([4, 3, 2, 1])
  end

  it "should calculate what i given" do 
    TfPoint.calculate(6, 2, 0).should eq(8)
    TfPoint.calculate(6, 2, 1).should eq(4)
    TfPoint.calculate(6, 2, 2).should eq(12)
    TfPoint.calculate(6, 2, 3).should eq(3)
  end

  it "should calculate success" do 
    tf = TfPoint.new(4, 3, 2, 1)
#     tf = TfPoint.new(6, 6, 6, 6)
    result = tf.get_result
    puts result
    result.should_not be_nil
  end

  it "should cut array like cut_array([1, 1], [1]) = [1]" do 
    tf = TfPoint.new(1, 2, 3, 4)
    tf.cut_array([1, 12, 1, 1], [1, 12, 1]).should eq([1])
  end
end

