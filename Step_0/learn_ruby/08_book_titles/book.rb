class Book
  attr_accessor :title

  def title=(str)
    arr = %w[and over the a an in of]
    str.capitalize!
    @title = str.gsub(/\w+/) { |match| arr.include?(match) ? match : match.capitalize }
  end

end
