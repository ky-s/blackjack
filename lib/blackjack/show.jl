function show_hands(player::Player, label)
    println("[$label]", player.hands,
            " : point = ", point(player),
            isbusted(player) ? "(busted)" : "", "\n")
end

show_players_hands(player::Player)  = show_hands(player, "Player")
show_dealers_hands(dealer::Player)  = show_hands(dealer, "Dealer")
show_dealers_reveal(dealer::Player) = println("[dealer]", dealer.hands[1], "\n")

youwin()  = println("result: you win!")
youlose() = println("result: you lose")
even()    = println("result: even")

