RSpec.describe Matmul do
  it "has a version number" do
    expect(Matmul::VERSION).not_to be nil
  end

  describe "#slice" do 
    it "accepts a row and column ranges and returns the appropriate submatrix" do
      r = Random.new
      ma = 1000.times.map{ 784.times.map{ r.rand }}
      m = Matrix[*ma]
      sm = m.slice(500...550, 600...700)
      expect(sm.row_size).to eq(50)
      expect(sm.column_size).to eq(100)
      expect(sm[5,5]).to eq(m[505,605])
    end
  end

  describe "#matmul" do
    it "performs an accurate matrix multiplication using the strassen method" do
      r = Random.new
      m1a = 120.times.map{ 720.times.map{ r.rand }}
      m2a = 120.times.map{ 720.times.map{ r.rand }}
      m1 = Matrix[*m1a]
      m2 = Matrix[*m2a]
      puts "Builtin"
      p1 = m1 * m2.transpose
      puts "Strassen"
      p2 = m1.matmul(m2.transpose, strat: :strassen)
      puts "Done"
      expect(p1.round(5)).to eq(p2.round(5))
    end

    it "performs an accurate multiplication using multithreading" do
      r = Random.new
      m1a = 120.times.map{ 120.times.map{ r.rand }}
      m2a = 120.times.map{ 120.times.map{ r.rand }}
      m1 = Matrix[*m1a]
      m2 = Matrix[*m2a]
      puts "Built in"
      p1 = m1 * m2.transpose
      puts "Multithread"
      p2 = m1.matmul(m2.transpose)
      puts "Done"
      expect(p1.round(10)).to eq(p2.round(10))
    end
  end

end
