point(card::Card) = card.number < 10 ? card.number : 10
function point(player::Player)
    sumlimit([sum(point, player.hands); fill(10, countaces(player))], limit=21)
end

countaces(player::Player) = count(card -> card.number == 1, player.hands)

# bust 判定
isbusted(point::Integer) = point > 21
isbusted(player::Player) = point(player) |> isbusted

# 勝敗判定
# player, dealer 共に busted はありえない。
# player が busted の時点で dealer は hit しない。
function check(player::Player, dealer::Player)
    isbusted(player) && return -1
    isbusted(dealer) && return 1
    cmp(point.([player, dealer])...)
end
