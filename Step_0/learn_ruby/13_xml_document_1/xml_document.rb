class XmlDocument
  attr_accessor :indents

 def initialize(ident = false)
   @indents = ident
 end

 ## спосіб 1:  через білдер
  def hello(args=nil)
    value = nil
    if block_given?
      value = yield
    end
    TagBuilder.build do |builder|
      builder.set_name('hello')
      builder.set_atr(args)
      builder.set_block(value)
      builder.set_count(0)
      builder.set_ident(@indents)
    end
  end

  def goodbye(args=nil)
    value = nil
    if block_given?
      value = yield
    end
    TagBuilder.build do |builder|
      builder.set_name('goodbye')
      builder.set_atr(args)
      builder.set_block(value)
      builder.set_count(1)
      builder.set_ident(@indents)
    end
  end

  def come_back(args=nil)
    value = nil
    if block_given?
      value = yield
    end
    TagBuilder.build do |builder|
      builder.set_name('come_back')
      builder.set_atr(args)
      builder.set_block(value)
      builder.set_count(2)
      builder.set_ident(@indents)
    end
  end

  def ok_fine(args=nil)
    value = nil
    if block_given?
      value = yield
    end
    TagBuilder.build do |builder|
      builder.set_name('ok_fine')
      builder.set_atr(args)
      builder.set_block(value)
      builder.set_count(3)
      builder.set_ident(@indents)
    end
  end

  def send(name)
    value = nil
    if block_given?
      value = yield
    end
    TagBuilder.build do |builder|
      builder.set_name(name)
      builder.set_atr(nil)
      builder.set_block(value)
      builder.set_count(0)
      builder.set_ident(@indents)
    end
  end




#####################
##### спосіб 2: через методи
def send1(tag_name)
  str = ""
  if tag_name != nil
    str = "<#{tag_name}/>"
  end
  str
end

  def create_tag1(name, atr=nil, block=nil, count=0)
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

  def hello1(atr=nil)
    value = nil
    if block_given?
      value = yield
    end
    #puts "helloo #{value}"
    create_tag1("hello", atr, value)
  end

  def goodbye1(atr=nil)
    value = nil
    if block_given?
      value = yield
    end
    create_tag1("goodbye", atr, value, 1)
  end

  def come_back1(atr=nil)
    value = nil
    if block_given?
      value = yield
    end
    create_tag1("come_back", atr, value,2)
  end

  def ok_fine1(atr=nil)
    value = nil
    if block_given?
      value = yield
    end
    create_tag1("ok_fine", atr, value,3)
  end
#####################
end

class Tag
  attr_accessor :name, :atr, :block, :count, :ident
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
  def set_ident(tag_ident)
    @tag.ident = tag_ident
  end

  def get_tag
    str = ""
    if @tag.atr == nil
      if @tag.block != nil
        str = "<#{@tag.name}>#{@tag.block}</#{@tag.name}>"
        str = "#{"  "*@tag.count}<#{@tag.name}>\n#{@tag.block}#{"  "*@tag.count}</#{@tag.name}>\n" if @tag.ident
      else
        str = "<#{@tag.name}/>"
        str = "#{"  "*@tag.count}<#{@tag.name}/>\n" if @tag.ident
      end
    else
      @tag.atr.each do |key,value|
        str = "<#{@tag.name} #{key}='#{value}'/>"
        str = "#{"  "*@tag.count}<#{@tag.name} #{key}='#{value}'/>\n" if @tag.ident
      end
    end
    str
  end

  def tag
    @tag.get_tag
  end
end
