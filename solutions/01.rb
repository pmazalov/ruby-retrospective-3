class Integer
  def prime?
    if self < 0 or self == 1
      return false
    else
      (2..self-1).all? { |n| self % n != 0 }
    end
  end

  def prime_factors
    prime_divisors = (2..abs).select { |n| n.prime? and self % n == 0 }
    multiplicity = prime_divisors.map { |n| abs.divisor_multiplicity(n) }
    prime_divisors.zip(multiplicity).map { |n, count| [n] * count }.flatten

  end

  def divisor_multiplicity(divisor)
    if self % divisor == 0
      1 + (self / divisor).divisor_multiplicity(divisor)
    else
      0
    end
  end

  def digits
    number = abs
    if number > 10
      (number / 10).digits + [number % 10]
    else
      [number]
    end
  end

  def harmonic
    (1..self).map { |n| Rational(1, n) }.reduce(:+)
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