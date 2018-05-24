class Dictionary
 attr_accessor :entries

 def initialize
   @entries = Hash.new
 end

  def add(args)
    if args.class == String
      @entries[args] = nil
    else
    args.each do |key,value|
      @entries["#{key}"] = (value.nil? ? nil : value)
      #instance_variable_set("@#{key}",value) unless value.nil?
    end
  end
  end

  def keywords
    @entries.keys.sort
  end

  def include?(arg)
    @entries.has_key?(arg)
  end

  def find(arg)
    new_hash = Hash.new
    unless @entries.empty?
      @entries.each do |key, value|
        if key[/^#{arg}/] != nil
          new_hash[key] = value
        end
      end
    end
    new_hash
  end

  def printable
    str = ""
    unless @entries.empty?
      keys = keywords
      keys.each do |key|
        str += %Q{\n[#{key}] "#{@entries[key]}"}
      end
    end
    str.slice!(0,1)
    str
  end

end
