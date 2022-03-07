require_relative 'app'

def main
  puts 'Welcome to School library App!'
  logic = App.new
  logic.switch_case
end

main
