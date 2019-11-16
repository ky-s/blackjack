repeat(f::Function, n::Integer) = map(i -> f(i), 1:n)
