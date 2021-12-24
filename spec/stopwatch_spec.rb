require 'stopwatch'

RSpec.describe Stopwatch do
  describe '.throwaway_data' do
    let(:function){'function'}

    it 'runs the given method THROWAWAY_RUNS times for a given sample' do
      sample = double('sample')
      allow(sample).to receive(:function)

      subject.throwaway_data(sample, function)

      expect(sample).to have_received(:function).exactly(Stopwatch::THROWAWAY_RUNS).times
    end
  end
end