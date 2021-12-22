class Sample
  attr_reader :sample_data

  SAMPLE_SIZES = [*1..20].map { |n| n * 50_000 }
  
  def initialize
    @sample_data = nil
  end

  def setup(sample_size)
    @sample_data = Array.new(sample_size) { rand(0...100) }
  end
end