require './student'
require './teacher'
require './book'
require './rental'
require 'json'

module DataStorage
  def read_books
    file = 'books-data.json'
    data = []
    if File.exist?(file) && File.read(file) != ''
      JSON.parse(File.read(file)).each do |element|
        data.push(Book.new(element['title'], element['author']))
      end
    end
    data
  end

  def save_books(books)
    data = []
    books.each do |book|
      data.push({ title: book.title, author: book.author })
    end
    File.write('books-data.json', JSON.generate(data))
  end

  def read_people
    file = 'people-data.json'
    data = []
    if File.exist?(file) && File.read(file) != ''
      JSON.parse(File.read(file)).each do |element|
        if element['type'] == 'Teacher'
          data.push(Teacher.new(element['specialization'], element['age'].to_i, name: element['name'], id: element['id'].to_i))
        else
          data.push(Student.new(nil, element['age'].to_i, name: element['name'], parent_permission: element['parent_permission'], id: element['id'].to_i))
        end
      end
    end
    data
  end

  def save_people(people)
    data = []
    people.each do |person|
      puts person
      if person.instance_of?(Teacher)
        data.push({ id: person.id, age: person.age, name: person.name,
        specialization: person.specialization, data_type: person.class })
      else
        data.push({ id: person.id, age: person.age, name: person.name,
        parent_permission: person.parent_permission, data_type: person.class })
      end
      File.write('people-data.json', JSON.generate(data))
    end
  end
end
