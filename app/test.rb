require 'sicuro'
s = Sicuro.eval('puts "hi!"') 
p s.code # returns "puts \"hi!\""
p s.stdout # returns "hi!\n"
p s.stderr # returns "" 
p s.to_s # returns "hi!\n", because it uses #stdout
