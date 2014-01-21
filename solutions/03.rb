module Graphics

HTML_BEGINNING = '<!DOCTYPE html>
  <html>
  <head>
    <title>Rendered Canvas</title>
    <style type="text/css">
      .canvas {
        font-size: 1px;
        line-height: 1px;
      }
      .canvas * {
        display: inline-block;
        width: 10px;
        height: 10px;
        border-radius: 5px;
      }
      .canvas i {
        background-color: #eee;
      }
      .canvas b {
        background-color: #333;
      }
    </style>
  </head>
  <body>
    <div class="canvas">'

HTML_END = '</div>
  </body>
  </html>'

  class Canvas

    attr_accessor :pixels
    def initialize(width, height)
      @width = width
      @height = height
      @pixels = fill_pixels(width, height)
    end

    def fill_pixels(x, y)
      result = []
      (0..y - 1).each { |i| result.push(Array.new(x, 0))}
      result
    end

    def width
      @width
    end

    def height
      @height
    end

    def set_pixel(x, y)
      @pixels[y][x] = 1
    end

    def pixel_at?(x, y)
      @pixels[y][x] == 1
    end

    def render_as(renderer)
      if renderer.to_s.match (/Html$/)
        rendered = renderer.new(self)
        rendered.to_html
      elsif renderer.to_s.match (/Ascii$/)
        rendered = renderer.new(self)
        rendered.to_ascii
      end
    end
    def draw(figure)
      p self.render_as(Renderers::Ascii)
      figure.draw_figure(self)
    end
  end

  #private
  class Renderers

    class Ascii
      attr_reader :to_ascii
      def initialize(object)
        to_ascii = ""
        object.pixels.each{ |i| to_ascii << (i.join + "\n")}
        to_ascii.gsub! "0", "-"
        to_ascii.gsub! "1", "@"
        @to_ascii = to_ascii.strip
      end
    end

    class Html
      attr_reader :to_html
      def initialize(object)
        to_html = ""
        object.pixels.each{ |i| to_html << (i.join + "<br>")}
        to_html.gsub! "0", "<i></i>"
        to_html.gsub! "1", "<b></b>"
        to_html.chomp!("<br>")
        @to_html = HTML_BEGINNING + to_html + HTML_END
      end
    end
  end

  class Point

    attr_reader :abscissa, :ordinate
    def initialize(x, y)
      @abscissa = x
      @ordinate = y
    end
    def x
      @abscissa
    end
    def y
      @ordinate
    end
    def == (other)
      abscissa == other.abscissa and ordinate == other.ordinate
    end
    def eql? (other)
      self == other
    end
    def draw_figure(canvas)
      canvas.set_pixel(abscissa, ordinate)
    end
  end

  class Rectangle

    attr_reader :first_point, :second_point
    def initialize(first, second)
      @first_point  = first
      @second_point = second
    end

    def left
      if(first_point.x < second_point.x)
        first_point
      elsif first_point.y < second_point.y
          first_point
      else
        second_point
      end
    end

    def right
      if(first_point.x > second_point.x)
        first_point
      elsif first_point.y > second_point.y
          first_point
      else
        second_point
      end
    end
    def top_left
      Point.new([first_point.x, second_point.x].min, [first_point.y, second_point.y].min)
    end
    def top_right
      Point.new([first_point.x, second_point.x].max, [first_point.y, second_point.y].min)
    end
    def bottom_left
      Point.new([first_point.x, second_point.x].min, [first_point.y, second_point.y].max)
    end
    def bottom_right
      Point.new([first_point.x, second_point.x].max, [first_point.y, second_point.y].max)
    end
    def ==(other)
      self.first_point == other.first_point and self.second_point == other.second_point
    end
    def eql?(other)
      self == other
    end
  end


end