
using Test
using NumberIntervals

const a = NumberInterval(-1, 0)
const b = NumberInterval(-0.5, 0.5)
const c = NumberInterval(0.5, 2)
const d = NumberInterval(0.25, 0.8)
const z = zero(NumberInterval)
const e = NumberInterval(Inf, -Inf)

@testset "number comparison" begin
    @test a < c
    @test c > a
    @test (a < b) isa Indeterminate
    @test (c > b) isa Indeterminate
    @test !(c < a)
    @test !(a > c)
    @test z == z
    @test z != c
    @test (a == b) isa Indeterminate
    @test (b != c) isa Indeterminate
    @test b <= c
end
@testset "testing for zero" begin
    @test !iszero(c)
    @test iszero(z)
    @test iszero(a) isa Indeterminate
    @test iszero(b) isa Indeterminate
end
@testset "test sign" begin
    @test signbit(c) == false
    @test signbit(-a) == false
    @test signbit(-c) == true
    @test signbit(a) isa Indeterminate
    @test sign(c) == 1
    @test sign(z) == 0
    @test sign(-c) == -1
    @test sign(b) isa Indeterminate
end
@testset "isinteger" begin
    @test isinteger(z)
    @test isinteger(NumberInterval(4))
    @test !isinteger(NumberInterval(4.5))
    @test isinteger(c) isa Indeterminate
    @test !isinteger(d)
end
@testset "isfinite" begin
    @test isfinite(a)
    @test isfinite(b)
    @test isfinite(c)
    @test isfinite(z)
    @test isfinite(NumberInterval(0., Inf))
    @test isfinite(e) isa Indeterminate
end
@testset "is_indeterminate_exception" begin
    function test_is_indeterminate_exception()
        try
            iszero(b) && true
        catch exc
            return is_indeterminate_exception(exc)
        end
        return false # fallback, in case not exception is raised
    end
    @test test_is_indeterminate_exception()
    @test !is_indeterminate_exception(UndefVarError(:bla))
end
@testset "Indeterminate" begin
    @test (Indeterminate() == true) isa Indeterminate
    @test (false == Indeterminate()) isa Indeterminate
    @test !Indeterminate() isa Indeterminate
end
@testset "IndeterminateException" begin
    @test_throws IndeterminateException throw(IndeterminateException())
    @test is_indeterminate_exception(IndeterminateException(a))
end
@testset "constructor" begin
    @test NumberInterval(a) === a
    @test NumberInterval{Float64}(a) === a
    @test NumberInterval{Float32}(4) isa NumberInterval{Float32}
    @test real(a) === a
    @test_throws ErrorException NumberInterval(2., 1.)
    @test isnan(NumberInterval(NaN))
    @test_throws ErrorException NumberInterval(Inf)
    @test_throws ErrorException NumberInterval(-Inf)
end
