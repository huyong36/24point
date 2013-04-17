module TfPoint
  class Base
    attr_accessor :given_numbers
    attr_accessor :number
    
    attr_accessor :expression
    attr_accessor :count_of_number
    attr_accessor :all_expression
    
    NUMBER_TO_CAL = 24
    
    def initialize(*args)
      @count_of_number = args.length
      @given_numbers = args
      @all_expression = []
    end
    
    def calculate_all
      given_numbers.permutation.to_a.each do |given_number|
        @number = given_number
        @expression = given_number.collect{|number| number.to_s}
        all_expression << expression[0] if calculate(count_of_number)
      end
      all_expression.uniq!
      return all_expression
    end
    
    
private    
    def calculate(n)
      return number[0] ==  NUMBER_TO_CAL if n == 1
      
      (0...n).each do|i|
        ((i+1)...n).each do |j|
          a, b = number[i], number[j]
          number[j] = number[n - 1]
         
          expa, expb = expression[i], expression[j]
          expression[j] = expression[n - 1]
          
          #+
          expression[i] = '(' + expa + '+' + expb + ')' 
          number[i] = a + b
          return true if (calculate(n - 1)) 
          #-
          expression[i] = '(' + expa + '-' + expb + ')' 
          number[i] = a - b
          return true if (calculate(n - 1)) 
          
          #*
          expression[i] = '(' + expa + '*' + expb + ')'; 
          number[i] = a * b; 
          return true if (calculate(n - 1)) 
          
          #/
          if b != 0
            expression[i] = '(' + expa + '/' + expb + ')'; 
            number[i] = a / b; 
            return true if (calculate(n - 1)) 
          end
          
          if a != 0
            expression[i] = '(' + expb + '/' + expa + ')'; 
            number[i] = b / a; 
            return true if (calculate(n - 1)) 
          end
          
          number[i] = a
          number[j] = b
          expression[i] = expa.to_s
          expression[j] = expb.to_s
          
        end
      end
      
      return false
      
    end
  end
end