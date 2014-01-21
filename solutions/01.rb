class Integer
  def prime?
    return false if self <= 1
    2.upto(pred).all? { |divisor| remainder(divisor).nonzero? }
  end

  def prime_factors
    return [] if abs < 2
    divisor = 2.upto(abs).find { |divisor| abs.remainder(divisor).zero? }
    [divisor] + (abs / divisor).prime_factors
  end

  def digits
    abs.to_s.chars.map(&:to_i)
  end

  def harmonic
    1.upto(self).map { |number| Rational(1, number) }.reduce(:+)
  end
end


class Array
  def average
    reduce(:+) / size.to_f
  end

  def frequencies
    reduce(Hash.new(0)) do |frequencies, element|
      frequencies[element] += 1
      frequencies
    end
  end

  def drop_every(n)
    each_slice(n).map { |slice| slice.take(n - 1) }.flatten
  end

  def combine_with(other)
    if empty?
      other
    else
      [first] + other.combine_with(self[1..-1])
    end
  end
end