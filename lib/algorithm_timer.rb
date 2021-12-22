require 'csv'
require_relative './data'
require_relative './sample'

class AlgorithmTimer
  attr_reader :function, :data, :sample, :time

  THROWAWAY = 20

  def initialize(function, data = Data.new, sample = Sample.new)
    @function = function.to_sym
    @data = data
    @sample = sample
  end
  
  def throwaway_data
    THROWAWAY.times do
      sample.sample_data.method(function).call
    end
  end
  
  def timer 
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    sample.sample_data.method(function).call
    stop = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    @time = (stop - start) * 1000.0 # in milliseconds
  end

  def run_all_samples(repeats)
    Sample::SAMPLE_SIZES.each do |sample_size|
      sample.setup(sample_size)
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
      csv << [data.calc_median].unshift(sample.sample_data.length)
    end
  end
end
