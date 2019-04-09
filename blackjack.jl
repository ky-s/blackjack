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
            aces += 1
            continue
        elseif card.number >= 10
            p += 10
        else
            p += card.number
        end
    end

    while aces > 0
        p + 11 > 21 ? p += 1 : p += 11
        aces -= 1
    end

    p
end

isbust(point::Integer)           = point > 21
show_hands(player::Player)       = println(player.hands, " : point = ", point(player), isbust(point(player)) ? "(busted)" : "")
deal(player::Player, deck::Deck) = push!(player.hands, pop!(deck.cards))

function dealer_do(dealer::Player, deck::Deck)
    while point(dealer) < 17
        deal(dealer, deck)
    end
end

function check(player::Player, dealer::Player)
    isbust(point(player)) && return println("you lose")
    if point(player) > point(dealer)
        println("you win")
    elseif point(player) == point(dealer)
        println("no contest")
    else
        println("you lose")
    end
end

function player_input()
    print("Stand[s], Hit[h] :")
    k = readline()
    k in ("s", "h") ? k : player_input()
    k
end

function start()
    deck = Deck()
    player, dealer = Player(map(i -> pop!(deck.cards), 1:2)), Player(map(i -> pop!(deck.cards), 1:2))
    show_hands(player)
    while player_input() == "h"
        deal(player, deck)
        print("[player]")
        show_hands(player)
    end

    dealer_do(dealer, deck)

    println("[dealer]")
    show_hands(dealer)

    check(player, dealer)
end

start()
