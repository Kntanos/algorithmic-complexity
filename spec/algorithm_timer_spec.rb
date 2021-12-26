require 'algorithm_timer'
require 'sample'

RSpec.describe AlgorithmTimer do
  describe '.run_samples' do
    it 'runs the tests for all samples' do
      data = double('data')
      sample = double('sample')
      stopwatch = double('stopwatch')
      exporter = double('exporter')

      expect(sample).to receive(:setup).exactly(20).times
      expect(sample).to receive(:sample_data).exactly(60).times.and_return([1])
      expect(stopwatch).to receive(:throwaway_data).exactly(20).times
      expect(stopwatch).to receive(:timer).exactly(20).times
      expect(stopwatch).to receive(:time).exactly(20).times.and_return(1)
      expect(data).to receive(:collect).exactly(20).times
      expect(data).to receive(:calc_median).exactly(20).times
      expect(data).to receive(:data_set).exactly(21).times.and_return([1])
      expect(exporter).to receive(:export_csv).with('last', nil, 1).exactly(20).times

      test = AlgorithmTimer.new('last', data, sample, stopwatch, exporter)
      test.run_samples(1)
      expect(test.data.data_set.length).to eq(0)
    end
  end
end
