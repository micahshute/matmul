module Matmul::CoreExtensions
    module MatrixMod
        module Multiplication
            def matmul(m, strat: :strassen)
                strats = {
                    :strassen => Matmul::StrassenMultiplication, 
                    :multithread => Matmul::MultithreadMultiplication
                }
                raise ArgumentError.new("strat must be :strassen or :multithread") if strats[strat].nil?
                strats[strat].multiply(self, m)
            end
        end

        module Slice
            def slice(rowrng, colrng)
                matarr = rowrng.map do |_|
                    colrng.map{|_| nil}.to_a
                end.to_a
                puts matarr.to_s
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