def echo(str)
  str
end

def shout(str)
  str.upcase
end

def repeat(str, int=2)
  ((str+" ")*int).chop
end

def start_of_word(str, num)
  str[0, num]
end

def first_word(str)
  str.partition(" ").first
end

def titleize(str)
  arr = ['and', 'over', 'the']
  str.capitalize!
  str.gsub(/\w+/) {|match| arr.include?(match) ? match : match.capitalize}
end
