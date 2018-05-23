def translate(str)
  str.gsub(/\w+/) {|match| translate_word(match)}
end

def translate_word(word)
  type_first_sym = :vowel
  chars = word[/^[aeiou]+/]
  chars != nil ? type_first_sym = :vowel : type_first_sym = :consonant

  if type_first_sym==:vowel
    word+="ay"
  else
    chars = word[/^[^aeiou]+/]
    word.gsub!(/^[^aeiou]+/, "")
    if chars[chars.length-1] == "q" && word[0]=="u"
      chars += "u"
      word.gsub!(/^[u]+/, "")
    end

    word += chars + "ay"
  end
  word
end
