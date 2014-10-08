def super_print string, options={}
  string.upcase! if options[:upcase]
  string.reverse! if options[:reverse]
  (options[:times] || 1).times do
    puts string
  end
end

super_print("Hello")                                    #=> "Hello"
puts
super_print("Hello", :times => 3)                       #=> "Hello" 3x
puts
super_print("Hello", :upcase => true)                   #=> "HELLO"
puts
super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"

options = {}
super_print("hello", options)
p options