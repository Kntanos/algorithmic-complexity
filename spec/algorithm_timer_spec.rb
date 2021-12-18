require ('algorithm_timer')

RSpec.describe AlgorithmTimer do

  describe '#setup' do
    it 'returns an array with the given number of elements' do
      test = AlgorithmTimer.new('some_fucntion')

      expect(test.setup(10).length).to eq(10)
      expect(test.setup(1000).length).to eq(1000)
    end
  end
end
