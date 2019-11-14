using Random

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
