require 'sample'

RSpec.describe Sample do
  describe '.setup' do
    it 'generates and array of random numbers and the given size' do
      allow(subject).to receive(:rand).and_return(0, 34, 65, 94, 22)
      subject.setup(5)

      expect(subject.sample_data.length).to eq(5)
      expect(subject.sample_data).to eq([0, 34, 65, 94, 22])
    end
  end
end
