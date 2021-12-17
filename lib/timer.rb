class Timer

  attr_reader :function, :array

  def initialize(function, size_of_array)
    @function = function.to_sym
    @array = Array.new(size_of_array) { rand(0...9) }
  end

  def evaluate
    @start_time = Time.now
    array.method(function)
    @end_time = Time.now
  end

  def diff_in_ms
    evaluate
    (@end_time - @start_time) * 1000.0
  end
 
end