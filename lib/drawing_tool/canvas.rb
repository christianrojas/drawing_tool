require 'byebug'

module DrawingTool
  class Canvas
    attr_accessor :width, :height, :positions

    # Initialize a canvas object
    #
    # @param width [Integer] of the canvas
    # @param height [Integer] of the canvas
    def initialize(width, height)
      @width     = width
      @height    = height
      @positions = []

      # Create a hash for every position in the canvas
      # and adds to @positions array
      @height.times do |y|
        @width.times do |x|
          @positions.push({:x => x+1, :y => y+1, :v => nil})
        end
      end
    end

    # Add a new line to the canvas with the given
    # positions
    # 
    # @param x1 [Integer]
    # @param y1 [Integer]
    # @param x2 [Integer]
    # @param y2 [Integer]
    def add_line(x1, y1, x2, y2)
      if y1 == y2
        if x1 < x2 # left -> right
          (x1..x2).each { |x| get_position(x, y1)[:v] = 'x' }
        else # rigth -> left
          x1.downto(x2) { |x| get_position(x, y1)[:v] = 'x' }
        end
      else
        if y1 < y2 # top -> bottom
          (y1..y2).each { |y| get_position(x1, y)[:v] = 'x' }
        else # bottom -> top
          y1.downto(y2) { |y| get_position(x1, y)[:v] = 'x' }
        end
      end
    end

    def add_rectangle(x1, y1, x2, y2)
      # Vertical lines
      add_line(x1, y1, x2, y1)
      add_line(x1, y2, x2, y2)

      # Horizontal lines
      add_line(x1, y1, x1, y2)
      add_line(x2, y1, x2, y2)
    end

    def bucket_fill_area(x, y, c); end

    def draw
      # Prints canvas dimensions
      puts "\nCanvas"

      # Prints top margin of the canvas
      (@width+2).times { print '-' }
      puts

      index = 0
      @height.times do |x|
        
        # Prints left margin of the row
        print '|'

        # Prints row content for every position
        @width.times do |y|
          print @positions[index][:v].nil? ? ' ' : @positions[index][:v]
          index += 1
        end

        # Prints right margin of the row
        print '|'
        puts
      end

      # Prints bottom margin of the canvas
      (@width+2).times { print '-' }
      puts
      puts "\nDimensions: width: #{@width} x height: #{@height}"
    end

    # Add a new line to the canvas with the given
    # positions
    # 
    # @param x [Integer] position in the canvas
    # @param y [Integer] position in the canvas
    #
    # @return [Hash] with position
    def get_position(x, y)
      @positions.find {|hash| hash[:x] == x && hash[:y] == y }
    end
  end
end
