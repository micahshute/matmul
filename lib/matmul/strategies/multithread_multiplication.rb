class Matmul::MultithreadMultiplication

    def self.preprocess(m1, m2)
        return [m1,m2]
    end

    def self.multiply(m1, m2)
        # puts "HERE"
        threads = Array.new(m1.row_size * m2.column_size, nil)
        ma = Array.new(m1.row_size) do 
            Array.new(m2.column_size, nil)
        end
        m1.row_size.times do |rownum|
            m2.column_size.times do |colnum|
                threads[rownum * m2.column_size + colnum] = Thread.new do 
                    sum = 0
                    size = m1.row(rownum).size
                    for i in 0...size
                        sum += m1.row(rownum)[i] * m2.column(colnum)[i]
                    end
                    ma[rownum][colnum] = sum
                end
            end
        end
        threads.each(&:join)
        Matrix[*ma]
    end
end