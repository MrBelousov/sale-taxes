require 'spec_helper'

RSpec.describe 'Output #3' do
  let(:output) { `ruby main.rb input_3.csv` }

  it 'check sales tax' do
    expect(output).to include('Sales Taxes: 7.55')
  end

  it 'check price with tax' do
    expect(output).to include('Total Price: 82.23')
  end
end
