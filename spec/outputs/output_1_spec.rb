require 'spec_helper'

RSpec.describe 'Output #1' do
  let(:output) { `ruby main.rb input_1.csv` }

  it 'check sales tax' do
    expect(output).to include('Sales Taxes: 1.5')
  end

  it 'check price with tax' do
    expect(output).to include('Total Price: 29.83')
  end
end
