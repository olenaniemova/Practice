#ftoc
#one degree fahrenheit is 5/9 of one degree celsius
#c = (f-32)*5/9
def ftoc(f_temperature)
  (f_temperature - 32) * (5.0 / 9.0)
end

#ctof
#f = c*9/5 + 32
def ctof(c_temperature)
  c_temperature * (9.0 / 5.0) + 32
end
