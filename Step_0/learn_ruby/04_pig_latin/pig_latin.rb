def translate(str)
  str.gsub(/\w+/) { |match| translate_word(match) }
end

def translate_word(word)
   if word[/^[aeiou]+/].nil?
     chars = word[/^[^aeiou]+/]
     word.gsub!(/^[^aeiou]+/, "")
     if chars[chars.length - 1] == "q" && word[0] == "u"
       chars += "u"
       word.gsub!(/^[u]/, "")
     end
     word += chars + "ay"
   else
     word += "ay"
   end
end
