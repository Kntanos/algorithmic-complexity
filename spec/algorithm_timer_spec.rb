require ('algorithm_timer')

RSpec.describe AlgorithmTimer do

  describe '#setup' do
    it 'returns an array with the given number of elements' do
      test = AlgorithmTimer.new('function')
      allow(test).to receive(:rand).and_return(1, 2, 3)

      expect(test.setup(3)).to eq([1, 2, 3])
    end
  end

  describe '#throwaway_data' do
    it 'calls a function on an array the given number of times' do
      @test = AlgorithmTimer.new('last')
      @test.setup(3)

      @test.throwaway_data(3)
      expect(@test.test_array).to receive(:last).exactly(3).times
     
      @test.test_array.last
      @test.test_array.last
      @test.test_array.last
    end
  end
end
