function show_hands(player::Player, label)
    println("[ *** $label *** ]", "\n",
            player.hands, "\n",
            "point = ", point(player),
            isbusted(player) ? "(busted)" : "", "\n")
end

show_players_hands(player::Player)  = show_hands(player, "You")
show_dealers_hands(dealer::Player)  = show_hands(dealer, "Dealer")
show_dealers_reveal(dealer::Player) = println("[ ### dealer ### ]", "\n", dealer.hands[1], "\n")

youwin()  = println("    Result: You Win!!")
youlose() = println("    Result: You Lose!")
even()    = println("    Result: Even")

