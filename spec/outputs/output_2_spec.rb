require 'spec_helper'

RSpec.describe 'Output #2' do
  let(:output) { `ruby main.rb input_2.csv` }

  it 'check sales tax' do
    expect(output).to include('Sales Taxes: 7.65')
  end

  it 'check price with tax' do
    expect(output).to include('Total Price: 65.15')
  end
end
