macro repeat(f, n)
    :(map(_ -> $(esc(f)), 1:$(esc(n))))
end

function sumlimit(seq::Array; limit::Integer)
    length(seq) == 0 && return 0
    length(seq) == 1 && return seq[1]
    seq[1] + seq[2] > limit && return seq[1]
    sumlimit([seq[1] + seq[2]; seq[3:end]], limit=limit)
end
