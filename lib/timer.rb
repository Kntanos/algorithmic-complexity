class Timer

  attr_reader :function, :array

  def initialize(function, size_of_array)
    @function = function.to_sym
    @array = Array.new(size_of_array) { rand(0...9) }
  end

  def evaluate
    start_time = Time.now
    array.method(function)
    end_time = Time.now
   
    end_time - start_time
  end

end