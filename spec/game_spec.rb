require 'spec_helper'
require_relative '../lib/game'

RSpec.describe 'game' do
  context 'current_player' do
    it 'prints out the number input' do
      expect(current_player(2)).to eq('O')
      expect(current_player(3)).to eq('X')
    end
  end

  context 'validate_input' do
    it 'given a number it returns true' do
      expect(validate_input(2)).to eq(true)
    end
    it 'given a string it returns false' do
      expect(validate_input("string")).to eq(false)
    end
  end

  context ''

end #RSpec.describe
