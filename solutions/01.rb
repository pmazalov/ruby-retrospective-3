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

  def divisor_multiplicity(divisor)
    if self % divisor == 0
      1 + (self / divisor).divisor_multiplicity(divisor)
    else
      0
    end
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
    sum = 0
    each { |n| sum += n}
    sum / self.count.to_f
  end

  def frequencies
    reduce(Hash.new(0)) do |frequencies, element|
      frequencies[element] += 1
      frequencies
    end
  end

  def drop_every(n)
    result = []
    (1..size).each do |i|
      if i % n != 0
        result << self[i - 1]
      end
    end
    result
  end

  def combine_with(other)
    if size < other.size
      zip(other).flatten.compact + other.slice(size, other.size)
    else
      zip(other).flatten.compact
    end
  end
end