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

    def add_line(x1, y1, x2, y2); end
    def add_rectangle(x1, y1, x2, y2); end
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
  end
end
