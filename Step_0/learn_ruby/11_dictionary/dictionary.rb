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

    #args.each do |key,value|
    #  @entries["#{key}"] = (value.nil? ? nil : value)
    #end
    end
  end

  def keywords
    @entries.keys.sort
  end

  def include?(arg)
    @entries.has_key?(arg)
  end

  def find(arg)
    #new_hash = Hash.new
    #unless @entries.empty?
    #  @entries.each do |key, value|
    #    if key[/^#{arg}/] != nil
    #      new_hash[key] = value
    #    end
    #  end
    #end

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
