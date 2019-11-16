using Random

@enum SUITS SPADES CLUBS HEARTS DIAMONDS

struct Card
    suit        ::  Union{SUITS,   Nothing}
    number      ::  Union{Integer, Nothing}
    isjorker    ::  Bool

    # Construtors
    Card(suit, number) = number in 1:13 ? new(suit, number, false) : error("out of number")
    Card()             = new(nothing, nothing, true) # for jorker (unused)
end

struct Deck
    cards::Array{Card}

    # Construtor
    Deck(;jorker=false) = begin
        _cards = reshape(
            [Card(suit, number) for suit in instances(SUITS), number in 1:13],
            52
        )
        jorker && ( _cards = vcat(_cards, [Card()]) )

        new(Random.shuffle(_cards))
    end
end

struct Player
    hands::Array{Card}

    # Construtors
    Player(cards::Array{Card}) = new(cards)
    Player() = new([])
end
