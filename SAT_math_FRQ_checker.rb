# These methods work to check if a student's answer to a Digital SAT free-response question is valid,
# and then coverts that answer to latex

# This takes the student's answer and rejects it if either contains invalid keystrokes, or is too long 
# A valid answer can only contain the digits 0 through 9, minus "-", decimal ".", and "/" for fractions
# A valid answer is either 5 characters long, or 6 characters long if it starts with a negative sign
def check_allowed_keystrokes(answer)
  if answer.match(/[^0-9\.\-\/]/)
    return "invalid"
  elsif answer.start_with?("-")
    return answer.length <= 6 ? "valid" : "invalid"
  else
    return answer.length <= 5 ? "valid" : "invalid"
  end
end

# Next, the student's string must be checked to see if it contains the right arrangement of characters.
# The rules are as follows:
# 1. the minus sign may only come first
# 2. the decimal point may only be used once
# 3. the fraction bar may only be used once
# 4. the fraction bar may not come first or last
# 5. there must be at least one digit [0-9] on either side of the fraction sign
def check_answer_regex(answer)
  regex = /\A-?(?:(?:\d+(\.\d+)?)\/\d+(\.\d+)?|(?:\d+(\.\d+)?))\z/
  if regex.match?(answer) && answer.count('-') <= 1 && answer.count('/') <= 1
    convert_answer_to_latex(answer)
  else
    "❗You've entered a decimal, slash, or minus sign in the wrong place"
  end
end

# this works like the above method but doesn't use regex (lame!)
# def check_answer_string(answer)
#   invalid_message = "❗You've entered a decimal, slash, or minus sign in the wrong place"
#   if answer.include?('-') && answer[0] != '-'
#     return invalid_message
#   end

#   if answer.end_with?('.') || answer.count('.') > 1
#     return invalid_message
#   end

#   if answer.include?('/')
#     return invalid_message if answer.count('/') > 1
#     return invalid_message if answer.start_with?('/') || answer.end_with?('/')
#     parts = answer.split('/')
#     return invalid_message if parts.any? { |part| part.empty? }
#   end
# end

def convert_answer_to_latex(answer)
  if answer.include?('/')
    parts = answer.split('/')
    parts[0][0] == "-" ? "$-\\cfrac{#{parts[0]}}{#{parts[1]}}$" : "$\\cfrac{#{parts[0]}}{#{parts[1]}}$"
  else
    answer = "$#{answer}$"
  end
end

puts "Please input your answer:"
answer = gets.chomp
puts check_allowed_keystrokes(answer)
puts check_answer_regex(answer)
