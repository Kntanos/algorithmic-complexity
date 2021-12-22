require 'csv'
require_relative './data'

class AlgorithmTimer
  attr_reader :function, :data, :test_array, :time

  SAMPLE_SIZES = [*1..20].map { |n| n * 50_000 }
  THROWAWAY = 20

  def initialize(function, data = Data.new)
    @function = function.to_sym
    @data = data
  end

  def setup(sample_size)
    @test_array = Array.new(sample_size) { rand(0...100) }
  end
  
  def throwaway_data
    THROWAWAY.times do
      test_array.method(function).call
    end
  end
  
  def timer 
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    test_array.method(function).call
    stop = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    @time = (stop - start) * 1000.0 # in milliseconds
  end

  def run_all_samples(repeats)
    SAMPLE_SIZES.each do |sample_size|
      setup(sample_size)
      throwaway_data
      repeats.times do
        timer
        data.collect_data(time)
      end
      export_csv
      data.data_set.clear
    end
  end

  def export_csv
    CSV.open("#{function}_function.csv", 'a') do |csv|
      csv << [data.calc_median].unshift(test_array.length)
    end
  end
end
