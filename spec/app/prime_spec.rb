describe Prime do
  describe '.sieve!' do
    let(:array) { [2,3,4,9,8,11,13,33] }
    it 'removes all elements from given array which are dividable by other elements of the array' do
      expect(described_class.sieve! array).to eq [2,3,11,13]
    end
  end

  describe '.first' do
    it 'returns n first prime numbers' do
      expect(described_class.first(5)).to eq [2,3,5,7,11]
    end

    it 'calls sieve! multiple times if the initial limit was too low' do
      stub_const("#{described_class.name}::SIEVE_INCREMENT", 20)
      expect(described_class).to receive(:sieve!).exactly(2).times.and_call_original
      described_class.first(10)
    end
  end
end