class MultiplicationTable
  attr_reader :values

  def initialize(values)
    @values = values.to_a
  end

  def table
    @table ||= values.map {|i| values.map {|j| i * j }}
  end
end