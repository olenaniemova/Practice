class XmlDocument
  attr_accessor :indents

 def initialize(ident = false)
   @indents = ident
 end

 ##--------------
  def hello1(args=nil)
    value = nil
    if block_given?
      value = yield
    end
    TagBuilder.build do |builder|
      builder.set_name('hello')
      builder.set_atr(args)
      builder.set_block(value)
    end
  end




#####################
def send(tag_name)
  str = ""
  if tag_name != nil
    str = "<#{tag_name}/>"
  end
  str
end

  def create_tag(name, atr=nil, block=nil, count=0)
    str = ""
    if atr == nil
      if block != nil
        str = "<#{name}>#{block}</#{name}>"
        str = "#{"  "*count}<#{name}>\n#{block}#{"  "*count}</#{name}>\n" if @indents
      else
        str = "<#{name}/>"
        str = "#{"  "*count}<#{name}/>\n" if @indents
      end
    else
      atr.each do |key,value|
        str = "<#{name} #{key}='#{value}'/>"
        str = "#{"  "*count}<#{name} #{key}='#{value}'/>\n" if @indents
      end
    end
    str
  end

  def hello(atr=nil)
    value = nil
    if block_given?
      value = yield
    end
    #puts "helloo #{value}"
    create_tag("hello", atr, value)
  end

  def goodbye(atr=nil)
    value = nil
    if block_given?
      value = yield
    end
    create_tag("goodbye", atr, value, 1)
  end

  def come_back(atr=nil)
    value = nil
    if block_given?
      value = yield
    end
    create_tag("come_back", atr, value,2)
  end

  def ok_fine(atr=nil)
    value = nil
    if block_given?
      value = yield
    end
    create_tag("ok_fine", atr, value,3)
  end
#####################
end

class Tag
  attr_accessor :name, :atr, :block, :count
end

class TagBuilder
  def self.build
    builder = new
    yield(builder)
    builder.get_tag
  end
  def initialize
    @tag = Tag.new
  end
  def set_name(tag_name)
    @tag.name = tag_name
  end
  def set_atr(tag_atr)
    @tag.atr = tag_atr
  end
  def set_block(tag_block)
    @tag.block = tag_block
  end
  def set_count(tag_count)
    @tag.count = tag_count
  end

  def get_tag
    str = ""
    if @tag.atr == nil
      if @tag.block != nil
        str = "<#{@tag.name}>#{@tag.block}</#{@tag.name}>"
        str = "#{"  "*@tag.count}<#{@tag.name}>\n#{@tag.block}#{"  "*@tag.count}</#{@tag.name}>\n" if @indents
      else
        str = "<#{@tag.name}/>"
        str = "#{"  "*@tag.count}<#{@tag.name}/>\n" if @indents
      end
    else
      @tag.atr.each do |key,value|
        str = "<#{@tag.name} #{key}='#{value}'/>"
        str = "#{"  "*count}<#{name} #{key}='#{value}'/>\n" if @indents
      end
    end
    str
  end

  def tag
    @tag.get_tag
  end
end


xml1 = XmlDocument.new
#puts xml1.hello1(:name => 'dolly')
puts xml1.hello1 do
  5+1
end
