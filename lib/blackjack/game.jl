deal(player::Player, deck::Deck) = push!(player.hands, pop!(deck.cards))

# Player 入力受付
function player_input()
    print("Hit[h] or Stand[s] :")
    key = readline()
    key in ("s", "h") ? key : player_input()
end

# game main
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
