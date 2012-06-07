# coding: utf-8
#主要算法是:
#取给定的几个数字中的任意两个分别进行加减乘除运算,得出S1，再将S1与剩下的数字分别进行计算最终得到结果。
class TfPoint

  RESULT = 24
  MATH_SYMBOL = ["+","-", "*", "/"]
  RANGE = 1..13

  attr_accessor :numbers, :relations, :results

  def initialize(*args)
    if args.all?{|arg| arg.class == Fixnum && RANGE.cover?(arg)}
      @numbers = args
      @results = []
      @relations = {}
    else
      e = Exception.new("The number you given is invalid!")
      raise e
    end
  end
#根据数组取出所有的两两组合
  def circle_calculate(numbers)
    return numbers.permutation(2).to_a 
  end

  # 剪掉一个数组中的某一组数字,与array的减法不同,减法会剪掉多个相同的元素。
  # ex: cut_arry([1, 1, 1], [1]) => [1, 1]
  def cut_array(arr = [], cut_arr = [])
    result = arr
    cut_arr.each do |element|
      result = cut_array_with_element(result, element)
    end
    return result
  end

  def cut_array_with_element(arr, cut_element)
    result = []
    arr.each_with_index do |item, index|
      result << item unless arr.include?(cut_element) && index == arr.index(cut_element)
    end
    return result
  end


#计算并获得结果
  def get_result
    circle = start_calculate(@numbers)
    @result = @results.uniq
  end

  #循环算法,result_string为计算的表达式(如:["1+2", 3]),array为剩余的数字数组
#   def start_calculate(array = [], previous_expression = "", previous_result = 0)
  def start_calculate(array = [], result_arr = ["", 0])
    return if array == []
    #如果是还没有开始计算的表达式,则为空表达式
    first_flag = result_arr[0] == ""
#     if previous_expression == ""
    if first_flag
      calculate_arry = circle_calculate(array)
    else
#       calculate_arry = array.collect{|number| [previous_result, number]}
      calculate_arry = array.collect{|number| [result_arr[1], number]}
    end
    calculate_arry.each do |number|
      #如果是第一次计算,则剩下来的数字应该是用总数减掉这两个数字,而如果不是第一次计算,则剩下来的数字是总数－计算的数。
      #剩下来待计算的数字
      leave_array = first_flag ? cut_array(array, number) : cut_array(array, [number.last]) 
#       puts leave_array.join(",")
#       leave_array = previous_expression != "" ? array - [number.last] : array - number
#       previous_expression = previous_expression != "" ? previous_expression.to_s : number.first.to_s
#计算表达式,如果是第一次,则将第一个数字付给它
      previous_expression = first_flag ? number.first.to_s : result_arr[0].to_s 
      TfPoint::MATH_SYMBOL.each_with_index do |symbol, index|
        begin
          result = TfPoint.calculate(number.first.to_i, number.last.to_i, index)
          expression = previous_expression + symbol + number.last.to_s
          if leave_array != [] 
            start_calculate(leave_array, [expression, result])
          elsif result == TfPoint::RESULT
            @results << expression
            return
          end
        rescue Exception => e
          raise e
          break
        end
      end
    end
    
  end
  
  class << self 
    def validate?(number_array = [])
      number_array.all?{|number| number.class == Fixnum }
    end


    def calculate(first = 0, last = 0, method)
      case method.to_i
      when 0
        first + last
      when 1
        first - last
      when 2
        first * last
      when 3
        if first % last != 0
#           raise Exception
        else
          first / last
        end
      end
    end
  end

end

