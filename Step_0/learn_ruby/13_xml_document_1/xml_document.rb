class XmlDocument
  attr_accessor :indents

 def initialize(ident = false)
   @indents = ident
 end

 ## спосіб 1:  через білдер
  def BuildTag(name, args, value, count)
    TagBuilder.build do |builder|
      builder.set_name(name)
      builder.set_atr(args)
      builder.set_block(value)
      builder.set_count(count)
      builder.set_ident(@indents)
    end
  end

  def method_missing(m, args = nil, &block)
    value = block_given? ? yield : nil
    BuildTag(m, args, value, 0)
  end

  def goodbye(args = nil)
    value = block_given? ? yield : nil
    BuildTag('goodbye', args, value, 1)
  end

  def come_back(args = nil)
    value = block_given? ? yield : nil
    BuildTag('come_back', args, value, 2)
  end

  def ok_fine(args = nil)
    value = block_given? ? yield : nil
    BuildTag('ok_fine', args, value, 3)
  end

#####################
##### спосіб 2: через методи
def send1(tag_name)
  tag_name ? "<#{tag_name}/>" : ""
end

  def create_tag1(name, atr = nil, block = nil, count = 0)
    if atr.nil?
      if block.nil?
        str = @indents ? "#{"  " * count}<#{name}/>\n" : "<#{name}/>"
      else
        str = @indents ? "#{"  " * count}<#{name}>\n#{block}#{"  " * count}</#{name}>\n" : "<#{name}>#{block}</#{name}>"
      end
    else
      key = atr.keys[0]
      value = atr[key]
      str = @indents ? "#{"  " * count}<#{name} #{key}='#{value}'/>\n" : "<#{name} #{key}='#{value}'/>"
    end
    str
  end

  def hello1(atr = nil)
    if block_given?
      value = yield
    end
    create_tag1("hello", atr, value)
  end

  def goodbye1(atr = nil)
    if block_given?
      value = yield
    end
    create_tag1("goodbye", atr, value, 1)
  end

  def come_back1(atr = nil)
    if block_given?
      value = yield
    end
    create_tag1("come_back", atr, value, 2)
  end

  def ok_fine1(atr = nil)
    if block_given?
      value = yield
    end
    create_tag1("ok_fine", atr, value, 3)
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
    if @tag.atr.nil?
      if @tag.block.nil?
        str = @tag.ident ? "#{"  " * @tag.count}<#{@tag.name}/>\n" : "<#{@tag.name}/>"
      else
        str = @tag.ident ? "#{"  " * @tag.count}<#{@tag.name}>\n#{@tag.block}#{"  " * @tag.count}</#{@tag.name}>\n" : "<#{@tag.name}>#{@tag.block}</#{@tag.name}>"
      end
    else
      key = @tag.atr.keys[0]
      value = @tag.atr[key]
      str = @tag.ident ? "#{"  " * @tag.count}<#{@tag.name} #{key}='#{value}'/>\n" : "<#{@tag.name} #{key}='#{value}'/>"
    end
    str
  end

  def tag
    @tag.get_tag
  end
end
