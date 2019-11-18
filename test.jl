include("./lib/blackjack.jl")

using .Blackjack: Player, Card,
                  SPADES, CLUBS, HEARTS, DIAMONDS,
                  point, isbusted, sumlimit
using Test

@testset "point calculation" begin
    player = Player()
    push!(player.hands, Card(DIAMONDS, 2))
    push!(player.hands, Card(HEARTS,   3))
    push!(player.hands, Card(CLUBS,    8))
    push!(player.hands, Card(SPADES,   9))
    @test 22 == point(player)
end

@testset "point calculation_with_JQK" begin
    player = Player()
    push!(player.hands, Card(DIAMONDS, 11))
    push!(player.hands, Card(HEARTS,   12))
    @test 20 == point(player)

    push!(player.hands, Card(DIAMONDS, 13))
    @test 30 == point(player)
end

@testset "point calculation_with_A" begin
    player = Player()
    push!(player.hands, Card(SPADES,    1))
    push!(player.hands, Card(SPADES,   10))
    @test 21 == point(player)

    push!(player.hands, Card(DIAMONDS, 12))
    @test 21 == point(player)
end

@testset "point calculation_with_multi_A" begin
    player = Player()
    push!(player.hands, Card(SPADES,   1))
    push!(player.hands, Card(CLUBS,    1))
    push!(player.hands, Card(HEARTS,   1))
    push!(player.hands, Card(DIAMONDS, 1))
    @test 14 == point(player)
end

@testset "isbusted" begin
    player = Player()
    push!(player.hands, Card(SPADES,   1))
    push!(player.hands, Card(SPADES,  11))
    @test !isbusted(player)
    push!(player.hands, Card(HEARTS,   1))
    @test !isbusted(player)
    push!(player.hands, Card(CLUBS,    9))
    @test !isbusted(player)
    push!(player.hands, Card(CLUBS,    1))
    @test isbusted(player)

    @test !isbusted(21)
    @test isbusted(22)
end

@testset "sumlimit" begin
    @test sumlimit([1, 10, 10, 10], limit=21)  == 21
    @test sumlimit([3, 10, 10, 10], limit=21)  == 13
    @test sumlimit([19], limit=21)             == 19
    @test sumlimit([21, 10, 10, 10], limit=21) == 21
    @test sumlimit([], limit=21)               == 0
end
