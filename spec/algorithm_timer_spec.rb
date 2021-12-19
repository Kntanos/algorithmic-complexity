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

  describe '#timer' do
    it 'times the function' do
      @test = AlgorithmTimer.new('last')
      @test.setup(3)
      @test.timer

      expect(Time).to receive(:now).twice
      expect(@test.test_array).to receive(:last).once

      @test.test_array.last
      Time.now
      Time.now
    end
  end

  describe '#time_diff' do
    it 'returns time in float of milliseconds' do
      @test = AlgorithmTimer.new('last')
      @test.setup(3)
      @test.timer
      
      expect(@test.time_diff).to be_instance_of Float
    end
  end

  describe '#collect_data' do
    it 'collects test data in an array' do
      @test = AlgorithmTimer.new('last')
      @test.setup(3)
      @test.timer
      @test.time_diff
      @test.collect_data

      expect(@test.data.length).to eq(1)
    end
  end

  describe '#run_test' do
    it 'runs the test the given number of times' do
      @test = AlgorithmTimer.new('last')
      @test.run_test(3, 3, 3)

      expect(@test).to receive(:setup).with(3)
      expect(@test).to receive(:throwaway_data).with(3)
      expect(@test).to receive(:timer).exactly(3).times
      expect(@test).to receive(:time_diff).exactly(3).times
      expect(@test).to receive(:export_csv).once
      expect(@test.data.length).to eq(3)

      @test.setup(3)
      @test.throwaway_data(3)
      @test.timer
      @test.timer
      @test.timer
      @test.time_diff
      @test.time_diff
      @test.time_diff
      @test.export_csv
    end
  end
end
