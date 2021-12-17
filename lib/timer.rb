class Timer

  attr_reader :function, :sample_size

  def initialize(function)
    @sample_size = [10, 15, 20]
    @function = function.to_sym
  end

  def setup
    @test_sample = sample_size.map { |size| { size => (Array.new(size) { rand(0...9) })} }
  end
  
  def throwaway_data
    10.times do
      @test_sample.map do |sample|
        sample.values[0].method(function)
      end
    end
  end
  
  def evaluate
    setup
    throwaway_data

    results = @test_sample.map do |sample|
      start_time = Time.now
      sample.values[0].method(function)
      end_time = Time.now

      {sample.keys[0] => ((end_time - start_time) * 1000.0)}
    end
  end
end