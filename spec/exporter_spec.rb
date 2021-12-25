require 'exporter'
require 'csv'

RSpec.describe Exporter do
  describe '.export_csv' do
    it 'exports the data into a csv file' do

      subject.export_csv('last', 5.0, 1000)
      expected = '1000, 5.0'

      string = ""
      CSV.open('last_function.csv', 'r') { |csv| string << csv.first.join(", ") } 
      
      expect(string).to eq(expected)
    end
  end
end