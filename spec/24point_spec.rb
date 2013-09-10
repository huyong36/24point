require 'spec_helper'

describe TfPointClass do 
  it 'initialize should  success' do
    tf = TfPointClass.new(4, 3, 2, 1)
    tf.given_numbers.should eq([4, 3, 2, 1])
  end

  it 'string initialize should raise exception' do 
    expect{TfPointClass.new("a", 1, 2, 3)}.to raise_error
  end


  it "four numbers should calculate success" do 
    tf = TfPointClass.new(6, 6, 6, 6)
    result = tf.result
    result.should_not be_nil
  end

  it "little numbers should have no result" do 
    tf = TfPointClass.new(2, 2, 2, 2)
    result = tf.result
    result.should eq([])
  end

  it "random numbers calculate" do
    numbers = (1..13).to_a.sample(4)
    puts numbers
    tf = TfPointClass.new(numbers)
    result = tf.result
    puts result
  end

  


end

