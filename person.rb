require './corrector'
require './rental'

class Person
  attr_accessor :name, :age, :rentals, :parent_permission
  attr_reader :id

  def initialize(age, name: 'Unknown', parent_permission: true, id: nil)
    @id = id || Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @corrector = Corrector.new
    @rentals = []
  end

  def add_rentals(book, date)
    Rental.new(date, self, book)
  end

  def can_use_services?
    of_age? || parent_permission
  end

  def validate_name
    @name = @corrector.correct_name(@name)
  end

  private

  def of_age?
    @age >= 18
  end
end
