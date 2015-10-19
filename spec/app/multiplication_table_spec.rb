describe MultiplicationTable do

  let(:size) { rand(5..10) }
  let(:initial_value) { rand(1..4) }
  let(:range) do
    initial_value..(initial_value + size - 1)
  end

  subject { described_class.new range }

  describe '#table' do
    it 'returns an array' do
      expect(subject.table).to be_an Array
    end

    it 'contains one element per each element of the given range' do
      expect(subject.table.size).to eq size
    end

    it 'contains arrays' do
      expect(subject.table).to all be_an Array
    end

    it 'contains results of multiplication for numbers in given range' do
      table = subject.table
      5.times do
        x,y = rand(range), rand(range)
        expect(table[x - initial_value][y - initial_value]).to eq x * y
      end
    end
  end
end