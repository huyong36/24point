require 'spec_helper'

describe TfPoint do 
  it 'must initialize success' do
    tf = TfPoint::Base.new(4, 3, 2, 1)
    tf.given_numbers.should eq([4, 3, 2, 1])
  end


  it "should calculate success" do 
    tf = TfPoint::Base.new(6, 6, 6, 6)
    result = tf.calculate_all
    puts result
    result.should_not be_nil
  end

end

