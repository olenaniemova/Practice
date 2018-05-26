def measure(count = nil)
  count = 1 if count.nil?
  start = Time.now
  count.times do
    yield
  end
  (Time.now - start) / count
end
