class String
  
  # match as ((3+5)*6)/2) (3*8)+(1-1)   => true  
  def expression?
    !(self =~ /(?<expression>\((?<left>(\g<expression>|\d*))(?<operate>[\+\-\*\/])(?<right>(\g<expression>|\d*))\))/).nil?
  end

  def is_num?
  	!(self =~ /^\d*$/).nil?
  end
  
end