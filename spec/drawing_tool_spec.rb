require 'spec_helper'
 
include DrawingTool

describe Canvas do

  context 'New' do
    it 'params can\'t be zero'  do
      canvas = Canvas.new(0, 4)

    end
  end

  context 'Existing' do
    subject(:canvas) { Canvas.new(20, 4) }

    it 'return the canvas width' do
      expect(canvas.width).to eq(20)
    end

    it 'return the canvas height' do
      expect(canvas.height).to eq(4)
    end
  end
end
