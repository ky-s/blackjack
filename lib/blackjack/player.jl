struct Player
    hands::Array{Card}

    # Construtors
    Player(deck::Deck) = new(map(_ -> pop!(deck.cards), 1:2)) # 初期手札2枚をdeal
    Player() = new([])
end

