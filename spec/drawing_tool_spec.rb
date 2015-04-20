require 'spec_helper'
require 'byebug'
 
include DrawingTool

describe 'Parameter' do
  subject(:cli) { Cli.new }

  it 'should be an integer number greater than zero' do
    expect(cli.valid_number?('-1')).to be false
    expect(cli.valid_number?('_')).to be false
    expect(cli.valid_number?('a')).to be false
    expect(cli.valid_number?('a12')).to be false
    expect(cli.valid_number?('1a2')).to be false
    expect(cli.valid_number?('20o')).to be false
    expect(cli.valid_number?('0')).to be false
    expect(cli.valid_number?('0.1')).to be false
    expect(cli.valid_number?('0,1')).to be false
    expect(cli.valid_number?('10')).to be true
  end

  it 'color should be a single lower cas character' do
    expect(cli.valid_color?('a')).to be true
    expect(cli.valid_color?('o')).to be true
    expect(cli.valid_color?('-1')).to be false
    expect(cli.valid_color?('A')).to be false
    expect(cli.valid_color?('_')).to be false
    expect(cli.valid_color?('a12')).to be false
    expect(cli.valid_color?('1a2')).to be false
    expect(cli.valid_color?('20o')).to be false
    expect(cli.valid_color?('0')).to be false
    expect(cli.valid_color?('0.1')).to be false
    expect(cli.valid_color?('0,1')).to be false
    expect(cli.valid_color?('10')).to be false
  end
end

describe Canvas do
  subject(:canvas) { Canvas.new(20, 4) }

  it 'should not color if is a line position' do
    canvas.position(10, 3)

  end

  describe 'Position' do
    it 'should return Hash object with the given parameters' do
      expect(canvas.get_position(18, 2)).to be_kind_of(Hash)
    end

    it 'should draw in the given position' do
      expect(canvas.get_position(3, 4)[:v]).to be_nil
      expect(canvas.draw_position(3, 4)).to eq('x')
    end
  end
end
