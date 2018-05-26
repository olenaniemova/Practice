def translate(str)
  str.gsub(/\w+/) { |match| translate_word(match) }
end

def translate_word(word)
  chars = word[/^[aeiou]+/]
  if chars != nil
    word += "ay"
  else
    chars = word[/^[^aeiou]+/]
    word.gsub!(/^[^aeiou]+/, "")
    if chars[chars.length-1] == "q" && word[0] == "u"
      chars += "u"
      word.gsub!(/^[u]/, "")
    end
    word += chars + "ay"
  end
  word
end
