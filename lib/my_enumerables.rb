module Enumerable
  # Your code goes here
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    for el in self do
      yield el,index
      index+= 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    results = []

    my_each{|elem| results.push(elem) if yield elem}

    results
  end

  def my_all?
    return to_enum(:my_all) unless block_given?

    my_each{|elem| return false unless yield elem}

    true
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    my_each{|elem| return false if yield elem}

    true
  end

  def my_count
    return self.length unless block_given?

    c = 0
    my_each{|elem| c+=1 if yield elem}
    c
  end

  def my_map(symbol = nil)
    return to_enum(:my_map) if !block_given? && symbol.nil?

    exp = block_given? ? ->(elem) {yield elem} : ->(elem) {symbol.call(elem)}
    res = []
    my_each{|elem| res << exp.call(elem)}

    res

  end

  def my_inject(accumulator=nil, &block)
    self.class == Range ? arr = self.to_a : arr = self
    if block_given?
      if accumulator.nil?
        accumulator = self.first
        for i in 0..arr.size-2
          accumulator = block.call(accumulator, arr[i+1])
        end
      elsif accumulator
        for i in 0..arr.size-1
          accumulator = block.call(accumulator, arr[i])
        end
      end
    end
    accumulator
  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?

    for el in self do
      yield el
    end
    self
  end

  
end
