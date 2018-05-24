Array.class_eval do
  attr_accessor :sum

  def sum
    @sum=0
    if self.size != 0
      self.each do |x|
        @sum += x
      end
    end
    @sum
  end

  def square
    new_array=[]
    if self.size != 0
      self.each do |x|
        new_array.push(x**2)
      end
    end
    new_array
  end

  def square!
    i=0
    new_array = square
    while i<self.size
      self[i] = new_array[i]
      i+=1
    end
    self
  end

end
