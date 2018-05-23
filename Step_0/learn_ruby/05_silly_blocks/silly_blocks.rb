def reverser
  yield.gsub(/\w+/) {|match| match.reverse}
end

def adder(num=1)
  yield + num
end

def repeater(num=0)
  if num > 0
   num.times {yield}
 elsif
   yield
  end
end
