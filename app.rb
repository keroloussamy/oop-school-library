require './student'
require './teacher'
require './book'
require './rental'
require './data_storage'

class App
  attr_accessor :books, :people, :rentals

  include DataStorage

  def initialize
    @books = read_books
    @people = read_people
    @rentals = read_rentals(@books, @people)
  end

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

  def display_books()
    books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def display_people()
    people.each do |person|
      puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age:#{person.age}"
    end
  end

  def create_student()
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

  def create_teacher()
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'specialization: '
    specialization = gets.chomp

    people.push(Teacher.new(specialization, age, name: name))
    puts 'Person created successfully.'
  end

  def create_book()
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    books.push(Book.new(title, author))
    puts 'Book created successfully.'
  end

  def create_rental()
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

  def display_rental_by_person_id()
    print 'Person ID: '
    person_id = gets.chomp.to_i
    rentals.each do |rent|
      puts "Date: #{rent.date}, Book: #{rent.book.title} by #{rent.book.author}." if rent.person.id == person_id
    end
  end

  def student_or_teacher()
    puts 'Do you want to create a student (1) or a teacher (2)? [Input a number]: '
    student_or_teacher = gets.chomp.to_i
    case student_or_teacher
    when 1
      create_student()
    when 2
      create_teacher()
    end
  end

  def switch_options(option)
    case option
    when 1
      display_books
    when 2
      display_people
    when 3
      student_or_teacher
    when 4
      create_book
    when 5
      create_rental
    when 6
      display_rental_by_person_id
    else
      puts 'Not an option'
    end
  end

  def save_data()
    save_books(@books)
    save_people(@people)
    save_rentals(@rentals)
  end

  def switch_case
    loop do
      display_list
      option = gets.chomp.to_i
      break if option == 7

      switch_options(option)
    end
    save_data
  end
end
