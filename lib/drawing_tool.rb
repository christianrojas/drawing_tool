require 'drawing_tool/version'
require 'drawing_tool/canvas'

require 'thor'
require 'terminal-table'

module DrawingTool
  class Cli < Thor

    desc 'new', 'This will create a new drawing instance.'
    def new
      print_header
      print_commands
    end

    no_commands do
      def print_header
        system("clear")
        print "\nDrawing Tool - "
        print set_color("HUGE\n", :magenta, :bold)
      end

      def print_commands
        say "\nAvailable commands"

        rows = [
          ['C w h', 'Create a new canvas with the given w(width) and h(height)', 'C 20 4'],
          ['L x1 y1 x2 y2', 'Create a new line in the canvas with the given positions', 'L 1 2 6 2'],
          ['R x1 y1 x2 y2', 'Create a new rectangle in the canvas with the given positions', 'R 16 1 20 3'],
          ['B x y c', 'Fill the entire area connected to the given positions with \'colour\' c', 'B 10 3 o'],
          ['Q', 'Quit the current drawing tool instance.', '']
        ]

        puts Terminal::Table.new :headings => ['Command', 'Description', 'Example'], :rows => rows
      end
    end
  end
end
