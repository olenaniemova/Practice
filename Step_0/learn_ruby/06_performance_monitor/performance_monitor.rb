def measure(count=nil)
  average_time = 0
  start = Time.now
  if count == nil
    yield
    average_time = Time.now - start
  else
    count.times do
      yield
    end
    average_time = (Time.now - start)/count
  end
  average_time
end
