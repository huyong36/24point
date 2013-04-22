module TfPoint
  class Base
    attr_accessor :given_numbers
    attr_accessor :number
    
    attr_accessor :expression
    attr_accessor :count_of_number
    attr_accessor :all_expression
    
    NUMBER_TO_CAL = 24
    OPERATE = ["+", "-", "*", "/"]
    
    def initialize(*args)
      @count_of_number = args.length
      @given_numbers = args
      @all_expression = []
    end
    
    def calculate_all
      given_numbers.permutation.to_a.uniq.each do |given_number|
        @number = given_number
        @expression = given_number.collect{|number| number.to_s}
        # all_expression << expression[0] if 
        calculate(count_of_number)
      end
      all_expression.uniq!
      return all_expression
    end
    
    def optimize_expression(exp)
      return exp unless exp.expression?
      # step 1: remove ()
      exp = remove_bracket(exp[1..-2])
      exp
    end
    
private    
    
      
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
          expression[i] = '(' + expa + '+' + expb + ')' 
          number[i] = a + b
          calculate(n - 1)
          #-
          expression[i] = '(' + expa + '-' + expb + ')' 
          number[i] = a - b
          calculate(n - 1)
          
          #*
          expression[i] = '(' + expa + '*' + expb + ')'; 
          number[i] = a * b; 
          calculate(n - 1)
          
          #/
          if b != 0
            expression[i] = '(' + expa + '/' + expb + ')'; 
            number[i] = a / b; 
            calculate(n - 1)
          end
          
          if a != 0
            expression[i] = '(' + expb + '/' + expa + ')'; 
            number[i] = b / a; 
            calculate(n - 1)
          end
          
          number[i] = a
          number[j] = b
          expression[i] = expa.to_s
          expression[j] = expb.to_s
          
        end
      end
      
      return false
      
    end
    
    
    
    
        
    def remove_bracket(exp)
        # 乘法，统一排序，前大后小 ex: (3*3)+(3*5)=> 3*3+5*3
      if /(?<all_exp>\((?<left_number>\d*)\*(?<right_number>\d*)\))/ =~ exp
        left_number, right_number = right_number, left_number if left_number.to_i < right_number.to_i
        s_exp = "#{left_number}*#{right_number}"
        remove_bracket(exp.gsub!(all_exp, s_exp))
        #除法: 去除括号
      elsif /(?<all_exp>\((?<s_exp>\d*\/\d*)\))/ =~ exp
        remove_bracket(exp.gsub(all_exp, s_exp))
      # elsif 
      else
        return exp
      end
    end
  end
end