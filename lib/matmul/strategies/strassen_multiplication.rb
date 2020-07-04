require 'pry'
class Matmul::StrassenMultiplication

    def self.preprocess(m1, m2)
        if(m1.row_size != m1.column_size)
            max = [m1.row_size, m1.column_size].max
            max = max.even? ? max : max + 1
            return [pad(m1, max), pad(m2, max)]
        elsif m1.row_size.even?
            return [m1,m2]
        end
        pad_size = next_power_of_2([m1.row_size, m1.column_size, m2.row_size, m2.column_size].max)
        m1p = pad(m1, pad_size)
        m2p = pad(m2, pad_size)
        # puts pad_size
        return [m1p, m2p]
    end

    @@count = 0

    def self.multiply(m1, m2) 
        # puts m1.row_size
        # puts m1.column_size
        # puts m2.row_size
        # puts m2.column_size
        if(m1.column_size == 1 && m1.row_size == 1 && m2.column_size == 1 && m2.row_size == 1)
            # puts @@count += 1
            return m1 * m2
        end
        if(m1.column_size.odd? && m1.column_size < 100)
            return m1 * m2
        end
        a,b,c,d = quad_segment(m1)
        e,f,g,h = quad_segment(m2)
        p1 = multiply(a, f-h)
        p2 = multiply(a+b, h)
        p3 = multiply(c+d, e)
        p4 = multiply(d, g-e)
        p5 = multiply(a+d, e+h)
        p6 = multiply(b-d, g+h)
        p7 = multiply(a-c, e+f)

        q1 = p5 + p4 - p2 + p6
        q2 = p1 + p2
        q3 = p3 + p4
        q4 = p1 + p5 - p3 - p7
        # puts q1.hstack(q2).vstack(q3.hstack(q4))
        return q1.hstack(q2).vstack(q3.hstack(q4))
    end

    def self.pad(m, dim)
        rows_to_add = dim - m.row_size
        cols_to_add = dim - m.column_size
        if rows_to_add > 0
            bottom_rows = Matrix[*rows_to_add.times.map{Array.new(m.column_size, 0)}]
            rows_added = m.vstack(bottom_rows)
        else
            rows_added = m
        end
        if cols_to_add > 0
            added_cols = Matrix[*dim.times.map{Array.new(cols_to_add, 0)}]
            padded = rows_added.hstack(added_cols)
            padded
        else
            rows_added
        end 
    end

    private

    def self.quad_segment(m, size: nil)
        size = m.row_size if size.nil?
        return [
            m.slice(0...(size/2), 0...(size/2)), 
            m.slice(0...(size/2), (size/2)...size),
            m.slice((size/2)...size, 0...(size/2)),
            m.slice((size/2)...size, (size/2)...size)
        ]
    end 

    def self.next_power_of_2(num)
        2 ** Math.log(num, 2).ceil
    end
end

