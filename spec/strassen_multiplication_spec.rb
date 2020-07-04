RSpec.describe Matmul::StrassenMultiplication do 

  describe '#pad' do
    it "pads to the correct size" do
      r = Random.new
      m1a = 1000.times.map{ 784.times.map{ r.rand }}
      m1 = Matrix[*m1a]
      padded = Matmul::StrassenMultiplication.pad(m1, 1200)
      expect(padded.column_size).to eq(1200)
      expect(padded.row_size).to eq(1200)
      expect(padded[1100,1100]).to eq(0)
    end
  end

  

end

