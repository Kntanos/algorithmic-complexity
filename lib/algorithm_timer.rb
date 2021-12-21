require 'csv'

class AlgorithmTimer
  attr_reader :function, :data, :test_array, :time

  SAMPLE_SIZES = [*1..20].map{ |n| n * 50000}
  THROWAWAY = 100

  def initialize(function)
    @function = function.to_sym
    @data = []
  end

  def setup(sample_size)
    @test_array = Array.new(sample_size) { rand(0...100) }
  end
  
  def throwaway_data
    THROWAWAY.times do
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

  def average_data
    remove_pc = 0.05
    remove_min_max = data.length*remove_pc...data.length*(1 - remove_pc)
    pc_data_remaining = 1 - 2*remove_pc

    (data.sort[remove_min_max]).sum(0.0) / data.size * pc_data_remaining # First remove 5% of top and bottom
  end

  def run_test(sample_size, repeats) # Keeping this method in case a sample size needs to be repeated separately
    setup(sample_size)
    throwaway_data
    repeats.times do
      timer
      time_diff
      collect_data
    end
    export_csv(average_data)
    data.clear
  end

  def run_all_samples(repeats)
    SAMPLE_SIZES.each do |sample_size|
      run_test(sample_size, repeats)
    end
  end

  def export_csv(average_data)
    CSV.open("#{function}_data.csv", 'a') do |csv|
      csv << [average_data].unshift(test_array.length)
    end
  end
end
