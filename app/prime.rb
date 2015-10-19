module Prime
  SIEVE_INCREMENT = 200

  def self.first(n)
    limit = 2
    results = []
    while results.size < n
      results.concat [*limit..(limit += SIEVE_INCREMENT)]
      self.sieve! results
    end
    results.take n
  end

  def self.sieve!(array)
    array.each_with_index do |current, current_index|
      array.delete_if.with_index do |element, index|
        next unless current_index < index
        element.modulo(current).zero?
      end
    end
  end
end