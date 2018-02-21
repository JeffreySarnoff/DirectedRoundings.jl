# DirectedRoundings.jl

## round floating point arithmetic as you direct



### The Rounding Modes

    •    RoundNearest (default)

    •    RoundUp
    •    RoundDown
        
    •    RoundToZero
    •    RoundFromZero

    •    RoundNearestTiesAway
    •    RoundNearestTiesUp
    
### The Exported Functions

    •   round_nearest
    
    •   round_up
    •   round_down 
    
    •   round_tozero
    •   round_fromzero
    
    •   round_nearest_tiesaway
    •   round_nearest_tiesup

### In Use

```julia
using DirectedRoundings

# arithmetic function examples
#   the directed rounding functions work with 1,2,3,4 params

function sqrt5x(a)
    sqrt(5*a)
end

function reldiff(a, b)
    return (a - b) / a
end

function affine_map(x, shift, scale)
    return (x + shift) * scale
end

function right_triangles_ratio(a_adjacent, a_opposite, 
                               b_adjacent, b_opposite)
    a_hypot = hypot(a_adjacent, a_opposite)
    b_hypot = hypot(b_adjacent, b_opposite)
    return a_hypot / b_hypot
end


a = 3.0;         aa =  eps(a)/2;
b = inv(17.0);   bb =  eps(b)/2;
c = 3.0f0;       cc = -eps(c)  ;
d = inv(17.0f0); dd = -eps(d)/2;

round_nearest(inv,a)
round_up(inv, a)
round_down(inv, a)
round_tozero(inv, a)
round_fromzero(inv, a)

round_up(+, a, b)
round_down(hypot, a, b)

round_up(affine_map, a, b, c)
round_down(affine_map, a, b, c)

round_nearest(right_triangles_ratio, a, sqrt(a), c, cbrt(c))
round_up(right_triangles_ratio, a, sqrt(a), c, cbrt(c))
round_down(right_triangles_ratio, a, sqrt(a), c, cbrt(c))

round_nearest_tiesaway( -, bhi, blo )
round_nearest_tiesup( -, bhi, blo )

