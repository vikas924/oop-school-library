require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'manage_people'
require_relative 'inputs'
require 'json'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
    @input = Input.new
  end

  def load_data
    books = JSON.parse(fetch_data('books'))
    people = JSON.parse(fetch_data('people'))
    rentals = JSON.parse(fetch_data('rentals'))

    books.each do |book|
      @books << Book.new(book['title'], book['author'])
    end

    people.each do |person|
      @people << if person['type'] == 'Teacher'
                   Teacher.new(person['age'], person['name'], person['specialization'], parent_permission: true)
                 else
                   Student.new(nil, person['age'], person['name'], parent_permission: person['parent_permission'])
                 end
    end

      rentals.each do |rental|
      rentee = @people.select { |person| person.name == rental['person_name'] }
      rented_book = @books.select { |book| book.title == rental['book_titles'] }
      @rentals << Rental.new(rental['date'], rented_book[0], rentee[0])
    end
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

  def save_books
    updated_books = []

    @books.each do |book|
      updated_books << { 'title' => book.title, 'author' => book.author }
    end

    File.write('db/books.json', JSON.pretty_generate(updated_books))
  end

  def save_people
    updated_people = []

    @people.each do |person|
      if person.instance_of?(::Teacher)
        updated_people << { 'type' => 'Teacher', 'id' => person.id, 'name' => person.name, 'age' => person.age,
                            'specialization' => person.specialization }
      elsif person.instance_of?(::Student)
        updated_people << { 'type' => 'Student', 'id' => person.id, 'name' => person.name, 'age' => person.age,
                            'parent_permission' => person.parent_permission }
      end
    end

    File.write('db/people.json', JSON.pretty_generate(updated_people))
  end

  def save_rentals
    updated_rentals = []

    @rentals.each do |rental|
      updated_rentals << { 'person_name' => rental.person.name, 'book_titles' => rental.book.title,
                           'date' => rental.date }
    end

    File.write('db/rentals.json', JSON.pretty_generate(updated_rentals))
  end

  def save_exit
    puts 'Goodbye'

    save_books

    save_people

    save_rentals

    exit
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
