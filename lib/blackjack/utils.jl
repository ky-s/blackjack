macro repeat(f, n)
    :(map(_ -> $(esc(f)), 1:$(esc(n))))
end
