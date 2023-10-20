require_relative '../capitalizedecorator'

describe CapitalizeDecorator do
  let(:nameable) { double('Nameable', correct_name: 'maximilianus') }
  let(:decorator) { CapitalizeDecorator.new(nameable) }

  describe 'Check Proper Capitalization Decoration' do
    it 'should Decorate a Person name' do
      expect(decorator.correct_name).to eq('Maximilianus')
    end
  end
end
