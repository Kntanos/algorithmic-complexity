require ('algorithm_timer')

RSpec.describe AlgorithmTimer do

  describe '#setup' do
    it 'returns an array with the given number of elements' do
      test = AlgorithmTimer.new('some_fucntion')
      allow(test).to receive(:rand).and_return(1, 2, 3)

      expect(test.setup(3)).to eq([1, 2, 3])
    end
  end
end
