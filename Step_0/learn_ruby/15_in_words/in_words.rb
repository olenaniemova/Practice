Integer.class_eval do
  def in_words
    int = self
    num_name = { 1_000_000_000_000 => 'trillion', 1_000_000_000 => 'billion',
                 1_000_000 => 'million', 1_000 => 'thousand', 100 => 'hundred',
                 90 => 'ninety', 80 => 'eighty', 70 => 'seventy', 60 => 'sixty',
                 50 => 'fifty', 40 => 'forty', 30 => 'thirty', 20 => 'twenty',
                 19 => 'nineteen', 18 => 'eighteen', 17 => 'seventeen', 16 => 'sixteen',
                 15 => 'fifteen', 14 => 'fourteen', 13 => 'thirteen', 12 => 'twelve',
                 11 => 'eleven', 10 => 'ten', 9 => 'nine', 8 => 'eight', 7 => 'seven',
                 6 => 'six', 5 => 'five', 4 => 'four', 3 => 'three', 2 => 'two',
                 1 => 'one' }
    str = ''
    if int.zero?
      return 'zero'
    else
      num_name.each do |num, name|
        if int.zero?
          return str
        elsif int.to_s.length == 1 && (int / num).positive?
          return str + "#{name}"
        elsif int < 100 && (int / num).positive?
          return str + "#{name}" if (int % num).zero?
          return str + "#{name} " + (int % num).in_words
        elsif (int / num).positive?
          return str + (int / num).in_words + " #{name}" if (int % num).zero?
          return str + (int / num).in_words + " #{name} " + (int % num).in_words
        end
      end
    end
  end
end
