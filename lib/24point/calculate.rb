module TfPoint
  module Calculate
  	##+  排序，大的在前，小的在后，如果是最后一次(n=2),不加括号
    def plus_operation(expa, expb, n, numa, numb)
      return "", 0 if !numa.is_a?(Fixnum) || !numb.is_a?(Fixnum)
    	expa, expb = expb, expa if expa.is_num? && expb.is_num? && expa < expb
    	exp = (n == 2) ? expa + '+' + expb : '(' + expa + '+' + expb + ')'
      return exp, (numa + numb)
    end

    ##-
    def sub_operation(expa, expb, n, numa, numb)
      return "", 0 if !numa.is_a?(Fixnum) || !numb.is_a?(Fixnum)
    	exp = (n == 2) ? expa + '-' + expb : '(' + expa + '-' + expb + ')'
      return exp, (numa - numb)
    end

    ##*
    def multi_operation(expa, expb, numa, numb)
      return "", 0 if !numa.is_a?(Fixnum) || !numb.is_a?(Fixnum)
    	exp = (expa > expb) ? expa + '*' + expb : expb + '*' + expa
      return exp, (numa * numb)
    end

    #/
    def devision_operation(expa, expb, numa, numb)
      return "", 0 if !numa.is_a?(Fixnum) || !numb.is_a?(Fixnum)
      exp = expa + '/' + expb
      return exp, (numa / numb)
    end

  end
end
