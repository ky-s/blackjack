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
        _cards = reshape([Card(suit, number) for suit in instances(SUITS), number in 1:13], 52)
        jorker && ( _cards = vcat(_cards, [Card()]) )
        new(Random.shuffle(_cards))
    end
end

struct Player
    hands::Array{Card}

    # Construtors
    Player(deck::Deck) = new(map(_ -> pop!(deck.cards), 1:2)) # 初期手札2枚をdeal
    Player() = new([])
end

# point 計算 (A は 11 か 1, Jack, Queen, King は 10, それ以外はそのまま)
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

    # A は bust しないように後で計算
    while aces > 0
        p += (p + 11 > 21 ? 1 : 11)
        aces -= 1
    end

    p
end

# bust 判定
isbusted(point::Integer) = point > 21
isbusted(player::Player) = isbusted(point(player))

show_hands(player::Player, label)   = println("\n", "[$label]", player.hands, " : point = ", point(player), isbusted(player) ? "(busted)" : "", "\n")
show_players_hands(player::Player)  = show_hands(player, "Player")
show_dealers_hands(dealer::Player)  = show_hands(dealer, "Dealer")
show_dealers_reveal(dealer::Player) = println("[dealer]", dealer.hands[1], "\n")

deal(player::Player, deck::Deck) = push!(player.hands, pop!(deck.cards))

function dealer_tern(dealer::Player, deck::Deck)
    while point(dealer) < 17
        deal(dealer, deck)
    end
end

# 勝敗判定
function check(player::Player, dealer::Player)
    isbusted(player) && isbusted(dealer) && println("even")
    isbusted(player) && return println("you lose")
    isbusted(dealer) && return println("you win")

    if point(player) > point(dealer)
        println("result: you win!")
    elseif point(player) == point(dealer)
        println("result: even")
    else
        println("result: you lose")
    end
end

# Player 入力受付
function player_input()
    print("Hit[h] or Stand[s] :")
    key = readline()
    key in ("s", "h") ? key : player_input()
end

function start()
    deck = Deck()
    player, dealer = Player(deck), Player(deck)

    show_players_hands(player)
    show_dealers_reveal(dealer)

    while player_input() == "h"
        deal(player, deck)
        show_players_hands(player)
        isbusted(player) && break
    end

    if !isbusted(player)
        dealer_tern(dealer, deck)
    end

    show_dealers_hands(dealer)

    check(player, dealer)
end
