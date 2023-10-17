require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'manage_people'
require_relative 'inputs'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
    @input = Input.new
  end

  def list_books
    if @books.empty?
      puts 'There are no books yet'
    else
      @books.each do |book|
        puts "Title: #{book.title}, Author: #{book.author}"
      end
    end
  end

  def list_people
    if @people.empty?
      puts 'There are no people'
    else
      @people.each do |person|
        puts "[#{person.class}] Name: #{person.name} ID: #{person.id} Age: #{person.age}"
      end
    end
  end

  def create_person
    selected_person_type = @input.person_input

    case selected_person_type
    when 1
      create_student
    when 2
      create_teacher
    end
  end

  def create_book
    print 'Title: '
    title = @input.title_input
    print 'Author: '
    author = @input.author_input

    book = Book.new(title, author)
    @books << book

    puts 'Book created successfully'
  end

  def create_rental
    if @books.empty?
      puts 'No books created please create a book'
      return
    elsif @people.empty?
      puts 'No people created please create a person'
      return
    end

    puts 'Select a book from the following list of number'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    selected_book = @input.book_index_input(@books.size)

    puts 'Select a person from the following list of number (not ID)'
    @people.each_with_index do |person, index|
      puts "#{index}) Name: #{person.name} Age: #{person.age} Id: #{person.id}"
    end

    selected_person = @input.person_index_input(@people.size)

    selected_date = @input.date_input

    rented = Rental.new(selected_date, @books[selected_book], @people[selected_person])
    @rentals << rented

    puts 'Book was successfully rented.'
  end

  def list_rental
    print 'Enter the Person ID: '
    person_id = Integer(gets.chomp)
    @rentals.each do |rent|
      puts "Date: #{rent.date}, Book: #{rent.book.title} Author: #{rent.book.author}" if rent.person.id == person_id
    end
  end

  def invalid_option
    puts 'Invalid option'
  end

  def options
    puts 'Please enter the number for the task you want to perform'
    puts 'choose one of the following'
    puts '1 - List all books.'
    puts '2 - List all people.'
    puts '3 - Create a person (teacher or student).'
    puts '4 - Create a book.'
    puts '5 - Create a rental.'
    puts '6 - List all rentals for a given person id.'
    puts '7 - Exit'
  end
end
