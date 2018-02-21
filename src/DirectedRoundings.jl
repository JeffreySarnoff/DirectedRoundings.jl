module DirectedRoundings

export round_nearest, round_up, round_down, 
       round_tozero, round_fromzero,
       round_nearest_tiesaway, round_nearest_tiesup


#=
    •    RoundNearest (default)
      
    •    RoundNearestTiesAway
      
    •    RoundNearestTiesUp
      
    •    RoundToZero
      
    •    RoundFromZero
      
    •    RoundUp
      
    •    RoundDown
=#

@inline function rounded(fn::Function, a::T, 
                         mode::RoundingMode) where {T<:AbstractFloat}
     setrounding(T, mode) do
         fn(a)
     end
end

@inline function rounded(fn::Function, a::T, b::T, 
                         mode::RoundingMode) where {T<:AbstractFloat}
     setrounding(T, mode) do
         fn(a, b)
     end
end

@inline function rounded(fn::Function, a::T, b::T, c::T, 
                         mode::RoundingMode) where {T<:AbstractFloat}
     setrounding(T, mode) do
         fn(a, b, c)
     end
end

@inline function rounded(fn::Function, a::T, b::T, c::T, d::T,
                         mode::RoundingMode) where {T<:AbstractFloat}
     setrounding(T, mode) do
         fn(a, b, c, d)
     end
end


@inline round_nearest(fn::Function, a::T) where {T<:AbstractFloat} =
    rounded(fn, a, RoundNearest)
@inline round_nearest(fn::Function, a::T, b::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, RoundNearest)
@inline round_nearest(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, RoundNearest)
@inline round_nearest(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, d, RoundNearest)

@inline round_nearest_tiesaway(fn::Function, a::T) where {T<:AbstractFloat} =
    rounded(fn, a, RoundNearestTiesAway)
@inline round_nearest_tiesaway(fn::Function, a::T, b::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, RoundNearestTiesAway)
@inline round_nearest_tiesaway(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, RoundNearestTiesAway)
@inline round_nearest_tiesaway(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, d, RoundNearestTiesAway)

@inline round_nearest_tiesup(fn::Function, a::T) where {T<:AbstractFloat} =
    rounded(fn, a, RoundNearestTiesUp)
@inline round_nearest_tiesup(fn::Function, a::T, b::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, RoundNearestTiesUp)
@inline round_nearest_tiesup(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, RoundNearestTiesUp)
@inline round_nearest_tiesup(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, d, RoundNearestTiesUp)

@inline round_up(fn::Function, a::T) where {T<:AbstractFloat} =
    rounded(fn, a, RoundUp)
@inline round_up(fn::Function, a::T, b::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, RoundUp)
@inline round_up(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, RoundUp)
@inline round_up(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, d, RoundUp)

@inline round_down(fn::Function, a::T) where {T<:AbstractFloat} =
    rounded(fn, a, RoundDown)
@inline round_down(fn::Function, a::T, b::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, RoundDown)
@inline round_down(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, RoundDown)
@inline round_down(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, d, RoundDown)

@inline round_tozero(fn::Function, a::T) where {T<:AbstractFloat} =
    rounded(fn, a, RoundToZero)
@inline round_tozero(fn::Function, a::T, b::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, RoundToZero)
@inline round_tozero(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, RoundToZero)
@inline round_tozero(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, d, RoundToZero)

@inline round_fromzero(fn::Function, a::T) where {T<:BigFloat} =
    rounded(fn, a, RoundFromZero)
@inline round_fromzero(fn::Function, a::T, b::T) where {T<:BigFloat} =
    rounded(fn, a, b, RoundFromZero)
@inline round_fromzero(fn::Function, a::T, b::T, c::T) where {T<:BigFloat} =
    rounded(fn, a, b, c, RoundFromZero)
@inline round_fromzero(fn::Function, a::T, b::T, c::T, d::T) where {T<:BigFloat} =
    rounded(fn, a, b, c, d, RoundFromZero)

# other Floats

@inline round_fromzero(fn::Function, a::T) where {T<:AbstractFloat} =
    -rounded(fn, -a, RoundToZero)
@inline round_fromzero(fn::Function, a::T, b::T) where {T<:AbstractFloat} =
    -rounded(fn, -a, -b, RoundToZero)
@inline round_fromzero(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat} =
    -rounded(fn, -a, -b, -c, RoundToZero)
@inline round_fromzero(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat} =
-rounded(fn, -a, -b, -c, -d, RoundToZero)

end # DirectedRoundings module
