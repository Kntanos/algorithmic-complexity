class AlgorithmTimer

  attr_reader :function, :data, :test_array

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
    start_time = Time.now 
    test_array.method(function)
    stop_time = Time.now

    @time = (stop_time - start_time) * 1000.0 # in milliseconds
  end

  def run_test(sample_size, throwaway_repeats, repeats)
    setup(sample_size)
    throwaway_data(throwaway_repeats)
    repeats.times do
      timer
      
    end
  end

  def export_csv
    [sample_size, @time] # todo
  end
end
