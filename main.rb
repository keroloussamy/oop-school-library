
def switch_case(books, people, rentals)
  loop do
    display_list
    option = gets.chomp.to_i
    break if option == 7
    switch_options(option, books, people, rentals)
  end
end

def main
  books = []
  people = []
  rentals = []
  puts 'Welcome to School library App!'
  switch_case(books, people, rentals)
end

main
