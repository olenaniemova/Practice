def add(arg1, arg2)
  arg1 + arg2
end

def subtract(arg1, arg2)
  arg1 - arg2
end

def sum(arg)
  arg.empty? ? 0 : arg.reduce(:+)
end

def multiply(arg)
  mul = 1
  arg.inject { |mul, n| mul *= n }
end

def power(arg1, arg2)
  arg1 ** arg2
end

def factorial(arg)
  factor = 1
  if arg > 0
    factor = (1..arg).inject { |factor, i| factor *= i }
  end
  factor
end
