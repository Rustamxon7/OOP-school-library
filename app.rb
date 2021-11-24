require './person'
require './student'
require './teacher'
require './classroom'
require './rental'
require './book'
class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def choose_option(input)
    case input
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals
    else
      invalid_option
    end
  end

  def list_books
    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    puts
  end

  def list_people
    @people.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id} Age: #{person.age}" }
    puts
  end

  def create_person
    print 'Do you want to create a student(1) or a teacher(2)? [Input the number]:'
    input = gets.chomp.to_i
    case input
    when 1
      create_student
    when 2
      create_teacher
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.upcase == 'Y'
    gets
    @people << Student.new(name, age, parent_permission)
    puts 'Person created successfully!'
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    puts 'Person created successfully!'
    gets
    @people << Teacher.new(name, age, specialization)
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    puts 'Book created successfully!'
    gets
    @books << Book.new(title, author)
  end

  def create_rental
    puts 'Select a book from the folowing list by number'
    @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}" }
    book_index = gets.chomp.to_i
    puts 'Select a person from the folowing list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp
    puts 'Rental created successfully!'
    gets
    @rentals << Rental.new(date, @books[book_index], @people[person_index])
  end

  def list_rentals
    print 'ID of person: '
    id = gets.chomp.to_i
    puts 'Rentals:'
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}" if rental.person.id == id
    end
    puts
  end

  def invalid_option
    puts 'Invalid option!'
  end
end