require 'csv'

class AlgorithmTimer

  attr_reader :function, :data, :test_array, :time

  def initialize(function)
    @function = function.to_sym
    @data = []
  end

  def setup(sample_size)
    @test_array = Array.new(sample_size) { rand(0...9) }
  end
  
  def throwaway_data(throwaway_repeats)
    throwaway_repeats.times do
      test_array.method(function)
    end
  end
  
  def timer 
    @start_time = Time.now 
    test_array.method(function)
    @stop_time = Time.now
  end

  def time_diff
    @time = (@stop_time - @start_time) * 1000.0 # in milliseconds
  end

  def collect_data
    data.push(time)
  end

  def run_test(sample_size, throwaway_repeats, repeats)
    setup(sample_size)
    throwaway_data(throwaway_repeats)
    repeats.times do
      timer
      time_diff
      collect_data
    end
    export_csv
  end

  def export_csv
    CSV.open("#{test_array.length}_test_data.csv", 'w') do |csv|
      csv << (data.unshift(test_array.length))
    end
  end
end
