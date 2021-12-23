class Stopwatch
  attr_reader :time

  THROWAWAY_RUNS = 20

  def initialize
    @time = nil
  end

  def throwaway_data(sample, function)
    THROWAWAY_RUNS.times do
      sample.method(function).call
    end
  end

  def timer(sample, function)
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    sample.method(function).call
    stop = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    @time = (stop - start) * 1000.0 # in milliseconds
  end
end
