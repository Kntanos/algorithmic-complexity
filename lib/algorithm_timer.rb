require 'csv'
require_relative './data'
require_relative './sample'
require_relative './stopwatch'
require_relative './exporter'

class AlgorithmTimer
  attr_reader :function, :data, :sample, :stopwatch, :exporter

  def initialize(function, 
                data = Data.new,
                sample = Sample.new, 
                stopwatch = Stopwatch.new,
                exporter = Exporter.new)

    @function = function.to_sym
    @data = data
    @sample = sample
    @stopwatch = stopwatch
    @exporter = exporter
  end

  def run_samples(repeats)
    Sample::SAMPLE_SIZES.each do |sample_size|
      sample.setup(sample_size)
      stopwatch.throwaway_data(sample.sample_data, function)
      repeats.times do
        stopwatch.timer(sample.sample_data, function)
        data.collect(stopwatch.time)
      end
      exporter.export_csv(function.to_s, data.calc_median, sample.sample_data.length)
      data.data_set.clear
    end
  end
end
