Integer.class_eval do

  def in_words
    Numbers.to_text(self)
  end

end

module Numbers
  def Numbers.to_text(int)
    if int>=0 && int<100
      Numbers.various1(int)
    elsif int>=100 && int <1000
      Numbers.hundred(int)
    elsif int>=1000 && int <1000000
      Numbers.thousand(int)
    elsif int>=1000000 && int <10**9
      Numbers.million(int)
    elsif int>=10**9 && int <10**12
      Numbers.billion(int)
    elsif int>=10*12
      Numbers.trillion(int)
    end
  end

  def Numbers.numbers(int)
    result = case
    when int == 0
      "zero"
    when int == 1
      "one"
    when int == 2
      "two"
    when int == 3
      "three"
    when int == 4
      "four"
    when int == 5
      "five"
    when int == 6
      "six"
    when int == 7
      "seven"
    when int == 8
      "eight"
    when int == 9
      "nine"
    end
    result
  end

  def Numbers.teens(int)
    second_num = int % 10
    if second_num == 0
      result = "ten"
    elsif second_num == 1
      result = "eleven"
    elsif second_num == 2
      result = "twelve"
    else
      if  second_num == 3
        result = "thir"
      elsif second_num == 5
        result = "fif"
      elsif second_num == 8
        result = "eigh"
      else result = Numbers.numbers(second_num)
      end
    result += "teen"
    end
  end

  def Numbers.ten(int)
    first_num = int / 10
    if first_num == 2
      result = "twen"
    elsif  first_num == 3
      result = "thir"
    elsif  first_num == 4
      result = "for"
    elsif first_num == 5
      result = "fif"
    elsif first_num == 8
      result = "eigh"
    else
      result = Numbers.numbers(first_num)
    end
    result += "ty"
  end

  def Numbers.various1(int) #0-99
    if (0..19).include?(int)
      if (0..9).include?(int)
        result = Numbers.numbers(int)
      elsif (10..19).include?(int)
        result = Numbers.teens(int)
      end
    elsif int >= 20
      second_num = int % 10
      result = Numbers.ten(int)
      result += " #{Numbers.numbers(second_num)}" if second_num != 0
    end
    result
  end

  def Numbers.addition(title, first, others)
    result = "#{Numbers.to_text(first)} #{title}"
    result += " #{Numbers.to_text(others)}" if others != 0
    result
  end

  def Numbers.hundred(int)
    first_num = int/100
    others_num = int - first_num*100
    Numbers.addition("hundred", first_num, others_num)
  end

  def Numbers.thousand(int)
    thousands = int/1000
    hundreds = int - thousands*1000
    Numbers.addition("thousand", thousands, hundreds)
  end

  def Numbers.million(int)
    millions = int/10**6
    thousands = int - millions*10**6
    Numbers.addition("million", millions, thousands)
  end

  def Numbers.billion(int)
    billions = int/10**9
    others = int - billions*10**9
    Numbers.addition("billion", billions, others)
  end

  def Numbers.trillion(int)
    trillions = int/10**12
    others = int - trillions*10**12
    Numbers.addition("trillion", trillions, others)
  end
end
