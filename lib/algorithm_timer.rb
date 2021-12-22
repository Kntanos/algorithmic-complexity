require 'csv'

class AlgorithmTimer
  attr_reader :function, :data#, :test_array

  SAMPLE_SIZES = [*1..20].map{ |n| n * 50000}
  THROWAWAY = 20

  def initialize(function)
    @function = function.to_sym
    @data = []
  end

  def setup(sample_size)
    @test_array = Array.new(sample_size) { rand(0...100) }
  end
  
  def throwaway_data
    THROWAWAY.times do
      @test_array.method(function).call
    end
  end
  
  def timer 
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @test_array.method(function).call
    stop = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    @time = (stop - start) * 1000.0 # in milliseconds
  end

  def collect_data
    data.push(@time)
  end

  def calc_median
    return nil if data.empty?
    sorted = data.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
    end

  def run_all_samples(repeats)
    SAMPLE_SIZES.each do |sample_size|
      setup(sample_size)
    throwaway_data
    repeats.times do
      timer
      collect_data
    end
    export_csv(calc_median)
    data.clear
    end
  end

  def export_csv(median)
    CSV.open("#{function}_data.csv", 'a') do |csv|
      csv << [calc_median].unshift(@test_array.length)
    end
  end
end
