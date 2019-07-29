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
end
@testset "testing for zero" begin
    @test !iszero(c)
    @test iszero(z)
    @test_throws IndeterminateException iszero(a)
    @test_throws IndeterminateException iszero(b)
end
