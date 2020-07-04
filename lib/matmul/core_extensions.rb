module Matmul::CoreExtensions
    module MatrixMod
        module Multiplication
            def matmul(m, strat: :multithread)
                strats = {
                    :strassen => Matmul::StrassenMultiplication, 
                    :multithread => Matmul::MultithreadMultiplication
                }
                raise ArgumentError.new("strat must be :strassen or :multithread") if strats[strat].nil?
                raise Matrix::ErrDimensionMismatch if self.column_count != m.row_count
                m1, m2 = strats[strat].preprocess(self, m)
                strats[strat].multiply(m1, m2).slice(0...row_count, 0...m.column_count)
            end
        end

        module Slice
            def slice(rowrng, colrng)
                matarr = rowrng.map do |_|
                    colrng.map{|_| nil}.to_a
                end.to_a
                colrng.each do |col|
                    rowrng.each do |row|
                        matarr[row - rowrng.first][col - colrng.first] = self[row, col]
                    end
                end
                Matrix[*matarr]
            end
        end
    end
end

Matrix.include Matmul::CoreExtensions::MatrixMod::Slice
Matrix.include Matmul::CoreExtensions::MatrixMod::Multiplication