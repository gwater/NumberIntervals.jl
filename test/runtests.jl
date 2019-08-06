
using Test
using NumberIntervals
import NumberIntervals: IndeterminateException

NumberIntervals.intercept_exception(::IndeterminateException) = false

const a = NumberInterval(-1, 0)
const b = NumberInterval(-0.5, 0.5)
const c = NumberInterval(0.5, 2)
const d = NumberInterval(0.25, 0.8)
const z = zero(NumberInterval)
const e = NumberInterval(Inf, -Inf)

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
    @test !isinteger(d)
end
@testset "isfinite" begin
    @test isfinite(a)
    @test isfinite(b)
    @test isfinite(c)
    @test isfinite(z)
    @test isfinite(NumberInterval(0., Inf))
    @test_throws IndeterminateException isfinite(e)
end
