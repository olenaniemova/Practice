class RPNCalculator
   attr_accessor :numbers, :value, :token

   def initialize
     @numbers = Array.new
     @value = 0
     @token = Array.new
   end

   def push(atr)
     numbers.push(atr)
   end

   def plus
     raise "calculator is empty" unless @numbers.length >= 2
     @value = @numbers.pop
     @value += @numbers.pop
     @numbers.push(@value)
   end


   def minus
     raise "calculator is empty" unless @numbers.length >= 2
     sub = @numbers.pop
     @value = @numbers.pop - sub
     @numbers.push(@value)
   end

   def divide
     raise "calculator is empty" unless @numbers.length >= 2
     dev = @numbers.pop
     @value = @numbers.pop.to_f / dev
     @numbers.push(@value)
   end

   def times
     raise "calculator is empty" unless @numbers.length >= 2
     dev = @numbers.pop
     @value = @numbers.pop.to_f * dev
     @numbers.push(@value)
   end

   def tokens(str)
     str1 = str.split(" ")
     @token = []
     str1.each do |el|
       if el[/\d+/] != nil
         @token.push(el.to_i)
       elsif el[/\+/] != nil
         @token.push(:+)
       elsif el[/\-/] != nil
         @token.push(:-)
       elsif el[/\*/] != nil
         @token.push(:*)
       elsif el[/\//] != nil
         @token.push(:/)
       end
     end
     @token
   end

   def evaluate(str)
      tok = tokens(str)

      while tok.size>1
        index = 0
        #знайти перше число з кінця
        -1.downto(tok.size*(-1)) do |x|
          if (tok[x].class == Integer || tok[x].class == Float) && (tok[x-1].class == Integer || tok[x-1].class == Float)
            index = x
            break
          end
        end

        #puts "index #{index}"
        #перевірити чи є число перед ним, та якшо є виконати операцію для них
        raise "tokens is empty" if index == 0 || index == -1 || tok[index+1].class != Symbol
        raise "integer" if tok[index-1].class != Integer && tok[index-1].class != Float
        if (index != 0 || index !=-1) && (tok[index-1].class == Integer || tok[index-1].class == Float ) && tok[index+1].class == Symbol
          @numbers=[]
          @numbers.push(tok[index-1])
          @numbers.push(tok[index])
          act(tok[index+1])
            #puts "index #{index}"

          tok[index-1] = @value
          tok[index] = nil
          tok[index+1] = nil
          tok.compact!
          #puts "index #{index}"
        end

        #puts "size: #{tok.size}"
        #puts tok

        #tok
      end
      @value
   end

   def act(sym)
     case sym
     when :+
       self.plus
     when :-
       self.minus
     when :*
       self.times
     when :/
       self.divide
     end
   end

end

c = RPNCalculator.new
c.tokens("1 2 3 * +")
c.token.each {|x| puts "#{x.class} => #{x}"}
puts c.evaluate("1 2 3 * + 4 5 - /")
#-3.downto(-5) {|x| puts x}
puts ""
#puts c.evaluate("4 5 -")
