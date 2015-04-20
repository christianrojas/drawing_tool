module DrawingTool
  #
  # Class Canvas provides provides functionality to all 
  # commands used in the canvas
  #
  # @author Christian Rojas <christianrojasgar@gmail.com>
  #
  class Canvas
    #
    # @!attribute [rw] positions
    #   @return [Array] with all canvas positions
    attr_accessor :positions

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
          @positions.push({ x: x+1, y: y+1, v: nil })
        end
      end
    end

    #
    # Add a new line to the canvas with the given
    # positions
    # 
    # @param x1 [Integer] x1 position
    # @param y1 [Integer] y1 position
    # @param x2 [Integer] x2 position
    # @param y2 [Integer] y2 position
    #
    def add_line(x1, y1, x2, y2)
      if y1 == y2
        if x1 < x2 # left -> right
          (x1..x2).each { |x| draw_position(x, y1) }
        else # rigth -> left
          x1.downto(x2) { |x| draw_position(x, y1) }
        end
      elsif x1 == x2
        if y1 < y2 # top -> bottom
          (y1..y2).each { |y| draw_position(x1, y) }
        else # bottom -> top
          y1.downto(y2) { |y| draw_position(x1, y) }
        end
      else
        raise ArgumentError
      end
    end

    #
    # Add a new rectngle in the canvas
    #
    # @param [Integer] x1 position
    # @param [Integer] y1 position
    # @param [Integer] x2 position
    # @param [Integer] y2 position
    #
    # @return [void]
    # 
    def add_rectangle(x1, y1, x2, y2)
      # Vertical lines
      add_line(x1, y1, x2, y1)
      add_line(x1, y2, x2, y2)

      # Horizontal lines
      add_line(x1, y1, x1, y2)
      add_line(x2, y1, x2, y2)
    end

    #
    # Bucket fill the entire area connected to the given position
    #
    # @param [Integer] x position
    # @param [Integer] y position
    # @param [String] c color character
    #
    # @return [void]
    # 
    def bucket_fill_area(x, y, c)
      @rows = []
      if (x >= 1 && x <= @width) && (y >= 1 && y <= @height)
        process_position(x, y, c)

        @rows.each do |row|
          process_position(row[:x], row[:y] - 1, c) if (row[:y] - 1) >= 1
          process_position(row[:x] + 1, row[:y], c) if (row[:x] + 1) <= @width
          process_position(row[:x], row[:y] + 1, c) if (row[:y] + 1) <= @height
          process_position(row[:x] - 1, row[:y], c) if (row[:x] - 1) >= 1
        end
      end
    end

    #
    # Analize and process the if the position is connected
    #
    # @param [Integer] x position
    # @param [Integer] y position
    # @param [String] c color character
    #
    # @return [void]
    # 
    def process_position(x, y, c)
      position = get_position(x, y)
      if position[:v].nil?
        @rows << position 
        colour_position(position, c)
      end
    end

    #
    # Draw a colour character in the given position.
    #
    # @param [Hash] position
    # @param [<String>] colour_char character
    #
    # @return [void]
    # 
    def colour_position(position, colour_char)
      position[:v] = colour_char
    end

    #
    # Draw an 'x' in the given positions
    #
    # @param [Integer] x position
    # @param [Integer] y position
    #
    # @return [void]
    # 
    def draw_position(x, y)
      get_position(x, y)[:v] = 'x'
    end

    #
    # Draw the entire canvas in the terminal
    #
    #
    # @return [void]
    # 
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
      print "\n[ W: #{@width} x H: #{@height} ]\n"
    end

    #
    # Add a new line to the canvas with the given
    # positions
    # 
    # @param x [Integer] position in the canvas
    # @param y [Integer] position in the canvas
    #
    # @return [Hash] with position
    def get_position(x, y)
      @positions.find { |hash| hash[:x] == x && hash[:y] == y }
    end
  end
end
