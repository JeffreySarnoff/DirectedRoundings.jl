module DirectedRoundings

export RoundNearest, RoundUp, RoundDown, 
       RoundToZero, RoundFromZero,
       RoundHiLo
       
import Base: RoundNearest, RoundUp, RoundDown, RoundToZero, RoundFromZero
             +, -, *, /, \, hypot, sqrt, cbrt,
             div, fld, cld, mod, rem, divrem, fldmod,
             abs, flipsign, copysign,

export  +, -, *, /, \, hypot, sqrt, cbrt,
        div, fld, cld, mod, rem, divrem, fldmod,
        abs, flipsign, copysign

using Base.Rounding

const RoundHiLo = RoundingMode{:HiLo}()

#=
    •    round the significand to use fewer bits
    
        •    RoundNearest (default)
        •    RoundUp
        •    RoundDown

    •    round the floating point value to an integer
    
        •    RoundToZero
        •    RoundFromZero
=#

# allow multiparameter operators taking 1, 2, 3, or 4 args

@inline RoundNearest(fn::Function, a::T) where {T<:AbstractFloat} =
    rounded(fn, a, RoundNearest)
@inline RoundNearest(fn::Function, a::T, b::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, RoundNearest)
@inline RoundNearest(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, RoundNearest)
@inline RoundNearest(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, d, RoundNearest)

@inline RoundUp(fn::Function, a::T) where {T<:AbstractFloat} =
    rounded(fn, a, RoundUp)
@inline RoundUp(fn::Function, a::T, b::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, RoundUp)
@inline RoundUp(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, RoundUp)
@inline RoundUp(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, d, RoundUp)

@inline RoundDown(fn::Function, a::T) where {T<:AbstractFloat} =
    rounded(fn, a, RoundDown)
@inline RoundDown(fn::Function, a::T, b::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, RoundDown)
@inline RoundDown(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, RoundDown)
@inline RoundDown(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, d, RoundDown)

@inline RoundToZero(fn::Function, a::T) where {T<:AbstractFloat} =
    rounded(fn, a, RoundToZero)
@inline RoundToZero(fn::Function, a::T, b::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, RoundToZero)
@inline RoundToZero(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, RoundToZero)
@inline RoundToZero(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat} =
    rounded(fn, a, b, c, d, RoundToZero)

# support RoundFromZero

@inline RoundFromZero(fn::Function, a::T) where {T<:BigFloat} =
    rounded(fn, a, RoundFromZero)
@inline RoundFromZero(fn::Function, a::T, b::T) where {T<:BigFloat} =
    rounded(fn, a, b, RoundFromZero)
@inline RoundFromZero(fn::Function, a::T, b::T, c::T) where {T<:BigFloat} =
    rounded(fn, a, b, c, RoundFromZero)
@inline RoundFromZero(fn::Function, a::T, b::T, c::T, d::T) where {T<:BigFloat} =
    rounded(fn, a, b, c, d, RoundFromZero)



@inline function RoundFromZero(fn::Function, a::T) where {T<:AbstractFloat}
    result = RoundUp(a, b)
    if result < 0
       result = RoundDown(a, b)
    end
    return result
end
@inline function RoundFromZero(fn::Function, a::T, b::T) where {T<:AbstractFloat}
    result = RoundUp(a, b)
    if result < 0
       result = RoundDown(a, b)
    end
    return result
end
@inline function RoundFromZero(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat}
    result = RoundUp(a, b, c)
    if result < 0
       result = RoundDown(a, b, c)
    end
    return result
end
@inline function RoundFromZero(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat}
    result = RoundUp(a, b, c, d)
    if result < 0
       result = RoundDown(a, b, c, d)
    end
    return result
end

# directed rounding in a functional context

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

# intervalic directed rounding in a functional context

@inline function RoundHiLo(fn::Function, a::T) where {T<:AbstractFloat}
     hi = rounded(fn, a, RoundUp)
     lo = rounded(fn, a, RoundDown)
     return minmax(hi, lo)
end

@inline function RoundHiLo(fn::Function, a::T, b::T) where {T<:AbstractFloat}
     hi = rounded(fn, a, b, RoundUp)
     lo = rounded(fn, a, b, RoundDown)
     return minmax(hi, lo)
end

@inline function RoundHiLo(fn::Function, a::T, b::T, c::T) where {T<:AbstractFloat}
     hi = rounded(fn, a, b, c, RoundUp)
     lo = rounded(fn, a, b, c, RoundDown)
     return minmax(hi, lo)
end

@inline function RoundHiLo(fn::Function, a::T, b::T, c::T, d::T) where {T<:AbstractFloat}
     hi = rounded(fn, a, b, c, d, RoundUp)
     lo = rounded(fn, a, b, c, d, RoundDown)
     return minmax(hi, lo)
end

end # DirectedRoundings module
