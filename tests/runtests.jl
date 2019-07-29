
using Test
using NumberIntervals

a = NumberInterval(-1, 0)
b = NumberInterval(-0.5, 0.5)
c = NumberInterval(0.5, 2)
z = zero(NumberInterval)

@testset "number comparison" begin
    @test a < c
    @test c > a
    @test_throws IndeterminateException a < b
    @test_throws IndeterminateException c > b
    @test !(c < a)
    @test !(a > c)
    @test z == z
    @test z != c
    @test_throws IndeterminateException a == b
    @test_throws IndeterminateException b != c
    @test b <= c
end
@testset "testing for zero" begin
    @test !iszero(c)
    @test iszero(z)
    @test_throws IndeterminateException iszero(a)
    @test_throws IndeterminateException iszero(b)
end
@testset "test sign" begin
    @test signbit(c) == false
    @test signbit(-a) == false
    @test signbit(-c) == true
    @test_throws IndeterminateException signbit(a)
    @test sign(c) == 1
    @test sign(z) == 0
    @test sign(-c) == -1
    @test_throws IndeterminateException sign(b)
end
@testset "isinteger" begin
    @test isinteger(z)
    @test isinteger(NumberInterval(4))
    @test !isinteger(NumberInterval(4.5))
    @test_throws IndeterminateException isinteger(c)
end
