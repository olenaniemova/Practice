class Dictionary
 attr_accessor :entries

 def initialize
   @entries = Hash.new
 end

  def add(args)
    if args.class == String
      @entries[args] = nil
    else
      @entries.merge!(args)
    end
  end

  def keywords
    @entries.keys.sort
  end

  def include?(arg)
    @entries.has_key?(arg)
  end

  def find(arg)
    @entries.select { |key,value| key[/^#{arg}/] }
  end

  def printable
    str = ""
    keywords.each do |key|
      str += %Q{\n[#{key}] "#{@entries[key]}"}
    end
    str.slice!(0,1)
    str
  end

end
