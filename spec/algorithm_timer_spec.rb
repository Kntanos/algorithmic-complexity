require ('algorithm_timer')
require ('data')

RSpec.describe Data do
 describe '.collect' do
   it 'puts the time in the data set' do 
    subject.collect(0.03)

    expect(subject.data_set.length).to eq(1)
   end
 end

 describe '.calc_median' do
   it 'calculates the median of the data set' do
    subject.collect(1) 
    subject.collect(2)
    subject.collect(3)
    subject.collect(4)

    expect(subject.calc_median).to eq(2.5)
   end
 end
end
