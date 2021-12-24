require 'stopwatch'

RSpec.describe Stopwatch do
  describe '.throwaway_data' do

    it 'runs the given method THROWAWAY_RUNS times for a given sample' do
      sample = double('sample')
      allow(sample).to receive(:last)

      subject.throwaway_data(sample, 'last')

      expect(sample).to have_received(:last).exactly(Stopwatch::THROWAWAY_RUNS).times
    end
  end
end