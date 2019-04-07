using Random

@enum SUITS SPADES CLUBS HEARTS DIAMONDS
struct Card
    suit        ::  Union{SUITS,   Nothing}
    number      ::  Union{Integer, Nothing}
    isjorker    ::  Bool

    # Construtors
    Card(suit, number) = number in 1:13 ? new(suit, number, false) : error("out of number")
    Card()             = new(nothing, nothing, true) # for jorker
end

struct Deck
    cards::Array{Card}

    # Construtor
    Deck(;jorker=false) = begin
        _cards = reshape([Card(suit, number) for suit in instances(SUITS), number in 1:13], 52)
        jorker && ( _cards = vcat(_cards, [Card()]) )
        new(Random.shuffle(_cards))
    end
end

struct Player
    hands::Array{Card}
end

function point(player::Player)
    p, aces = 0, 0
    for card in player.hands
        if card.number == 1
            aces++
            continue
        elseif card.number >= 10
            p += 10
        else
            p += card.number
        end
    end

    while aces > 0
        p + 11 > 21 ? p += 1 : p += 11
    end
    return p
end

function start()
    deck = Deck()
    player, dealer = Player(map(i -> pop!(deck.cards), 1:2)), Player(map(i -> pop!(deck.cards), 1:2))
    @show player, dealer
    @show player.hands, point(player)
end

start()
