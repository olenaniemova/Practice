def add(arg1, arg2)
  arg1 + arg2
end

def subtract(arg1, arg2)
  arg1 - arg2
end

def sum(arg)
  arg.reduce(0, :+)
end

def multiply(arg)
  arg.inject(1) { |mul, n| mul * n }
end

def power(arg1, arg2)
  arg1**arg2
end

def factorial(arg)
  arg > 0 ? (1..arg).inject(1) { |f, i| f * i } : 1
end
