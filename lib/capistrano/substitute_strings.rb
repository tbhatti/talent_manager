# we often want to refer to variables which
# are defined in subsequent stage files. This
# let's us use the {{var}} to represent fetch(:var)
# in strings which are only evaluated at runtime.

def sub_strings(input_string)
  puts "creating a String for Symlink: #{input_string}"
  puts "============================="
puts "============================="
puts "============================="
puts "============================="
puts "============================="
  output_string = input_string
  input_string.scan(/{{(\w*)}}/).each do |var|
    output_string.gsub!("{{#{var[0]}}}", fetch(var[0].to_sym))
  end
  puts "============================="
puts "============================="
puts "============================="
puts "============================="
puts "Result Generated: #{output_string}"
  output_string
end
