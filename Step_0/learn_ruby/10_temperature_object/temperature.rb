class Temperature
  attr_accessor :f, :c

    def initialize(args)
      args.each do |key,value|
        instance_variable_set("@#{key}",value) unless value.nil?
      end
    end

    def in_celsius
      @c == nil ? @c = (@f - 32)*(5.0/9.0) : @c
      @c.round(1)
    end

    def in_fahrenheit
      @f == nil ? @f = @c*(9.0/5.0)+32 : @f
      @f.round(1)
    end

    def self.from_celsius(arg)
      Temperature.new(:c=>arg)
    end

    def self.from_fahrenheit(arg)
      Temperature.new(:f=>arg)
    end

end

class Celsius < Temperature
  def initialize(arg)
    @c = arg
  end
end

class Fahrenheit < Temperature
  def initialize(arg)
    @f = arg
  end
end