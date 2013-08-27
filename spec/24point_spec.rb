require 'spec_helper'

describe TfPoint do 
  it 'must initialize success' do
    tf = TfPoint::Base.new(4, 3, 2, 1)
    tf.given_numbers.should eq([4, 3, 2, 1])
  end


  it "should calculate success" do 
    tf = TfPoint::Base.new(6, 6, 6, 6)
    result = tf.calculate_all
    result.should_not be_nil
  end

  it "should calculate success" do
    numbers = (1..13).to_a.sample(4)
    puts numbers
    tf = TfPoint::Base.new(numbers)
    result = tf.calculate_all
    puts result
  end



end

