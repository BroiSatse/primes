describe Presenter do
  let(:values) { (1..30).to_a.sample(5) }
  let(:data) { values.map {|i| values.map {|j| i.to_s + j.to_s }}}
  let(:table) { double values: values, table: data }
  subject { described_class.new table }

  describe '#column_widths' do
    let(:long_value) { 'long value' }
    it 'contains the width of the header column' do
      values[3] = long_value
      expect(subject.column_widths[:header]).to eq long_value.length
    end

    it 'returns the width of the widest element in each column' do
      values.each_index do |i|
        data.sample[i] = long_value
      end
      expect(subject.column_widths[:data]).to all eq long_value.length
    end
  end

  describe '#cell' do
    it 'returns rjusted string with given object' do
      result = subject.cell 'hi', 5
      expect(result).to eq '   hi '
    end
  end

  describe '#border' do
    it 'simply returns a pipe' do
      expect(subject.border).to eq '| '
    end
  end

  describe '#row' do
    let(:values) { [:a, :b, :c] }
    let(:header) { :head }
    before do
      allow(subject).to receive(:column_widths).and_return(header: 1, data: [1,2,3])
      allow(subject).to receive(:cell) {|text, size| "#{text}#{size} "}
    end

    it 'correctly joins display element into table header' do
      expect(subject.row(header, values)).to eq 'head1 | a1 b2 c3 '
    end
  end

  describe '#vertical_line' do
    before do
      allow(subject).to receive(:column_widths).and_return(header: 1, data: [1,2,3])
    end

    it 'renders correct string decoration' do
      expect(subject.vertical_line).to eq '--+---------'
    end
  end

  describe '#to_s' do
    let(:values) { [:a, :b, :c] }
    before do
      allow(subject).to receive(:row) {|header, values| "#{header} - #{values.join(',')}"}
      allow(subject).to receive(:vertical_line) {'---+---'}
    end

    it 'combines the element in the correct order' do
      expect(subject.to_s).to eq " - a,b,c\n" +
                                 "---+---\n" +
                                 "a - aa,ab,ac\n" +
                                 "b - ba,bb,bc\n" +
                                 'c - ca,cb,cc'
    end
  end
end