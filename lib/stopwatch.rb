class Stopwatch
  attr_reader :time

  def initialize
    @time = nil
  end

  def timer(sample, function)
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    sample.method(function).call
    stop = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    @time = (stop - start) * 1000.0 # in milliseconds
  end
end