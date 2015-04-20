require 'drawing_tool/version'
require 'drawing_tool/canvas'

require 'thor'
require 'terminal-table'

module DrawingTool
  class Cli < Thor
    desc 'new', 'This will create a new drawing instance.'
    def new
      draw_canvas
      loop do
        cmd = ask 'enter command:'
        cmd = cmd.split(' ')
        case cmd[0]
        when 'C' then canvas_command(cmd)
        when 'L' then line_command(cmd)
        when 'R' then rectangular_command(cmd)
        when 'B' then bucket_fill_command(cmd)
        when 'Q' then quit_command(cmd)
        else
          say 'Command not found, try again.', :yellow
        end
      end
    end

    no_commands do
      def draw_canvas
        system 'clear'
        header
        @canvas.draw if instance_variable_defined?(:@canvas)
        commands_list
      end
      # Validates if the given parameter is an integer number
      # greater than zero
      #
      # @param parameter [String]
      #
      # @return [TrueClass] or [FalseClass]
      def valid_number?(parameter)
        !/^[1-9]\d*$/.match(parameter).nil?
      end

      def valid_color?(parameter)
        !/^[a-z]$/.match(parameter).nil?
      end

      def canvas_command(cmd)
        begin
          if cmd.size == 3
            if valid_number?(cmd[1]) && valid_number?(cmd[2])
              @canvas = Canvas.new(cmd[1].to_i, cmd[2].to_i)
              draw_canvas
            else
              raise ArgumentError
            end  
          end
        rescue
          say 'Can\'t create a new canvas, check command parameters and try again.', :yellow
        end
      end

      def line_command(cmd)
        begin
          if cmd.size == 5
            parameters = false
            4.times { |i| parameters = valid_number?(cmd[i + 1]) }
            if parameters
              @canvas.add_line(cmd[1].to_i, cmd[2].to_i, cmd[3].to_i, cmd[4].to_i)
              draw_canvas
            else
              raise ArgumentError
            end
          end
        rescue
          say 'Can\'t draw this line, check command parameters and try again.', :yellow
        end
      end

      def rectangular_command(cmd)
        begin
          if cmd.size == 5
            parameters = false
            4.times { |i| parameters = valid_number?(cmd[i + 1]) }
            if parameters
              @canvas.add_rectangle(cmd[1].to_i, cmd[2].to_i, cmd[3].to_i, cmd[4].to_i)
              draw_canvas
            else
              raise ArgumentError
            end
          end
        rescue
          say 'Can\'t draw this rectangle, check command parameters and try again.', :yellow
        end
      end

      def bucket_fill_command(cmd)
        begin
          if cmd.size == 4
            parameters = false
            2.times { |i| parameters = valid_number?(cmd[i + 1]) }
            parameters = valid_color?(cmd[3])

            if parameters
              @canvas.bucket_fill_area(cmd[1].to_i, cmd[2].to_i, cmd[3])
              draw_canvas
            else
              raise ArgumentError
            end
          end
        rescue
          say "Can't fill the area, check command parameters and try again.", :yellow
        end
      end

      def quit_command(cmd)
        if cmd.size == 1
          if yes?('Are you sure you want to quit?')
            say 'The program quit properly'
            exit
          end
        else
          say 'Command is not valid, try again.', :yellow
        end
      end

      def header
        print "\nDrawing Tool - "
        print set_color("HUGE\n", :magenta, :bold)
      end

      def commands_list
        say "\nAvailable commands"

        rows = [['C w h', 'Create a new canvas with the given w(width) and h(height)', 'C 20 4']]
        if instance_variable_defined?(:@canvas)
          rows << ['L x1 y1 x2 y2', 'Create a new line in the canvas with the given positions', 'L 1 2 6 2']
          rows << ['R x1 y1 x2 y2', 'Create a new rectangle in the canvas with the given positions', 'R 16 1 20 3']
          rows << ['B x y c', 'Fill the entire area connected to the given positions with \'colour\' c', 'B 10 3 o']
        end
        rows << ['Q', 'Quit the program.', '']

        puts Terminal::Table.new headings: ['Command', 'Description', 'Example'], rows: rows
      end
    end
  end
end
