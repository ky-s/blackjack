deal(player::Player, deck::Deck) = push!(player.hands, pop!(deck.cards))

# Player 入力受付
function player_input()
    print("Hit[h] or Stand[s] :")
    key = readline()
    key in ("s", "h") ? key : player_input()
end

function dealer_tern(dealer::Player, deck::Deck)
    println("-------------------------------------------")
    println("    Dealer turn")
    println("-------------------------------------------")
    show_dealers_hands(dealer)
    sleep(1)
    while point(dealer) < 17
        deal(dealer, deck)
        show_dealers_hands(dealer)
        sleep(1)
    end
end

# game main
function start()
    println("===========================================", "\n")
    println("    Blackjack game : julia", "\n")
    println("===========================================")

    deck = Deck()
    # 初期手札2枚をdeal
    player = Player(map(_ -> pop!(deck.cards), 1:2))
    dealer = Player(map(_ -> pop!(deck.cards), 1:2))

    show_dealers_reveal(dealer)
    sleep(1)
    show_players_hands(player)
    sleep(1)

    while player_input() == "h"
        deal(player, deck)
        show_dealers_reveal(dealer)
        show_players_hands(player)
        isbusted(player) && break
        sleep(1)
    end

    !isbusted(player) && dealer_tern(dealer, deck)

    println("\n")
    println("-------------------------------------------")
    check(player, dealer)
    println("-------------------------------------------")

    show_players_hands(player)
    show_dealers_hands(dealer)
end
