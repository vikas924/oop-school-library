require_relative '../book'

describe Book do
  context 'Should create a book' do
    it 'should have the correct title' do
      new_book = Book.new('Title', 'Author')
      expect(new_book.title).to eq('Title')
    end
  end
  context 'Should create a book' do
    it 'should have the correct title' do
      new_book = Book.new('Title', 'Author')
      expect(new_book.author).to eq('Author')
    end
  end
  context 'Should create a book' do
    it 'test for add_rental' do
      @book = Book.new 'Rich Dad Poor Dad', 'Robert T.Kiyosaki'
      person = double('Person', rentals: [])
      allow(person).to receive(:age) { '12' }
      allow(person).to receive(:name) { 'Robert T.Kiyosaki' }
      allow(person).to receive(:parent_permission) { true }
      rental = @book.add_rental(person, '2023-02-03')
      puts rental.person.age
      expect(rental.person.name).to eq('Robert T.Kiyosaki')
    end
  end
end
