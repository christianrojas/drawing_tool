require 'spec_helper'
 
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

  describe 'Position' do
    it 'should return Hash object with the given parameters' do
      expect(canvas.get_position(18, 2)).to be_kind_of(Hash)
    end

    it 'should draw in the given position' do
      expect(canvas.get_position(3, 4)[:v]).to be_nil
      expect(canvas.draw_position(3, 4)).to eq('x')
    end

    it 'should colour the given position' do
      position = canvas.get_position(3, 4)
      canvas.colour_position(position, 'g')
      expect(position[:v]).to eq('g')
    end
  end

  describe 'Line' do
    before { canvas.add_line(8, 2, 12, 2) }

    it 'should add a line from x1, y1 to x2, y2' do
      expect(canvas.get_position(8, 2)[:v]).to eq('x')
      expect(canvas.get_position(9, 2)[:v]).to eq('x')
      expect(canvas.get_position(10, 2)[:v]).to eq('x')
      expect(canvas.get_position(11, 2)[:v]).to eq('x')
      expect(canvas.get_position(12, 2)[:v]).to eq('x')
    end

    it 'should use 5 position' do
      rows = canvas.positions.select { |hash| hash[:v] == 'x' }
      expect(rows.size).to eq(5)
    end
  end

  describe 'Rectangle' do
    before { canvas.add_rectangle(16, 1, 20, 3) }

    it 'should add a rectangle from x1, y1 to x2, y2' do
      expect(canvas.get_position(16, 1)[:v]).to eq('x')
      expect(canvas.get_position(16, 2)[:v]).to eq('x')
      expect(canvas.get_position(16, 3)[:v]).to eq('x')

      expect(canvas.get_position(17, 1)[:v]).to eq('x')
      expect(canvas.get_position(17, 3)[:v]).to eq('x')

      expect(canvas.get_position(18, 1)[:v]).to eq('x')
      expect(canvas.get_position(18, 3)[:v]).to eq('x')

      expect(canvas.get_position(19, 1)[:v]).to eq('x')
      expect(canvas.get_position(19, 3)[:v]).to eq('x')

      expect(canvas.get_position(20, 1)[:v]).to eq('x')
      expect(canvas.get_position(20, 2)[:v]).to eq('x')
      expect(canvas.get_position(20, 3)[:v]).to eq('x')
    end

    it 'should use 12 position' do
      rows = canvas.positions.select { |hash| hash[:v] == 'x' }
      expect(rows.size).to eq(12)
    end
  end

  describe 'Bucket fill area' do
    it 'should fill entire canvas' do
      expect(canvas.get_position(10, 3)[:v]).to be_nil
      canvas.bucket_fill_area(10, 3, 'o')
      rows = canvas.positions.select { |hash| hash[:v] == 'o' }
      expect(rows.size).to eq(80)
    end

    it 'should fill entire canvas with char \'g\'' do
      expect(canvas.get_position(10, 3)[:v]).to be_nil
      canvas.bucket_fill_area(10, 3, 'g')
      rows = canvas.positions.select { |hash| hash[:v] == 'g' }
      expect(rows.size).to eq(80)
    end

    it 'should fill within a rectangle' do
      canvas.add_rectangle(16, 1, 20, 3)
      expect(canvas.get_position(18, 2)[:v]).to be_nil
      canvas.bucket_fill_area(18, 2, 'o')
      rows = canvas.positions.select { |hash| hash[:v] == 'o' }
      expect(rows.size).to eq(3)
    end

    it 'should fill area between lines and rectangle' do
      canvas.add_line(1, 2, 6, 2)
      canvas.add_line(6, 3, 6, 4)
      canvas.add_rectangle(16, 1, 20, 3)
      expect(canvas.get_position(10, 3)[:v]).to be_nil
      canvas.bucket_fill_area(10, 3, 'o')
      rows = canvas.positions.select { |hash| hash[:v] == 'o' }
      expect(rows.size).to eq(47)
    end
  end
end
