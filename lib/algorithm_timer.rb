require 'csv'
require_relative './data'
require_relative './sample'
require_relative './stopwatch'

class AlgorithmTimer
  attr_reader :function, :data, :sample, :stopwatch

  THROWAWAY = 20

  def initialize(function, data = Data.new, sample = Sample.new, stopwatch = Stopwatch.new)
    @function = function.to_sym
    @data = data
    @sample = sample
    @stopwatch = stopwatch
  end
  
  def throwaway_data
    THROWAWAY.times do
      sample.sample_data.method(function).call
    end
  end

  def run_samples(repeats)
    Sample::SAMPLE_SIZES.each do |sample_size|
      sample.setup(sample_size)
      throwaway_data
      repeats.times do
        stopwatch.timer(sample.sample_data, function)
        data.collect(stopwatch.time)
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
