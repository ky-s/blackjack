function show_game_start()
    println("===========================================")
    println()
    println("    Blackjack game : julia")
    println()
    println("===========================================")
end

function show_result(result::AbstractString)
    println("===========================================")
    println()
    println("    Result: $(result)")
    println()
    println("===========================================")
end

function show_turn(label)
    println("-------------------------------------------")
    println("    $label turn")
    println("-------------------------------------------")
end

# card
function Base.show(io::IO, c::Card)
    c.isjorker && return print(io, "JORKER")
    n = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"][c.number]
    print(io, "[", n, " of ", c.suit, "]")
end

Base.show(io::IO, ca::Array{Card}) = print(io, join(ca, ", "))

player_label() = "You"
dealer_label() = "Dealer"

function show_hands(player::Player, label)
    println("[ *** $label *** ]", "\n",
            player.hands, "\n",
            "point = ", point(player),
            isbusted(player) ? "(busted)" : "", "\n")
end

show_players_hands(player::Player)  = show_hands(player, player_label())
show_dealers_hands(dealer::Player)  = show_hands(dealer, dealer_label())
show_dealers_reveal(dealer::Player) = println("[ ### dealer ### ]", "\n", dealer.hands[1], "\n")

function result_view(c)
    c == 1 && return "You Win!!"
    c == 0 && return "Even"
    "You Lose!"
end

clear() = run(`clear`)

