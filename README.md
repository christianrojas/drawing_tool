# DrawingTool

Simple console version of a drawing program.

### The program work as follows
1. Create a new canvas
2. Start drawing on the canvas by issuing various commands
3. Quit

### Supported commands:

	C w h

Should create a new canvas of width w and height h.

	L x1 y1 x2 y2

Should create a new line from (x1,y1) to (x2,y2). Currently only
horizontal or vertical lines are supported. Horizontal and vertical lines
will be drawn using the 'x' character.

	R x1 y1 x2 y2

Should create a new rectangle, whose upper left corner is (x1,y1) and
lower right corner is (x2,y2). Horizontal and vertical lines will be drawn
using the 'x' character.

	B x y c

Should fill the entire area connected to (x,y) with "colour" c. The
behaviour of this is the same as that of the "bucket fill" tool in paint
programs.


	Q

Should quit the program.
## Installation

_This gem is not currently in RubyGems_

Clone repo

	$ git clone git@github.com:christianrojas/drawing_tool.git
	
	cd drawing_tool

And then execute:

    $ bundle

## Usage

Get the command list:

`bundle exec bin/drawing_tool`

## Contributing

1. Fork it ( https://github.com/christianrojas/drawing_tool/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
