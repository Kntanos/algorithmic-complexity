class Exporter

  def export_csv(function, median, sample_size)
    CSV.open("#{function}_function.csv", 'a') do |csv|
      csv << [median].unshift(sample_size)
    end
  end
end
