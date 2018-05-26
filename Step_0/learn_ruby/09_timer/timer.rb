class Timer
  attr_accessor :seconds, :minutes, :hours

  def initialize
    @seconds = 0
  end

###### method 1
  def seconds1=(num)
    @hours = num / 3600
    ost = num - @hours * 3600
    @minutes = ost / 60
    ost -= @minutes * 60
    @seconds = ost
  end
  def time_string1
    time = Time.new(2018, 05, 22, @hours, @minutes, @seconds, "+00:00")
    time.strftime("%H:%M:%S")
  end

###### method 2
  def seconds=(num)
    @seconds = num
  end

  def time_string
    timer = Time.at(@seconds)
    timer.localtime("+00:00")
    timer.strftime("%H:%M:%S")
  end
end
