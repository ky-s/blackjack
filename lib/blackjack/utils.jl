macro repeat(f, n)
    :(map(_ -> $(esc(f)), 1:$(esc(n))))
end

# count up to max
# countup(1, 21, [10, 10, 10]) # => 21
# countup(3, 21, [10, 10, 10]) # => 13
# countup(19, 21, []) # => 19
# countup(21, 21, [10, 10, 10]) # => 21
function countup(v::Integer, max::Integer, rem::Array)
    length(rem) == 0 && return v
    v + rem[1] > max && return v
    countup(v + rem[1], max, rem[2:end])
end

