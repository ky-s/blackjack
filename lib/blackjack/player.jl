struct Player
    hands::Array{Card}

    # Construtors
    Player(cards::Array{Card}) = new(cards)
    Player() = new([])
end

