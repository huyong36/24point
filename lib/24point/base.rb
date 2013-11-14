require "24point/calculate"
require "24point/string"
require "24point/exception"
class TfPointClass
  include TfPoint::Calculate
  attr_accessor :given_numbers, :number, :expression, :count_of_number, :all_expression
  
  NUMBER_TO_CAL = 24
  
  
  def initialize(*args)
    args.flatten!
    raise TfPoint::Exception.new("Sorry, Given arguments should be numbers.") if args.any?{|arg| !arg.is_a? Fixnum }
    @count_of_number = args.length
    @given_numbers = args
    @all_expression = []
  end
  
  def result
    return all_expression if all_expression != []
    given_numbers.permutation.to_a.uniq.each do |given_number|
      @number = given_number
      @expression = given_number.collect{|number| number.to_s}
      calculate(count_of_number)
    end
    all_expression.uniq!
    return all_expression
  end
  

  
private    
  
  # deprecated
  def optimize_expression(exp)
    return exp unless exp.expression?
    # step 1: remove ()
    exp = remove_bracket(exp[1..-2])
    exp
  end
    
  def calculate(n)
    # return number[0] ==  NUMBER_TO_CAL if n == 1
    all_expression << expression[0] if n == 1 && number[0] ==  NUMBER_TO_CAL
    
    (0...n).each do|i|
      ((i+1)...n).each do |j|
        a, b = number[i], number[j]
        number[j] = number[n - 1]
        expa, expb = expression[i], expression[j]
        expression[j] = expression[n - 1]
        #+  
        expression[i], number[i] = plus_operation(expa, expb, n, a, b)
        calculate(n - 1)
        #-
        expression[i], number[i] = sub_operation(expa, expb, n, a, b)
        calculate(n - 1)
        
        #*
        expression[i], number[i] = multi_operation(expa, expb, a, b)
        calculate(n - 1)
        
        #/
        if b != 0  && a % b == 0
          expression[i], number[i] = devision_operation(expa, expb, a, b)
          calculate(n - 1)
        end
        
        if a != 0 && b % a == 0
          expression[i], number[i] = devision_operation(expb, expa, b, a)
          calculate(n - 1)
        end
        
        number[i], number[j] = a, b
        expression[i], expression[j] = expa.to_s, expb.to_s
      end
    end
    
    return false
    
  end
  
  
  
  #TODO  乘法和除法可以在计算时就不加(),但加减仍需要优化，例如：(1+(3+2))
  def remove_bracket(exp)
    reg = '((?<expression>\(?(\d*)[\+\-\*\/](\d*|\g<expression>)\)?)|\d*)'
      # 乘法，统一排序，前大后小 ex: (3*3)+(3*5)=> 3*3+5*3
    if /(?<all_exp>\((?<left_number>((?<expression_left>\(?(\d*)[\+\-\*\/](\d*|\g<expression_left>)\)?)|\d*))\*(?<right_number>((?<expression_right>\(?(\d*)[\+\-\*\/](\d*|\g<expression_right>)\)?)|\d*))\))/ =~ exp
      left_number, right_number = right_number, left_number if left_number.is_num? && right_number.is_num? && left_number.to_i < right_number.to_i
      s_exp = "#{left_number}*#{right_number}"
      remove_bracket(exp.gsub!(all_exp, s_exp))
      #除法: 去除括号
    elsif /(?<all_exp>\((?<s_exp>((?<expression_left>\(?(\d*)[\+\-\*\/](\d*|\g<expression_left>)\)?)|\d*)\/((?<expression_right>\(?(\d*)[\+\-\*\/](\d*|\g<expression_right>)\)?)|\d*))\))/ =~ exp
      remove_bracket(exp.gsub(all_exp, s_exp))
    else
      return exp
    end
  end
    
    
    
end