deal(deck::Deck) = pop!(deck.cards)
deal(player::Player, deck::Deck) = push!(player.hands, deal(deck))

# Player 入力受付
function player_input()
    print("Hit[h] or Stand[s] :")
    key = readline()
    key in ("s", "h") ? key : player_input()
end

function player_turn(player::Player, dealer::Player, deck::Deck)
    player_label() |> show_turn
    while player_input() == "h"
        deal(player, deck)
        show_dealers_reveal(dealer)
        show_players_hands(player)
        isbusted(player) && break
        sleep(1)
    end
end

function dealer_tern(dealer::Player, player::Player, deck::Deck)
    dealer_label() |> show_turn
    show_dealers_hands(dealer)
    sleep(1)
    while point(dealer) < 17 && point(dealer) < point(player)
        deal(dealer, deck)
        show_dealers_hands(dealer)
        sleep(1)
    end
end

# game main
function start()
    clear()
    show_game_start()

    deck = Deck()
    # 初期手札2枚をdeal
    player = Player(@repeat(deal(deck), 2))
    dealer = Player(@repeat(deal(deck), 2))

    show_dealers_reveal(dealer)
    sleep(1)
    show_players_hands(player)
    sleep(1)

    player_turn(player, dealer, deck)

    !isbusted(player) && dealer_tern(dealer, player, deck)

    check(player, dealer) |> result_view |> show_result

    show_dealers_hands(dealer)
    show_players_hands(player)
end
