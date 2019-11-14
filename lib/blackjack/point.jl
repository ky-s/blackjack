# bust 判定
isbusted(point::Integer) = point > 21
isbusted(player::Player) = isbusted(point(player))

function dealer_tern(dealer::Player, deck::Deck)
    while point(dealer) < 17
        deal(dealer, deck)
    end
end

# 勝敗判定
function check(player::Player, dealer::Player)
    isbusted(player) && isbusted(dealer) && return even()
    isbusted(player) && return youlose()
    isbusted(dealer) && return youwin()

    point(player) > point(dealer)  && return youwin()
    point(player) == point(dealer) && return even()

    youlose()
end

# point 計算 (A は 11 か 1, Jack, Queen, King は 10, それ以外はそのまま)
function point(player::Player)
    p, aces = 0, 0
    for card in player.hands
        if card.number == 1
            aces += 1
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


