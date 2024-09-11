# These methods check if a student's answer to a Digital SAT free-response math question is valid,
# and then coverts that answer to latex.

# This takes the student's answer and rejects it if it either contains invalid keystrokes or is too long. 
# A valid answer may only contain the digits 0 through 9, minus "-", decimal ".", and "/" for fractions.
# A valid answer is either 5 characters long or 6 characters long if it starts with a negative sign.
def validate_keystrokes(answer)
  return "invalid" if answer.match(/[^0-9\.\-\/]/)

  max_length = answer.start_with?("-") ? 6 : 5
  if answer.length <= max_length
    puts "The answer is valid"
    validate_arrangement(answer)
  else
    puts "The answer is invalid"
  end
end

# Next, the student's string must be checked to see if it contains the right arrangement of characters.
# The rules are as follows:
# 1. the minus sign may only come first
# 2. the decimal point may only be used once
# 3. the fraction bar may only be used once
# 4. the fraction bar may not come first
def validate_arrangement(answer)
  regex = /\A-?(\d*(\.\d*)?(\/\d*)?)?\z/
  if answer.match?(regex) && answer.count('-') <= 1 && answer.count('/') <= 1 && !answer.start_with?('/')
    convert_to_latex(answer)
  else
    "❗ You've entered a decimal, slash, or minus sign in the wrong place."
  end
end

# Finally, convert the string to latex formatting to make it pretty.
def convert_to_latex(answer)
  if answer.include?('/')
    parts = answer.split('/')
    parts[0][0] == "-" ? "$-\\cfrac{#{parts[0]}}{#{parts[1]}}$" : "$\\cfrac{#{parts[0]}}{#{parts[1]}}$"
  else
    answer = "$#{answer}$"
  end
end

## TESTING ##

answers = ["E", "-", "-2", "2", "-3/4", "3.", "-.3", "222222", "-22222", ".3", "0.33333", "3.14", "3.14.5", "3/2", "3/"]

# for each answer in the array, check if it is valid and print the latex version of the answer
answers.each do |answer|
  puts "checking answer #{answers.index(answer) + 1}: #{answer}"
  puts validate_keystrokes(answer)
  puts "_________________________"
end
