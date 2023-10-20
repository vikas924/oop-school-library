require_relative '../decorator'

describe Decorator do
  let(:nameable) { double('nameable', correct_name: 'Original Name') }
  let(:decorator) { Decorator.new(nameable) }

  context 'attributes' do
    it 'has a nameable object' do
      expect(decorator.instance_variable_get(:@nameable)).to eq(nameable)
    end
  end

  context 'correct_name' do
    it 'delegates correct_name to the nameable object' do
      expect(decorator.correct_name).to eq('Original Name')
    end
  end
end
