require './student'
require './teacher'
require './book'
require './rental'

def display_list
  puts "
    Please choose an option by entering a number:
    1- List all books.
    2- List all people.
    3- Create a person (teacher or student, not a plain Person).
    4- Create a book.
    5- Create a rental.
    6- List all rentals for a given person id.
    7- Exit"
end

def display_books(books)
  books.each do |book|
    puts "Title: #{book.title}, Author: #{book.author}"
  end
end

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
