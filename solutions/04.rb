module Asm

  def Asm.asm(&block)
    assembler = Evaluator.new
    assembler.instance_eval &block
    [assembler.ax.x , assembler.bx.x, assembler.cx.x, assembler.dx.x]
  end

  class Register
    attr_accessor :x
    def initialize
      @x = 0
    end
  end

  class Evaluator

    attr_accessor :ax, :bx, :cx, :dx, :compare, :operations
    def initialize
      @ax = Register.new
      @bx = Register.new
      @cx = Register.new
      @dx = Register.new
      @compare = Register.new
      @operations = []
    end

    def mov(destination_register, source)
      if source.is_a? Register
        destination_register.x = source.x
      else
        destination_register.x = source
      end
      @operations << [:mov, destination_register, source]
    end

    def inc(destination_register, value = 1)
      if value.is_a? Register
        destination_register.x += value.x
      else
        destination_register.x += value
      end
      @operations << [:inc, destination_register, value]
    end

    def dec(destination_register, value = 1)
      if value.is_a? Register
        destination_register.x -= value.x
      else
        destination_register.x -= value
      end
      @operations << [:dec, destination_register, value]
    end

    def cmp(register, value)
      if value.is_a? Register
        compare.x = (register.x <=> value.x)
      else
        compare.x = (register.x <=> value)
      end
      @operations << [:cmp, register, value]
    end
  end
end