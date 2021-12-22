class Data
  attr_reader :data_set

  def initialize
    @data_set = []
  end

  def collect(time)
    data_set.push(time)
  end

  def calc_median
    # return nil if data.empty?
    sorted = data_set.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end
end
