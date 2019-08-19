require 'spec_helper'
require_relative '../lib/game'

RSpec.describe 'something' do
  context 'currentPlayer' do
    it 'prints out the number input' do
      expect(tester(2)).to eq('X')
    end
  end

end #RSpec.describe
