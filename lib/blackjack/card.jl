@enum SUITS SPADES CLUBS HEARTS DIAMONDS
struct Card
    suit        ::  Union{SUITS,   Nothing}
    number      ::  Union{Integer, Nothing}
    isjorker    ::  Bool

    # Construtors
    Card(suit, number) = number in 1:13 ? new(suit, number, false) : error("out of number")
    Card()             = new(nothing, nothing, true) # for jorker (unused)
end

function Base.show(io::IO, c::Card)
    c.isjorker && return print(io, "JORKER")
    n = c.number == 1 ? "A" : c.number
    print(io, n, " of ", c.suit)
end
