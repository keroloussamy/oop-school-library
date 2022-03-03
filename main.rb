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

def display_people(people)
  people.each do |person|
    puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age:#{person.age}"
  end
end

def create_student(people)
  print 'Age: '
  age = gets.chomp.to_i
  print 'Name: '
  name = gets.chomp
  print 'Has parent permission? [Y/N]: '
  permission_input = gets.chomp
  case permission_input
  when 'Y'
    permission = true
  when 'N'
    permission = false
  end

  people.push(Student.new(nil, age, name: name, parent_permission: permission))
  puts 'Person created successfully.'
end

def create_teacher(people)
  print 'Age: '
  age = gets.chomp.to_i
  print 'Name: '
  name = gets.chomp
  print 'specialization: '
  specialization = gets.chomp

  people.push(Teacher.new(specialization, age, name: name))
  puts 'Person created successfully.'
end

def create_book(books)
  print 'Title: '
  title = gets.chomp
  print 'Author: '
  author = gets.chomp

  books.push(Book.new(title, author))
  puts 'Book created successfully.'
end

def create_rental(books, people, rentals)
  puts 'Select a book  from the following list by number: '
  books.each_with_index do |book, index|
    puts "#{index}) Title: #{book.title}, Author: #{book.author}"
  end
  book_index = gets.chomp.to_i

  puts 'Select a person from the following list by number (Not ID): '
  people.each_with_index do |person, index|
    puts "#{index}) [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age:#{person.age}"
  end
  people_index = gets.chomp.to_i

  print 'Date: '
  date = gets.chomp
  rentals.push(Rental.new(date, people[people_index], books[book_index]))
  puts 'Rental created successfully.'
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
