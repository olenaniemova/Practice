def add(arg1, arg2)
  arg1+arg2
end

def subtract(arg1, arg2)
  arg1-arg2
end

def sum(arg)
  sum =0
  arg.each {|x| sum += x}
  sum
end

def multiply(arg)
  mul = 1
  arg.each {|x| mul *= x}
  mul
end

def power(arg1, arg2)
  arg1**arg2
end

def factorial(arg)
  factor=1
  if arg == 0
    factor=1
  elsif arg != 0 && arg>0
    while arg>0
      factor *= arg
      arg -= 1
    end
  end
  factor
end
