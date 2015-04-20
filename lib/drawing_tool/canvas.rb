require 'byebug'

module DrawingTool
  #
  # Class Canvas provides provides functionality to all 
  # commands used in the canvas
  #
  # @author Christian Rojas <christianrojasgar@gmail.com>
  #
  class Canvas
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

    # Add a new line to the canvas with the given
    # positions
    # 
    # @param x1 [Integer]
    # @param y1 [Integer]
    # @param x2 [Integer]
    # @param y2 [Integer]
    # TODO: Refactoring
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

    def add_rectangle(x1, y1, x2, y2)
      # Vertical lines
      add_line(x1, y1, x2, y1)
      add_line(x1, y2, x2, y2)

      # Horizontal lines
      add_line(x1, y1, x1, y2)
      add_line(x2, y1, x2, y2)
    end

    def bucket_fill_area(x, y, c)
      @colour = c
      if (x >= 1 && x <= @width) && (y >= 1 && y <= @height)
        base_position = get_position(x, y)
      
        if base_position[:v].nil?
          base_position[:v] = @colour

          @rows = [base_position]
          @rows.each do |row|
            position(row[:x], row[:y] - 1) if (row[:y] - 1) >= 1
            position(row[:x] + 1, row[:y]) if (row[:x] + 1) <= @width
            position(row[:x], row[:y] + 1) if (row[:y] + 1) <= @height
            position(row[:x] - 1, row[:y]) if (row[:x] - 1) >= 1
          end
        end
      end
    end

    def position(x, y)
      position = get_position(x, y)
      if position[:v].nil?
        @rows << position 
        position[:v] = @colour # Change the nil value to c
      end
    end

    def bucket_fill_position(x, y, c)
      get_position(x, y)[:v] = c
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
      # Get the position and add the key :v
      get_position(x, y)[:v] = 'x'
    end

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
