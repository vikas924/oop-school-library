require_relative '../person'

describe Person do
  before :each do
    @person = Person.new(22, 'Vikas', parent_permission: 'true')
  end

  context 'Check person creating tasks' do
    it 'should create a person' do
      expect(@person.name).to eq('Vikas')
    end
  end

  context 'Check person creating task' do
    it 'should have the correct Age' do
      expect(@person.age).to eq(22)
    end
  end

  context 'Check person add_rental method' do
    it 'test for add_rental' do
      book = double('book', rentals: [])
      allow(book).to receive(:title) { 'Harry Potter' }
      allow(book).to receive(:author) { 'JK Rowling' }
      date = '02-23-2020'
      rental = @person.add_rental(book, date)
      expect(@person.rentals).to include(rental)
      expect(rental.book.title).to eq('Harry Potter')
      expect(rental.date).to eq(date)
    end
  end

  context 'Check person name' do
    it 'correct name method' do
      expect(@person.correct_name).to eq('Vikas')
    end
  end

  context 'Check person age' do
    it 'should have the correct Age' do
      expect(@person.send('of_age?')).to be true
    end
  end

  context 'Check person can use services' do
    it 'can use services' do
      expect(@person.can_use_service?).to be true
    end
  end
end
